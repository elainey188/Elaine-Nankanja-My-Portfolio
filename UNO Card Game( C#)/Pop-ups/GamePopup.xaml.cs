using System;
using System.ComponentModel;
using System.Linq;
using System.Threading;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Forms;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Threading;
using Application = System.Windows.Application;
using KeyEventArgs = System.Windows.Input.KeyEventArgs;

namespace UNO_Game
{
    /// <summary>
    /// Interaction logic for GamePopup.xaml
    /// </summary>
    public partial class GamePopup : Window
    {
        private bool Fullscreen;
        public GamePopup()
        {
            InitializeComponent();
            Fullscreen = Properties.Settings.Default.Window_Mode == "Fullscreen";

        }

        private void SelectedComboBox()
        {
            var backgroundbrush = GetGameWindow().Background as ImageBrush;
            var background = backgroundbrush.ImageSource.ToString().Substring(55);
            background = background.Substring(0, 1);

            // Gameboard Color
            GameBoardCombo.SelectedIndex = int.Parse(background);

            // Window Mode Selected
            WindowCombo.SelectedIndex = Fullscreen ? 1 : 0;

        }

        private void GamePopup_OnKeyDown(object sender, KeyEventArgs e)
        {
            if (e.Key == Key.Escape)
            {
                Close();
            }
        }

        private void MenuButton_Click(object sender, RoutedEventArgs e)
        {
            DialogResult result = System.Windows.Forms.MessageBox.Show("Your game will end and you can't return.", "Are you sure?", MessageBoxButtons.OKCancel, MessageBoxIcon.Warning);

            if (result == System.Windows.Forms.DialogResult.OK)
            {
                MainWindow MainMenu = new MainWindow();
                GetGameWindow().PopupClose = true;
                Owner.Close();
                MainMenu.Show();
            }
            
        }

        private void ResumeButton_OnClickButton_Click(object sender, RoutedEventArgs e)
        {
            Close();
        }

        private void GameBoardCombo_OnSelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            var selection = GameBoardCombo.SelectedItem.ToString().Split(new[] {": "}, StringSplitOptions.None).Last();

            switch (selection)
            {
                case "Red":
                    GetGameWindow().Background = new ImageBrush(new BitmapImage(new Uri(@"pack://application:,,,/UNO Game;component/Assets/Table_0.png")));
                    Properties.Settings.Default.Background_Color = 0;
                    break;
                case "Purple":
                    GetGameWindow().Background = new ImageBrush(new BitmapImage(new Uri(@"pack://application:,,,/UNO Game;component/Assets/Table_1.png")));
                    Properties.Settings.Default.Background_Color = 1;
                    break;
                case "Dark Green":
                    GetGameWindow().Background = new ImageBrush(new BitmapImage(new Uri(@"pack://application:,,,/UNO Game;component/Assets/Table_2.png")));
                    Properties.Settings.Default.Background_Color = 2;
                    break;
                case "Blue":
                    GetGameWindow().Background = new ImageBrush(new BitmapImage(new Uri(@"pack://application:,,,/UNO Game;component/Assets/Table_3.png")));
                    Properties.Settings.Default.Background_Color = 3;
                    break;
                case "Green":
                    GetGameWindow().Background = new ImageBrush(new BitmapImage(new Uri(@"pack://application:,,,/UNO Game;component/Assets/Table_4.png")));
                    Properties.Settings.Default.Background_Color = 4;
                    break;
            }
        }

        private void WindowCombo_OnSelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            var selection = WindowCombo.SelectedItem.ToString().Split(new[] { ": " }, StringSplitOptions.None).Last();

            switch (selection)
            {
                case "Fullscreen":
                    Owner.WindowState = WindowState.Maximized;
                    Owner.WindowStyle = WindowStyle.None;
                    Properties.Settings.Default.Window_Mode = "Fullscreen";
                    Fullscreen = true;
                    break;
                case "Windowed":
                    Owner.WindowState = WindowState.Normal;
                    Owner.WindowStyle = WindowStyle.SingleBorderWindow;
                    Properties.Settings.Default.Window_Mode = "Windowed";
                    Fullscreen = false;
                    break;
            }
        }

        private void WindowCombo_Loaded(object sender, RoutedEventArgs e)
        {
            //Setting Combo Boxes current selection
            SelectedComboBox();
        }

        private void GamePopup_OnClosing(object sender, CancelEventArgs e)
        {
            Properties.Settings.Default.Save();
        }


        private GameWindow GetGameWindow()
        {
            GameWindow gameWindow = null;
            foreach (Window window in Application.Current.Windows)
            {
                if (window.GetType() == typeof(GameWindow))
                {
                    gameWindow = (GameWindow)window;
                }
            }
            return gameWindow;
        }
    }
}
