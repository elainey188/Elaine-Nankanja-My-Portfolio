using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UNO_Game
{
    /**
     * <summary>Deck of UNO Cards</summary>
     */
    class Deck
    {
        private ObservableCollection<Card> _cards = new ObservableCollection<Card>();

        private static readonly Random RandSeed = new Random();

        /**
         * <summary>Getter for _cards</summary>
         * <returns>_cards variable</returns>
         */
        public ObservableCollection<Card> Cards()
        {
            return _cards;
        }
        
        /**
         * <summary>Draws the first card and removes it from the deck. Returning it.</summary>
         * <returns>Drawn card</returns>
         */
        public Card DrawCard()
        {
            Card tempCard = _cards.First();

            _cards.RemoveAt(0);

            return tempCard;
        }

        /**
         * <summary>Draws a card from the specified index and removes it from deck. Returning the card.</summary>
         * <param name="cardIndex">The index of the card to draw.</param>
         * <returns>Drawn card</returns>
         */
        public Card DrawCard(int cardIndex)
        {
            Card tempCard = _cards[cardIndex];

            _cards.RemoveAt(cardIndex);

            return tempCard;
        }

        /**
         * <summary>Draws a list of cards specific by an int.
         * Removes all the cards from the deck and returns it.</summary>
         * <param name="drawNum">The number of cards to draw</param>
         * <returns>List of drawn cards.</returns>
         */
        public List<Card> DrawCards(int drawNum)
        {
            List<Card> tempList = new List<Card>();

            for (int x = drawNum; x > 0; x--)
            {
                tempList.Add(_cards[0]);

                _cards.RemoveAt(0);
            }

            return tempList;
        }

        /**
         * <summary>Adds 52 cards to the deck and shuffles it.</summary>
         */
        public void NewDeck()
        {
            string inColor = "";
            string inValue = "";
            
            for (int colour = 1; colour <= 4; colour++)
            {
                for (int value = 1; value <= 12; value ++)
                {
                    switch (colour)
                    {
                        case 1:
                            inColor = "Red";
                            break;
                        case 2:
                            inColor = "Blue";
                            break;
                        case 3:
                            inColor = "Yellow";
                            break;
                        case 4:
                            inColor = "Green";
                            break;
                    }

                    switch (value)
                    {
                        case 10:
                            inValue = "Skip";
                            break;
                        case 11:
                            inValue = "Draw";
                            break;
                        case 12:
                            inValue = "Reverse";
                            break;
                        default:
                            inValue = value.ToString();
                            break;
                    }

                    _cards.Add(new Card(inColor, inValue));
                }
            }

            _cards.Add(new Card("Wild", "Draw4"));
            _cards.Add(new Card("Wild", "Draw4"));
            _cards.Add(new Card("Wild", "Wild"));
            _cards.Add(new Card("Wild", "Wild"));

            Shuffle();
        }

        /**
         * <summary>Uses Fisher-Yates shuffle to shuffle deck</summary>
         */
        public void Shuffle()
        {
            for (int n = _cards.Count - 1; n > 0; --n)
            {
                int k = RandSeed.Next(n + 1);
                Card temp = _cards[n];
                _cards[n] = _cards[k];
                _cards[k] = temp;
            }
        }


        /**
         * <summary>Adds card to the deck.</summary>
         * <param name="card">The card to be added to the deck.</param>
         */
        public void AddCard(Card card)
        {
            _cards.Add(card);
        }

        /**
         * <summary>Returns the number of cards in the deck</summary>
         * <returns>Number of cards in deck</returns>
         */
        public int RemainingCards()
        {
            return _cards.Count;
        }

        /**
         * <summary>Outputs the deck information in a string.</summary>
         * <returns>String of each card in deck.</returns>
         */
        public string OutputDeckInformation()
        {
            string collection = "[";

            foreach (var card in _cards)
            {
                collection += $" {card},";
            }
            collection += "]";

            return collection;
        }
    }
}
