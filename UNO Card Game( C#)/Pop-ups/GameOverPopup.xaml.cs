using System;
using System.Windows;
using System.Windows.Media;

namespace UNO_Game
{
    /// <summary>
    /// Interaction logic for GameOverPopup.xaml
    /// </summary>
    public partial class GameOverPopup
    {
        private MediaPlayer mediaPlayer = new MediaPlayer();
        public bool StartNewGame;

        public GameOverPopup()
        {
            InitializeComponent();

            WinOrLose();
        }

        private void WinOrLose()
        {
            string outcome;

            outcome = GetGameWindow().IsPlayerWin ? "Win" : "Lose";

            WinLosetb.Text = $"You {outcome}";

            mediaPlayer.Open(new Uri($"{GameWindow.effectspath}{outcome}.mp3", UriKind.RelativeOrAbsolute));
            mediaPlayer.Volume = 0.3;
            mediaPlayer.Play();
        }

        private void PlayAgainbtn_OnClick(object sender, RoutedEventArgs e)
        {
            StartNewGame = true;
            Close();
        }

        private void BackToMenubtn_OnClick(object sender, RoutedEventArgs e)
        {
            MainWindow mainmenu = new MainWindow();
            Close();
            Owner.Close();
            mainmenu.Show();
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