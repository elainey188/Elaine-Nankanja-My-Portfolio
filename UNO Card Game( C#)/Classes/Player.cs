// Player.cs
// Author: Ben Cecutti
// Basic Player Class
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UNO_Game
{
    /**
     * <summary>Class of Player with Gamedeck</summary>
     */
    class Player
    {
        private int PlayerID { get; set; }
        public string Name { get; private set; }
        public Deck Hand { get; set; }
        public bool AIFlag { get; private set; }
        
        /**
         * <summary>Parameterized constructor with name, AI and ID</summary>
         * <param name="name">The players name</param>
         * <param name="IsAI">Whether the player is an AI or not</param>
         * <param name="playerId">The PlayerID</param>
         */
        public Player(string name, bool IsAI, int playerId)
        {
            Name = name;
            Hand = new Deck();
            AIFlag = IsAI;
            PlayerID = playerId;
        }

        /**
         * <summary>Adds a card to players deck</summary>
         * <param name="card">Card to add</param>
         */
        public void DrawCard(Card card)
        {
            Hand.AddCard(card);
        }

        /**
         * <summary>Adds a list of cards to players deck</summary>
         * <param name="Cards">List of cards to add</param>
         */
        public void DrawCard(List<Card> Cards)
        {
            foreach (var card in Cards)
            {
                Hand.AddCard(card);
            }
        }

        /**
         * <summary>Removes a card from the players hand and returns it.</summary>
         * <param name="cardIndex">Index of the card</param>
         * <returns>The drawn card.</returns>
         */
        public Card PlayCard(int cardIndex)
        {
            return Hand.DrawCard(cardIndex);
        }

        /**
         * <summary>Players ID, Name and AI flag.</summary>
         * <returns>String of Player object</returns>
         */
        public override string ToString()
        {
            return $"Player ID: {PlayerID}\nName: {Name} \nAI: {AIFlag}";
        }
    }
}
