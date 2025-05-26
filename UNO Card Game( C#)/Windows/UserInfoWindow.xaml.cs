using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Windows;
using System.Windows.Media.Imaging;
using OpenFileDialog = Microsoft.Win32.OpenFileDialog;

namespace UNO_Game
{
    public partial class UserInfoWindow : Window
    {
        public UserInfoWindow()
        {
            InitializeComponent();

            UpdateProfilePic();

            UserNameLabel.Text = Properties.Settings.Default.Users_Name;

            FillOutDatabaseInfo();
        }

        /**
         * <summary>Fills out the players game information to the window view</summary>
         */
        private void FillOutDatabaseInfo()
        {
            // Check if Database connection is not open
            if (UnoGame.sql.State != ConnectionState.Open)
            {
                UnoGame.sql.Open();
            }

            SqlCommand cmd = new SqlCommand("SELECT GamesPlayed FROM UserData", UnoGame.sql);
            LblGamesPlayed.Content = cmd.ExecuteScalar();
          

            cmd = new SqlCommand("SELECT GamesWon FROM UserData", UnoGame.sql);
            LblGamesWon.Content = cmd.ExecuteScalar();

            cmd = new SqlCommand("SELECT GamesLost FROM UserData", UnoGame.sql);
            LblGamesLost.Content = cmd.ExecuteScalar();

            UnoGame.sql.Close();
        }

        /**
         * <summary>Brings up namePopup and changes the players name</summary>
         */
        private void ChangeNameBtn_OnClick(object sender, RoutedEventArgs e)
        {
            // Adds name popup window since popups aren't easy to work with
            NamePopup namePopup = new NamePopup
            {
                Owner = this,
                ShowInTaskbar = false
            };

            // Code only executes once the window is closed
            if (namePopup.ShowDialog() == false)
            {
                if (!string.IsNullOrEmpty(namePopup.Name))
                {
                    UserNameLabel.Text = namePopup.Name;
                }
            }

            if (UnoGame.sql.State != ConnectionState.Open)
            {
                UnoGame.sql.Open();
            }
            
            // Update UserName
            SqlCommand cmd = new SqlCommand("SELECT GamesPlayed FROM UserData", UnoGame.sql);

            cmd = new SqlCommand($"UPDATE UserData" +
                                        " SET Name = @Name", UnoGame.sql);

            cmd.Parameters.AddWithValue("@Name", UserNameLabel.Text);
            cmd.ExecuteNonQuery();

        }
        
        /**
         * <summary>Opens an OpenFileDialog for a new picture and replaces the current one</summary>
         */
        private void ChangePicBtn_OnClick(object sender, RoutedEventArgs e)
        {
            var openFileDialog = new OpenFileDialog
            {
                Title = "Select New Picture",
                Filter = "Images(*.BMP; *.JPG; *.GIF,*.PNG,*.TIFF)| *.BMP; *.JPG; *.GIF; *.PNG; *.TIFF",
                CheckFileExists = true,
                CheckPathExists = true
            };


            string profilepicpath = Path.GetFullPath(Path.Combine(Environment.CurrentDirectory, @"..\..\")) + @"Assets\profile-pic.png";

            // Saves the image & overwrites current profile-pic image
            if (openFileDialog.ShowDialog() == true)
            { 
                string file = openFileDialog.FileName;

                File.Copy(file, profilepicpath, true);
                ProfilePic.Source = new BitmapImage(new Uri(file));
            }
        }

        /**
         * <summary>Updates the current profile pic with the new one from ChangePicBtn</summary>
         */
        private void UpdateProfilePic()
        {
            // https://stackoverflow.com/questions/1688545/problems-overwriting-re-saving-image-when-it-was-set-as-image-source working thanks to this
            // Image loaded is stored in cache. This fixes it so it updates when its changed.
            var uriSource = new Uri(Path.GetFullPath(Path.Combine(Environment.CurrentDirectory, @"..\..\")) + @"Assets\profile-pic.png", UriKind.Relative);
            var imgTemp = new BitmapImage();
            imgTemp.BeginInit();
            imgTemp.CacheOption = BitmapCacheOption.OnLoad;
            imgTemp.CreateOptions = BitmapCreateOptions.IgnoreImageCache;
            imgTemp.UriSource = uriSource;
            imgTemp.EndInit();
            ProfilePic.Source = imgTemp;
        }

        /**
         * <summary>Resets players game statistics</summary>
         */
        private void ResetStatsBtn_OnClick(object sender, RoutedEventArgs e)
        {
            UnoGame.sql.Open();
            SqlCommand cmd = new SqlCommand("UPDATE UserData SET GamesPlayed = 0, GamesWon = 0, GamesLost = 0", UnoGame.sql);
            cmd.ExecuteScalar();
            UnoGame.sql.Close();

            //Reset the view
            FillOutDatabaseInfo();
        }
    }
}