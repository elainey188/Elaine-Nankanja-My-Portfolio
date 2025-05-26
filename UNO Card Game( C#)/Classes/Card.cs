// Card.cs
// Author: Ben Cecutti
// Basic Card Class
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Media.Imaging;

namespace UNO_Game
{
    /**
     * <summary>Card class for an UNO Card</summary>
     */
    class Card
    {
        public string Color { get; private set; }

        public string Value { get; private set; }

        private static int ID = 0;

        public int CardID { get; private set; }

        public BitmapImage CardImage { get; private set; }

        /**
         * <summary>Parameterized constructor with values to set.</summary>
         * <param name="inColor">The color to set the card.</param>
         * <param name="inValue">The value or number to set the card.</param>
         */
        public Card(string inColor, string inValue)
        {

            CardID = System.Threading.Interlocked.Increment(ref ID);

            Color = inColor;

            Value = inValue;
            var cardLink = System.IO.Path.GetFullPath(System.IO.Path.Combine(Environment.CurrentDirectory, @"..\..\")) + $@"Assets\{ Color }_{ Value }.png";
            CardImage = new BitmapImage(new Uri(cardLink));
        }

        /**
         * <summary>Default constructor that creates a null card that has face down image.</summary>
         */
        public Card()
        {
            CardID = System.Threading.Interlocked.Increment(ref ID);

            Color = "Null";

            Value = "Null";
            var cardLink = System.IO.Path.GetFullPath(System.IO.Path.Combine(Environment.CurrentDirectory, @"..\..\")) + $@"Assets\Deck.png";
            CardImage = new BitmapImage(new Uri(cardLink));
        }

        /**
         * <summary>Sets the new cards color and image.</summary>
         * <param name="newColor">New color to set to</param>
         */
        public void SetColor(string newColor)
        {
            Color = newColor;

            var cardLink = System.IO.Path.GetFullPath(System.IO.Path.Combine(Environment.CurrentDirectory, @"..\..\")) + $@"Assets\{ Color }_{ Value }.png";
            CardImage = new BitmapImage(new Uri(cardLink));
        }

        /**
         * <summary>ToString of the cards Color and Value</summary>
         * <returns>String of Color and Value of card</returns>
         */
        public override string ToString()
        {
            return Color + "_" + Value;
        }
    }
}
