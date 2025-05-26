using System.Windows;

namespace UNO_Game
{
    public partial class SettingsWindow : Window
    {
        public SettingsWindow()
        {
            InitializeComponent();

            // Sets which button will be selected
            DifficultyButton();

            // Checks values of house rules
            HouseRulesSwitches();

        }

        /**
         * <summary>Sets the selected difficulty button setting based on properties.settings..</summary>
         */
        private void DifficultyButton()
        {
            // Check what difficulty option is saved
            switch (Properties.Settings.Default.AI_Difficulty)
            {
                // Easy = 1
                case 1:
                    EasyButton.IsChecked = true;
                    break;
                // Medium = 2
                case 2:
                    MediumButton.IsChecked = true;
                    break;
                // Hard = 3
                case 3:
                    HardButton.IsChecked = true;
                    break;
            }
        }

        /**
         * <summary>Sets AI_Difficulty to easy.</summary>
         */
        private void EasyButton_OnClick(object sender, RoutedEventArgs e)
        {
            Properties.Settings.Default.AI_Difficulty = 1;
        }

        /**
         * <summary>Sets AI_Difficulty to medium.</summary>
         */
        private void MediumButton_OnClick(object sender, RoutedEventArgs e)
        {
            Properties.Settings.Default.AI_Difficulty = 2;
        }

        /**
         * <summary>Sets AI_Difficulty to hard.</summary>
         */
        private void HardButton_OnClick(object sender, RoutedEventArgs e)
        {
            Properties.Settings.Default.AI_Difficulty = 3;
        }

        /**
         * <summary>Saves set AI_Difficulty.</summary>
         */
        private void Window_Closing(object sender, System.ComponentModel.CancelEventArgs e)
        {
            Properties.Settings.Default.Save();
        }

        /**
         * <summary>Sets whether radiobuttons are checked or not.</summary>
         */
        private void HouseRulesSwitches()
        {
            // +2 Stack Switch
            StackCheck.IsChecked = Properties.Settings.Default.Stack_2;
            // Keep Drawing Switch
            KeepDrawingCheck.IsChecked = Properties.Settings.Default.Keep_Drawing;
        }

        /**
         * <summary>Sets KeepDrawing rule</summary>
         */
        private void KeepDrawingCheck_OnClick(object sender, RoutedEventArgs e)
        {
            Properties.Settings.Default.Keep_Drawing = KeepDrawingCheck.IsChecked.Value;
        }

        /**
         * <summary>Sets Stack_2 rule</summary>
         */
        private void StackCheck_Click(object sender, RoutedEventArgs e)
        {
            Properties.Settings.Default.Stack_2 = StackCheck.IsChecked.Value;
        }

    }
}
