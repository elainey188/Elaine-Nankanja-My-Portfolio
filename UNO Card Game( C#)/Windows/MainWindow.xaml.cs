using System;
using System.Windows;
using System.Windows.Media;

namespace UNO_Game
{
    public partial class MainWindow : Window
    {
        private MediaPlayer mediaPlayer = new MediaPlayer();
        // For opening window only once
        private SettingsWindow settingsWindow = null;
        private InfoWindow infoWindow = null;
        private UserInfoWindow userInfoWindow = null;

        public MainWindow()
        {
            InitializeComponent();
            ResizeMode = ResizeMode.CanMinimize;

          
            // For SQL
            AppDomain.CurrentDomain.SetData("DataDirectory",
                System.IO.Path.GetFullPath(System.IO.Path.Combine(Environment.CurrentDirectory, @"..\..\")));

        }

        /**
         * <summary>Plays background music.</summary>
         */
        private void PlayBackgroundMusic()
        {
            string musicfile = System.IO.Path.GetFullPath(System.IO.Path.Combine(Environment.CurrentDirectory, @"..\..\")) + @"Assets\Music\Wallpaper.mp3";

            mediaPlayer.Open(new Uri(musicfile));
            mediaPlayer.Play();

            mediaPlayer.MediaEnded += (sender, args) =>
            {
                mediaPlayer.Open(new Uri(musicfile));
                mediaPlayer.Play();
            };
        }

        /**
         * <summary>Closes the window</summary>
         */
        private void QuitButton_OnClick(object sender, RoutedEventArgs e)
        {
            Close();
        }

        /**
         * <summary>Opens SettingsWindow</summary>
         */
        private void SettingsButton_OnClick(object sender, RoutedEventArgs e)
        {
            if (settingsWindow == null)
            {
                settingsWindow = new SettingsWindow
                {
                    Owner = this,
                    ResizeMode = ResizeMode.NoResize,
                };

                settingsWindow.Closed += (o, args) => settingsWindow = null;
                settingsWindow.Show();
            }
        }

        /**
         * <summary>Opens InfoWindow</summary>
         */
        private void InfoButton_Click(object sender, RoutedEventArgs e)
        {
            if (infoWindow == null)
            {
                infoWindow = new InfoWindow
                {
                    Owner = this,
                    ResizeMode = ResizeMode.NoResize,
                };

                infoWindow.Closed += (o, args) => infoWindow = null;
                infoWindow.Show();
            }
        }

        /**
         * <summary>Opens UserInfoWindow</summary>
         */
        private void StatsButton_Click(object sender, RoutedEventArgs e)
        {
            if (userInfoWindow == null)
            {
                userInfoWindow = new UserInfoWindow
                {
                    Owner = this,
                    ResizeMode = ResizeMode.NoResize,
                };

                userInfoWindow.Closed += (o, args) => userInfoWindow = null; 
                userInfoWindow.Show();
            }
        }

        /**
         * <summary>Opens GameWindow</summary>
         */
        private void PlayButton_Click(object sender, RoutedEventArgs e)
        {
            GameWindow gameWindow = new GameWindow
            {
                ResizeMode = ResizeMode.CanMinimize
            };

            gameWindow.Show();
            Close();
        }

        /**
         * <summary>Stops music when window closes.</summary>
         */
        private void Window_Closing(object sender, System.ComponentModel.CancelEventArgs e)
        {
            mediaPlayer.Stop();
        }
    }
}
