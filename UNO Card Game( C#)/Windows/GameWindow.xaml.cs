using System;
using System.ComponentModel;
using System.Linq;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Forms;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Effects;
using System.Windows.Media.Imaging;
using UNO_Game.Properties;
using Button = System.Windows.Controls.Button;
using KeyEventArgs = System.Windows.Input.KeyEventArgs;
using Path = System.IO.Path;

namespace UNO_Game
{
    /**
     * <summary>GameWindow that opens a new game of Uno</summary>
     */
    public partial class GameWindow : Window
    {
        public static string effectspath = System.IO.Path.GetFullPath(System.IO.Path.Combine(Environment.CurrentDirectory, @"..\..\")) + @"Assets\Music\Effects\";
        private MediaPlayer mediaPlayer = new MediaPlayer();
        private UnoGame unoGame;
        public bool IsPlayerWin { get; set; }
        private Card tempCard { get; set; }
        private bool GameOver;
        public bool PopupClose;
        private GamePopup gamePopup = null;

        public GameWindow()
        {
            InitializeComponent();

            

            // Set user name
            UserNamelbl.Text = Settings.Default.Users_Name;

            UpdateProfilePic();

            SizeChange();

            // Start UNOGame
            unoGame = new UnoGame();
            FillOutDecks();

            Background = new ImageBrush(new BitmapImage(new Uri($@"pack://application:,,,/UNO Game;component/Assets/Table_{Properties.Settings.Default.Background_Color}.png")));
        }

        /**
         * <summary>Checks Window Mode setting and sets window size accordingly.</summary>
         */
        private void SizeChange()
        {
            switch (Settings.Default.Window_Mode)
            {
                case "Fullscreen":
                    WindowStyle = WindowStyle.None;
                    WindowState = WindowState.Maximized;
                    break;
                case "Windowed":
                    WindowStyle = WindowStyle.SingleBorderWindow;
                    WindowState = WindowState.Normal;
                    break;
            }
        }

        /**
         * <summary>Links the ListViews to the respective Players Decks.</summary>
         */
        private void FillOutDecks()
        {
            // User Deck
            ListViewCards.ItemsSource = unoGame.PlayerList[0].Hand.Cards();

            // CPU-1
            ListViewCPU1.ItemsSource = unoGame.PlayerList[1].Hand.Cards();

            // CPU-2
            ListViewCPU2.ItemsSource = unoGame.PlayerList[2].Hand.Cards();

            // CPU-3
            ListViewCPU3.ItemsSource = unoGame.PlayerList[3].Hand.Cards();

            // Discard
            DiscardPile.ItemsSource = unoGame.DiscardPile.Cards();
        }

        /**
         * <summary>Updates profile picture in case it was changed in UserInfo window.</summary>
         */
        private void UpdateProfilePic()
        {
            // https://stackoverflow.com/questions/1688545/problems-overwriting-re-saving-image-when-it-was-set-as-image-source working thanks to this
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
         * <summary>Plays background music while the game is playing.</summary>
         */
        private void PlayBackgroundMusic()
        {
            string musicfile = Path.GetFullPath(Path.Combine(Environment.CurrentDirectory, @"..\..\")) + @"Assets\Music\Late-Night-Radio.mp3";

            mediaPlayer.Open(new Uri(musicfile));
            mediaPlayer.Play();

            mediaPlayer.MediaEnded += (sender, args) =>
            {
                mediaPlayer.Open(new Uri(musicfile));
                mediaPlayer.Play();
            };
        }

        /**
         * <summary>Opens GamePopup on Esc key pressed.</summary>
         */
        private void GameWindow_OnKeyDown(object sender, KeyEventArgs e)
        {
            if (gamePopup == null)
            {
                if (e.Key == Key.Escape)
                {
                    gamePopup = new GamePopup
                    {
                        Owner = this,
                        ResizeMode = ResizeMode.NoResize,
                        ShowInTaskbar = false,
                    };

                    MainGrid.IsHitTestVisible = false;
                    gamePopup.Closed += (o, args) =>
                    {
                        gamePopup = null;
                        MainGrid.IsHitTestVisible = true;
                    };
                    gamePopup.Show();

                }
            }
            else
            {
                gamePopup.Close();
            }
        }

        /**
         * <summary>Checks if the card clicked can be played.
         * If it can will remove it from deck and play it, ending players turn.</summary>
         */
        public void CardImage_OnMouseDown(object sender, MouseButtonEventArgs e)
        {
            // cast to object for tag
            var c = (Image)sender;
            var ID = (int)c.Tag;
            var CardList = unoGame.PlayerList[0].Hand.Cards();


            var Card = CardList.Where(x => x.CardID == ID);

            foreach (var card in Card.ToList())
            {
                var CardIndex = CardList.IndexOf(CardList.First(x => x.CardID == card.CardID));

                if (card.Color == "Wild")
                {
                    ColorPopup.Visibility = Visibility.Visible;
                    tempCard = card;
                }
                else
                {
                    unoGame.PlayerTurn(CardList.ToList()[CardIndex], CardIndex);
                }
            }
        }

        /**
         * <summary>Sets the UnoButtonPressed boolean to true.
         * Resets at the beginning of their turn.</summary>
         */
        private void UNOButton_OnClick(object sender, RoutedEventArgs e)
        {
            unoGame.UnoButtonPressed = true;
        }

        /**
         * <summary>Sets current players glow to indicate who's turn it is.</summary>
         * <param name="PlayerName">Current PlayerName to light up correct picture border</param>
         */
        public void SetCurrentPlayerGlow(string PlayerName)
        {
            // Reset all borders
            switch (PlayerName)
            {
                case "Player 2":
                    CPU1Pic.BorderThickness = new Thickness(5);
                    CPU2Pic.BorderThickness = new Thickness(0);
                    CPU3Pic.BorderThickness = new Thickness(0);
                    PlayerPic.BorderThickness = new Thickness(0);
                    break;
                case "Player 3":
                    CPU2Pic.BorderThickness = new Thickness(5);
                    CPU1Pic.BorderThickness = new Thickness(0);
                    CPU3Pic.BorderThickness = new Thickness(0);
                    PlayerPic.BorderThickness = new Thickness(0);
                    break;
                case "Player 4":
                    CPU3Pic.BorderThickness = new Thickness(5);
                    CPU1Pic.BorderThickness = new Thickness(0);
                    CPU2Pic.BorderThickness = new Thickness(0);
                    PlayerPic.BorderThickness = new Thickness(0);
                    break;
                default:
                    PlayerPic.BorderThickness = new Thickness(5);
                    CPU1Pic.BorderThickness = new Thickness(0);
                    CPU2Pic.BorderThickness = new Thickness(0);
                    CPU3Pic.BorderThickness = new Thickness(0);
                    break;
            }
        }

        /**
         * <summary>Checks whether Human player won or not and brings up GameOverPopUp.</summary>
         * <param name="PlayerWin">boolean whether Human player won</param>
         */
        public void EndOfGame(bool PlayerWin)
        {
            mediaPlayer.Stop();

            GameOver = true;
            IsPlayerWin = PlayerWin;

            var gameover = new GameOverPopup { Owner = this };
            Effect = new BlurEffect();
            Opacity = 0.5;
            IsHitTestVisible = false;
            gameover.Show();

            gameover.Closed += delegate
            {
                if (!gameover.StartNewGame) return;
                StartNewGame();
                mediaPlayer.Play();
                Opacity = 1;
                Effect = null;
                IsHitTestVisible = true;
            };
        }

        /**
         * <summary>Starts a new game.</summary>
         */
        private void StartNewGame()
        {
            unoGame = new UnoGame();
            FillOutDecks();
        }

        /**
         * <summary>When MainWindow is moved makes sure Popups follow.</summary>
         */
        private void GameWindow_OnLocationChanged(object sender, EventArgs e)
        {
            foreach (Window win in OwnedWindows)
            {
                win.Top = Top + ((ActualHeight - win.ActualHeight) / 2);
                win.Left = Left + ((ActualWidth - win.ActualWidth) / 2);
            }
        }

        /**
         * <summary>When ColorChange popup is clicked changes the wild card to the clicked color.</summary>
         */
        public void ChangeUserColor(object sender, RoutedEventArgs routedEventArgs)
        {
            var color = sender as Button;
            ColorPopup.Visibility = Visibility.Hidden;

            unoGame.SetUserTurnColor(color.Tag.ToString(), tempCard);
        }

        /**
         * <summary>When GameWindow is closing makes sure to allow the option to cancel only if game isn't over.</summary>
         */
        private void GameWindow_OnClosing(object sender, CancelEventArgs e)
        {
            mediaPlayer.Stop();
            unoGame = null;
            if (GameOver || PopupClose) return;
            DialogResult result = System.Windows.Forms.MessageBox.Show("Your game will end and you can't return.", "Are you sure?", MessageBoxButtons.OKCancel, MessageBoxIcon.Warning);

            if (result == System.Windows.Forms.DialogResult.OK)
            {
                MainWindow MainMenu = new MainWindow();
                MainMenu.Show();
            }
        }

        /**
         * <summary>Allows for passing of turn.
         * Only pops up if the player is allowed to pass.</summary>
         */
        private void PassButton_OnClick(object sender, RoutedEventArgs e)
        {
            unoGame.EndTurn();
        }
    }
}
