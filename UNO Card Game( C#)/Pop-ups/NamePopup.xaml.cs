using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;

namespace UNO_Game
{
    /// <summary>
    /// Interaction logic for NamePopup.xaml
    /// </summary>
    public partial class NamePopup : Window
    {
        // Set this for returning for UserInfo window
        public new string Name { get; set; }

        public NamePopup()
        {
            InitializeComponent();
        }

        private void SubmitButton_Click(object sender, RoutedEventArgs e)
        {
            // Makes sure input isn't null or empty
            if(!string.IsNullOrEmpty(Username.Text))
            {
                Name = Properties.Settings.Default.Users_Name = Username.Text;
                Properties.Settings.Default.Save();
                Close();
            }
        }

        private void CancelButton_Click(object sender, RoutedEventArgs e)
        {
            Close();
        }
    }
}
