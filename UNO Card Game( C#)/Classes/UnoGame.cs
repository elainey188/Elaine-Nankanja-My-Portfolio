using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Media;

namespace UNO_Game
{
    /**
     * <summary>Game of UNO</summary>
     */
    class UnoGame
    {
        public Deck GameDeck { get; private set; }
        public List<Player> PlayerList { get; private set; }
        public Deck DiscardPile { get; private set; }
        public static SqlConnection sql = new SqlConnection(Properties.Settings.Default.DB_con_string);
        private string sqlDate;
        private readonly Random random = new Random();
        private bool skippedTurn;
        private bool isTurn1 = true;
        private bool reversed = true;
        private Card activeCard;
        private MediaPlayer mediaPlayer = new MediaPlayer();
        public bool UnoButtonPressed;
        private bool wasCardPlayed;
        private int DrawNumofCards = 2;

        /**
         * <summary>Sets up a new game of UNO and starts it.</summary>
         */
        public UnoGame()
        {
            GameDeck = new Deck();
            DiscardPile = new Deck();
            PlayerList = new List<Player>();

            GameDeck.NewDeck();

            DiscardPile.AddCard(DrawCard());
            activeCard = DiscardPile.Cards().Last();

            // Make sure first card isn't wild (against rules)
            while (activeCard.Color == "Wild")
            {
                DiscardPile.AddCard(DrawCard());
                activeCard = DiscardPile.Cards().Last();
            }

            // 4 Players Add
            for (int i = 1; i <= 4; i++)
            {
                if (i == 1)
                {
                    // Add User Player
                    AddPlayer(new Player(Properties.Settings.Default.Users_Name, false, i));
                }
                else
                {
                    AddPlayer(new Player($"Player {i}", true, i));
                }
            }

            DealCards();
            PlayerList[1].DrawCard(new Card("Wild", "Wild"));
            RecordStartGame();

            // To Start Player 1's turn
            TurnLogic();
        }


        // ----------------------- GAME UTILITY FUNCTIONS -----------------------
        
        /**
         * <summary>Adds a Player to PlayerList.</summary>
         * <param name="Player">Player that will be added to the PlayerList</param>
         */
        public void AddPlayer(Player Player)
        {
            PlayerList.Add(Player);
        }

        /**
         * <summary>Deals 7 Cards to every Player within the PlayerList.</summary>
         */
        public void DealCards()
        {
            foreach (var player in PlayerList)
            {
                player.DrawCard(GameDeck.DrawCards(7));
            }
        }

        /**
         * <summary>Takes the top card off of the DiscardPile and saves it
         * while all the other cards are added to the GameDeck and gets shuffled. </summary>
         */
        public void Reshuffle()
        {
            Card tempCard = DiscardPile.Cards().Last();

            foreach (var card in DiscardPile.Cards().ToList())
            {
                GameDeck.AddCard(DiscardPile.DrawCard());
            }

            GameDeck.Shuffle();

            DiscardPile.AddCard(tempCard);
        }

        /**
         * <summary>Checks to see if the deck has enough cards to be drawn to the player.
         * If not it reshuffles and returns a drawn card.</summary>
         * <returns>The drawn card</returns>
         */
        private Card DrawCard()
        {
            if (GameDeck.RemainingCards() == 0)
            {
                Reshuffle();
            }
            

            mediaPlayer.Open(new Uri($"{GameWindow.effectspath}Draw.mp3", UriKind.RelativeOrAbsolute));
            mediaPlayer.Play();

            return GameDeck.DrawCard();
        }

        /**
         * <summary>Draws multiple Cards.</summary>
         * <param name="cardCount">Number of cards to be drawn.</param>
         * <returns>List of drawn cards</returns>
         */
        private List<Card> DrawCard(int cardCount)
        {
            List<Card> addCards = new List<Card>();

            for (int x = 0; x < cardCount; x++)
            {
                addCards.Add(DrawCard());
            }

            return addCards;
        }

        /**
         * <summary>Checks if the Player has no cards left.</summary>
         * <returns>Boolean whether the player has no cards remaining</returns>
         */
        private bool GameWon()
        {
            if (PlayerList[0].Hand.RemainingCards() == 0)
            {
                return true;
            }

            return false;
        }

        /**
         * <summary>Ends the game and brings up the GameWindow EndofGame function.</summary>
         * <param name="PlayerWon">The player who won</param>
         */
        private void EndGame(Player PlayerWon)
        {
            bool playerWin = PlayerWon.AIFlag == false;

            GetGameWindow().EndOfGame(playerWin);
        }


        /**
         * <summary>Replaces the active card and adds it to the discard pile.</summary>
         * <param name="playedCard">The card that was played</param>
         */
        public void PlayCard(Card playedCard)
        {
            DiscardPile.AddCard(playedCard);
            activeCard = playedCard;
            wasCardPlayed = true;

            // For +2 Stacking
            if (playedCard.Value == "Draw")
            {
                PlayDraw2 = true;
            }

            if (playedCard.Color == "Wild")
            {
                if (PlayerList[0].AIFlag)
                {
                    AIWildDecision();
                    return;
                }
            }
            else
            {
                RecordPlayAction("Play");
            }
        }


        /**
         * <summary>Reverses the turn order, keeping the current player at the top.</summary>
         */
        public void ReverseTurnOrder()
        {
            Player tempPlayer = PlayerList[0];

            PlayerList.RemoveAt(0);

            PlayerList.Reverse();

            PlayerList.Insert(0, tempPlayer);
        }

        private int NumberofTurns = 0;
        private bool PlayDraw2 = false;
        // ----------------------- TURN LOGIC FUNCTIONS -----------------------

        /**
         * <summary>All the turn logic, ending of turn and checking of other cards occurs.
         * Gets called at the beginning of players turn</summary>
         */
        public void TurnLogic()
        {
            // Reset UNO Button per turn
            UnoButtonPressed = false;

            // For database to output picked up cards
            List<Card> drawnCards = new List<Card>();

            NumberofTurns++;
            if (NumberofTurns == 10)
            {
                Record10thTurn();
                NumberofTurns = 0;
            }

            // Check for wild and draw 4's to turn back into wild color
            var Test = DiscardPile.Cards().Where(c => c.Value == "Wild" || c.Value == "Draw4");
            foreach (var card in Test)
            {
                if (card != activeCard)
                {
                    DiscardPile.Cards()[DiscardPile.Cards().IndexOf(card)].SetColor("Wild");
                }

            }

            GetGameWindow().SetCurrentPlayerGlow(PlayerList[0].Name);

            // special card logic
            if (activeCard.Value == "Draw" && skippedTurn == false && isTurn1 == false)
            {
                if (Properties.Settings.Default.Stack_2)
                {
                    var UserDeck = PlayerList.First().Hand.Cards().Where(c => c.Value == "Draw");
                    var userDeck = UserDeck.ToList();
                    if (userDeck.Any() && PlayDraw2)
                    {
                        // Add option to choose which +2
                        PlayCard(userDeck.First());
                        PlayerList.First().Hand.Cards().Remove(userDeck.First());
                        DrawNumofCards += 2;
                        EndTurn();
                        return;
                    }
                    else
                    {
                        skippedTurn = true;
                        PlayDraw2 = false;
                        PlayerList[0].DrawCard(drawnCards = DrawCard(DrawNumofCards));
                        //Database Log
                        RecordPlayAction("Draw", drawnCards);
                        // Reset drawcard int after someones drawn the cards(and reset the stack)
                        DrawNumofCards = 2;

                        EndTurn();
                        return;
                    }
                }
                else
                {
                    skippedTurn = true;
                    PlayerList[0].DrawCard(drawnCards = DrawCard(2));
                    //Database Log
                    RecordPlayAction("Draw", drawnCards);
                    EndTurn();
                    return;
                }

            }
            else if (activeCard.Value == "Draw4" && skippedTurn == false)
            {
                skippedTurn = true;
                PlayerList[0].DrawCard(drawnCards = DrawCard(4));
                RecordPlayAction("Draw", drawnCards);
                EndTurn();
                return;
            }
            else if (activeCard.Value == "Skip" && skippedTurn == false && isTurn1 == false)
            {
                skippedTurn = true;
                RecordPlayAction("Skip");
                EndTurn();
                return;
            }
            isTurn1 = false;

            // check if player needs to draw a card
            bool boolCheck = ValidCardCheck();
            bool DrewCard = false;
            if (Properties.Settings.Default.Keep_Drawing)
            {
                if (!boolCheck)
                {
                    while (!boolCheck)
                    {
                        if (DiscardPile.RemainingCards() == 0 & GameDeck.RemainingCards() == 0)
                        {
                            EndTurn();
                            return;
                        }
                        
                        PlayerList[0].DrawCard(DrawCard());
                        drawnCards.Add(PlayerList[0].Hand.Cards().Last());
                        RecordPlayAction("Draw", drawnCards);
                        boolCheck = ValidCardCheck();
                    }
                }
            }
            else
            {
                if (!boolCheck)
                {
                    PlayerList[0].DrawCard(DrawCard());
                    drawnCards.Add(PlayerList[0].Hand.Cards().Last());
                    RecordPlayAction("Draw", drawnCards);
                    boolCheck = ValidCardCheck();
                    DrewCard = true;
                }
                if (!boolCheck)
                {
                    RecordPlayAction("Pass");
                    EndTurn();
                    return;
                }

                if (DrewCard)
                {
                    if (!PlayerList.First().AIFlag)
                    {
                        GetGameWindow().PassButton.Visibility = Visibility.Visible;
                    }
                }
            }
            skippedTurn = false;
            reversed = false;


            // initiate player turns
            if (PlayerList[0].AIFlag)
            {
                Task.Factory.StartNew(async () =>
                {
                    await Task.Delay(1000);

                    // it only works in WPF
                    Application.Current.Dispatcher.Invoke(() =>
                    {
                        AITurn();
                    });
                });
            }
            else
            {
                GetGameWindow().ListViewCards.IsHitTestVisible = true;
            }
        }

        /**
         * <summary>Checks deck size, reverse card played &  </summary>
         */
        public void EndTurn()
        {
            if (GameWon())
            {
                EndGame(PlayerList[0]);
                RecordEndOfGame();
                return;
            }

            if (activeCard.Value == "Reverse" && reversed == false)
            {
                ReverseTurnOrder();
                reversed = true;
            }

            // Fix Players hand being able to play on skips
            GetGameWindow().ListViewCards.IsHitTestVisible = false;
            GetGameWindow().PassButton.Visibility = Visibility.Hidden;

            if (PlayerList.First().Hand.RemainingCards() == 1 && PlayerList.First().AIFlag == false && wasCardPlayed)
            {
                // adds delay to feel like real actions
                Task.Factory.StartNew(async () =>
                {
                    await Task.Delay(2000);

                    Application.Current.Dispatcher.Invoke(() =>
                    {
                        // Check if user has one card and pressed uno button
                        if (!UnoButtonPressed)
                        {
                            PlayerList.First().DrawCard(DrawCard(4));
                        }

                        var tempPlayer = PlayerList[0];
                        PlayerList.RemoveAt(0);
                        PlayerList.Add(tempPlayer);
                        TurnLogic();
                    });
                });
            }
            else
            {
                var tempPlayer = PlayerList[0];
                PlayerList.RemoveAt(0);
                PlayerList.Add(tempPlayer);

                if (skippedTurn || PlayerList[0].AIFlag == false)
                {
                    TurnLogic();
                }
                else
                {
                    Task.Factory.StartNew(async () =>
                    {
                        await Task.Delay(1000);

                        Application.Current.Dispatcher.Invoke(TurnLogic);
                    });
                }
            }
        }


        // ----------------------- PLAYER BEHAVIOR FUNCTIONS -----------------------

        /**
         * <summary>Logic for players turn. Only called in GameWindow card click.</summary>
         * <param name="card">Card that is played</param>
         * <param name="index">Index for card for proper removal and playing</param>
         */
        public void PlayerTurn(Card card, int index)
        {
            bool CorrectCard = false;

            if (card.Color == activeCard.Color || card.Value == activeCard.Value)
            {
                PlayCard(PlayerList[0].PlayCard(index));

                CorrectCard = true;
            }
            if (!CorrectCard) return;

            // Disable users cards at end of turn
            GetGameWindow().ListViewCards.IsHitTestVisible = false;
            EndTurn();
        }

        public void SetUserTurnColor(string color, Card playedCard)
        {
            PlayCard(playedCard);
            // Remove the card as well
            PlayerList[0].Hand.Cards().Remove(playedCard);
            activeCard.SetColor(color);

            EndTurn();
        }

        /**
         * <summary>AI's logic. Dependent on AI_Difficulty setting</summary>
         */
        public void AITurn()
        {
            // For determining easy, medium and hard
            var AI_Difficulty = Properties.Settings.Default.AI_Difficulty;

            switch (AI_Difficulty)
            {
                // Easy
                case 1:
                    EasyAI();
                    break;
                // Medium
                case 2:
                    MediumAI();
                    break;
                // Hard
                case 3:
                    HardAI();
                    break;
            }

            EndTurn();
        }

        /**
         * <summary>Easy AI turn Logic</summary>
         */
        private void EasyAI()
        {
            foreach (var card in PlayerList[0].Hand.Cards().ToList())
            {
                int index = PlayerList[0].Hand.Cards().IndexOf(PlayerList[0].Hand.Cards().FirstOrDefault(x => x.CardID == card.CardID));

                if (card.Color == activeCard.Color || card.Value == activeCard.Value)
                {
                    PlayCard(PlayerList[0].PlayCard(index));
                    return;

                }
                else if (card.Color == "Wild")
                {
                    PlayCard(PlayerList[0].PlayCard(index));
                    return;
                }

            }
        }

        /**
         * <summary>Medium AI turn Logic</summary>
         */
        private void MediumAI()
        {
            foreach (var card in PlayerList[0].Hand.Cards().ToList())
            {
                int index = PlayerList[0].Hand.Cards().IndexOf(PlayerList[0].Hand.Cards().FirstOrDefault(x => x.CardID == card.CardID));

                if (card.Color == activeCard.Color)
                {
                    PlayCard(PlayerList[0].PlayCard(index));
                    return;

                }
                else if (card.Value == activeCard.Value)
                {
                    PlayCard(PlayerList[0].PlayCard(index));
                    return;
                }
                else if (card.Color == "Wild")
                {
                    PlayCard(PlayerList[0].PlayCard(index));
                    return;
                }

            }
        }

        /**
         * <summary>Hard AI turn Logic. Advanced decision making.</summary>
         */
        private void HardAI()
        {
            // will bias towards making players with lower card counts than itself draw
            if (PlayerList[1].Hand.RemainingCards() < PlayerList[0].Hand.RemainingCards())
            {
                foreach (var card in PlayerList[0].Hand.Cards().ToList())
                {
                    int index = PlayerList[0].Hand.Cards().IndexOf(PlayerList[0].Hand.Cards().FirstOrDefault(x => x.CardID == card.CardID));

                    if (card.Color == activeCard.Color && card.Value == "Draw")
                    {
                        PlayCard(PlayerList[0].PlayCard(index));
                        return;

                    }
                    else if (card.Value == activeCard.Value && card.Value == "Draw")
                    {
                        PlayCard(PlayerList[0].PlayCard(index));
                        return;

                    }
                    else if (card.Color == "Wild" && card.Value == "Draw")
                    {
                        PlayCard(PlayerList[0].PlayCard(index));
                        return;
                    }
                }
            }

            // will bias towards making players with low card counts skip
            if (PlayerList[1].Hand.RemainingCards() <= 3)
            {
                foreach (var card in PlayerList[0].Hand.Cards().ToList())
                {
                    int index = PlayerList[0].Hand.Cards().IndexOf(PlayerList[0].Hand.Cards().FirstOrDefault(x => x.CardID == card.CardID));

                    if (card.Color == activeCard.Color && card.Value == "Skip")
                    {
                        PlayCard(PlayerList[0].PlayCard(index));
                        return;

                    }
                    else if (card.Value == activeCard.Value && card.Value == "Skip")
                    {
                        PlayCard(PlayerList[0].PlayCard(index));
                        return;

                    }
                }
            }

            // will bias towards reversing turn order if players with low card counts would otherwise go next
            if (PlayerList[1].Hand.RemainingCards() <= 3 && PlayerList[3].Hand.RemainingCards() > 3)
            {
                foreach (var card in PlayerList[0].Hand.Cards().ToList())
                {
                    int index = PlayerList[0].Hand.Cards().IndexOf(PlayerList[0].Hand.Cards().FirstOrDefault(x => x.CardID == card.CardID));

                    if (card.Color == activeCard.Color && card.Value == "Reverse")
                    {
                        PlayCard(PlayerList[0].PlayCard(index));
                        return;

                    }
                    else if (card.Value == activeCard.Value && card.Value == "Reverse")
                    {
                        PlayCard(PlayerList[0].PlayCard(index));
                        return;

                    }
                }
            }

            // will change color if it benefits AI
            if (ColorChangeCheck())
            {
                foreach (var card in PlayerList[0].Hand.Cards().ToList())
                {
                    int index = PlayerList[0].Hand.Cards().IndexOf(PlayerList[0].Hand.Cards().FirstOrDefault(x => x.CardID == card.CardID));

                    if (card.Color == LargestColor(ColorCanChangeTo()) && card.Value == activeCard.Value)
                    {
                        PlayCard(PlayerList[0].PlayCard(index));
                        return;

                    }
                }
            }

            //  will try to avoid playing special cards if above conditions were not met
            foreach (var card in PlayerList[0].Hand.Cards().ToList())
            {
                int index = PlayerList[0].Hand.Cards().IndexOf(PlayerList[0].Hand.Cards().FirstOrDefault(x => x.CardID == card.CardID));

                if (card.Value != "Skip" && card.Value != "Draw" && card.Value != "Reverse")
                {
                    if (card.Color == activeCard.Color || card.Value == activeCard.Value)
                    {
                        PlayCard(PlayerList[0].PlayCard(index));
                        return;

                    }
                    else if (card.Color == "Wild")
                    {
                        PlayCard(PlayerList[0].PlayCard(index));
                        return;
                    }
                }
            }

            // will otherwise resort to default decision making
            foreach (var card in PlayerList[0].Hand.Cards().ToList())
            {
                int index = PlayerList[0].Hand.Cards().IndexOf(PlayerList[0].Hand.Cards().FirstOrDefault(x => x.CardID == card.CardID));


                if (card.Color == activeCard.Color || card.Value == activeCard.Value)
                {
                    PlayCard(PlayerList[0].PlayCard(index));
                    return;

                }
                else if (card.Color == "Wild")
                {
                    PlayCard(PlayerList[0].PlayCard(index));
                    return;
                }

            }
        }

        /**
         * <summary>Determines which color for AI to select for wild card</summary>
         */
        public void AIWildDecision()
        {
            var AI_Difficulty = Properties.Settings.Default.AI_Difficulty;

            if (AI_Difficulty == 1)
            {
                switch (random.Next(1, 4))
                {
                    case 1:
                        activeCard.SetColor("Red");
                        break;
                    case 2:
                        activeCard.SetColor("Blue");
                        break;
                    case 3:
                        activeCard.SetColor("Yellow");
                        break;
                    case 4:
                        activeCard.SetColor("Green");
                        break;
                }
                return;
            }

            // Medium and Hard AI Wild Logic
            activeCard.SetColor(LargestColor());
            RecordPlayAction("Wild");
        }


        // ----------------------- BEHAVIOUR UTILITY FUNCTIONS -----------------------
        
        /**
         * <summary>Checks if the player has any usable cards.
         * If not returns false and draws a card</summary>
         * <returns>boolean whether the player has any valid cards to play</returns>
         */
        private bool ValidCardCheck()
        {
            var boolCheck = false;

            foreach (var card in PlayerList[0].Hand.Cards().ToList())
            {
                if (card.Color == activeCard.Color || card.Value == activeCard.Value)
                {
                    boolCheck = true;
                }
                else if (card.Color == "Wild")
                {
                    boolCheck = true;
                }
            }
            return boolCheck;
        }

        /**
         * <summary>AI decision for best color to change to.</summary>
         */
        private bool ColorChangeCheck()
        {
            var boolCheck = false;

            foreach (var card in PlayerList[0].Hand.Cards().ToList())
            {
                if (card.Color != activeCard.Color && card.Value == activeCard.Value)
                {
                    boolCheck = true;
                }
            }

            return boolCheck;
        }

        /**
         * <summary>Returns a collection of possible colors the AI can change the color to.</summary>
         */
        private List<string> ColorCanChangeTo()
        {
            List<string> possibleColors = new List<string>();

            foreach (var card in PlayerList[0].Hand.Cards().ToList())
            {
                if (card.Color != activeCard.Color && card.Value == activeCard.Value)
                {
                    possibleColors.Add(card.Color);
                }
            }

            return possibleColors;
        }

        /**
         * <summary>Returns color with the largest number of cards from a selection of colors.</summary>
         */
        private string LargestColor(List<string> possibleColors)
        {
            string largestColor = "";

            foreach (var color in possibleColors)
            {
                if (CardColorCheck(color) > CardColorCheck(largestColor))
                {
                    largestColor = color;
                }
            }

            return largestColor;
        }

        /**
         * <summary>Returns number of cards in hand of a specified color.</summary>
         */
        private int CardColorCheck(string color)
        {
            var cardNum = 0;

            foreach (var card in PlayerList[0].Hand.Cards().ToList())
            {
                if (card.Color == color)
                {
                    cardNum++;
                }
            }

            return cardNum;
        }

        /**
         * <summary>Returns string of most common color in hand, defaulting to the active color.</summary>
         */
        private string LargestColor()
        {
            string largestColor = "Red";
            int colorCount = CardColorCheck("Red");

            if (colorCount < CardColorCheck("Red"))
            {
                largestColor = "Red";
                colorCount = CardColorCheck("Red");
            }
            if (colorCount < CardColorCheck("Blue"))
            {
                largestColor = "Blue";
                colorCount = CardColorCheck("Blue");
            }
            if (colorCount < CardColorCheck("Green"))
            {
                largestColor = "Green";
                colorCount = CardColorCheck("Green");
            }
            if (colorCount < CardColorCheck("Yellow"))
            {
                largestColor = "Yellow";
            }
            return largestColor;
        }


        // ----------------------- DATABASE FUNCTIONS -----------------------

        /**
         * <summary>Creates a table with the current date and time with the starting card and players starting hands.</summary>
         */
        private void RecordStartGame()
        {
            string currenttime = DateTime.Now.ToString("MM_dd_yyyy_HH_mm_ss");
            string PlayerOutput = null;
            // For inserting data into the right table
            sqlDate = currenttime;

            if (sql.State != ConnectionState.Open)
            {
                sql.Open();
            }

            string statement = $@"CREATE TABLE Game_{currenttime}" +
                               "(ActionID INTEGER IDENTITY(1,1) PRIMARY KEY, ActionTime DATETIME, ActionDescription VARCHAR(MAX))";

            SqlCommand cmd = new SqlCommand(statement, sql);
            cmd.ExecuteNonQuery();

            // Record initial cards dealt and starting card
            cmd = new SqlCommand($"INSERT INTO Game_{currenttime}(ActionTime, ActionDescription)" +
                                 $"VALUES (@date, @GameStart)", sql);

            foreach (var player in PlayerList)
            {
                PlayerOutput += $"{player.Name} Cards: {player.Hand.OutputDeckInformation()} | ";
            }

            cmd.Parameters.AddWithValue("@date", DateTime.Now);
            cmd.Parameters.AddWithValue("@GameStart", $"Starting Card: [{DiscardPile.Cards()[0]}]" +
                                                    PlayerOutput);

            cmd.ExecuteNonQuery();

        }

        /**
         * <summary>Every 10th turn add a record of each players hand.</summary>
         */
        private void Record10thTurn()
        {
            string PlayerOutput = null;

            // make sure sql is open
            if (sql.State != ConnectionState.Open)
            {
                sql.Open();
            }

            SqlCommand cmd = new SqlCommand($"INSERT INTO Game_{sqlDate}(ActionTime, ActionDescription)" +
                                            $"VALUES (@date, @action)", sql);
            cmd.Parameters.AddWithValue("@date", DateTime.Now);

            foreach (var player in PlayerList)
            {
                PlayerOutput += $"{player.Name} Cards: {player.Hand.OutputDeckInformation()} | ";
            }

            cmd.Parameters.AddWithValue("@action", $"TURN 10 UPDATE: {PlayerOutput}");

            cmd.ExecuteNonQuery();
        }

        /**
         * <summary>Records the action of the player</summary>
         * <param name="Action">The string of the action.
         * "Play", "Draw", "Skip", "Pass" and "Wild" are all valid actions</param>
         * <param name="drawnCards">List of the players drawn cards</param>
         */
        private void RecordPlayAction(string Action, List<Card> drawnCards = null)
        {
            // make sure sql is open
            if (sql.State != ConnectionState.Open)
            {
                sql.Open();
            }

            SqlCommand cmd = new SqlCommand($"INSERT INTO Game_{sqlDate}(ActionTime, ActionDescription)" +
                                           $"VALUES (@date, @action)", sql);
            cmd.Parameters.AddWithValue("@date", DateTime.Now);

            switch (Action)
            {
                case "Skip":
                    cmd.Parameters.AddWithValue("@action", $"{PlayerList.First().Name}'s turn was skipped by {PlayerList.Last().Name}'s : {activeCard}.");
                    break;
                case "Play":
                    cmd.Parameters.AddWithValue("@action", $"{PlayerList.First().Name} played: {activeCard}.");
                    break;
                case "Draw":
                    cmd.Parameters.AddWithValue("@action",
                        drawnCards.Count == 1
                            ? $"{PlayerList.First().Name} drew: {drawnCards[0]}."
                            : $"{PlayerList.First().Name} drew: {string.Join(", ", drawnCards.Take(drawnCards.Count))}.");
                    break;
                case "Pass":
                    cmd.Parameters.AddWithValue("@action", $"{PlayerList.First().Name} had no cards to play and passed.");
                    break;
                case "Wild":
                    cmd.Parameters.AddWithValue("@action", $"{PlayerList.First().Name} played {activeCard}. Color Chosen : {activeCard.Color}.");
                    break;
            }

            cmd.ExecuteNonQuery();
        }

        /**
         * <summary>Record the player who won and update the UserData table accordingly.</summary>
         */
        private void RecordEndOfGame()
        {
            // make sure sql is open
            if (sql.State != ConnectionState.Open)
            {
                sql.Open();
            }

            SqlCommand cmd = new SqlCommand($"INSERT INTO Game_{sqlDate}(ActionTime, ActionDescription)" +
                                            $"VALUES (@date, @data)", sql);

            cmd.Parameters.AddWithValue("@date", DateTime.Now);
            cmd.Parameters.AddWithValue("@data", $"{PlayerList.First().Name} won!");

            SqlCommand updateUser;

            if (PlayerList.First().AIFlag)
            {
                updateUser = new SqlCommand($"UPDATE UserData" +
                                            " SET GamesPlayed = GamesPlayed + 1, GamesLost = GamesLost + 1", sql);
            }
            else
            {
                updateUser = new SqlCommand($"UPDATE UserData" +
                                            " SET GamesPlayed = GamesPlayed + 1, GamesWon = GamesWon + 1", sql);
            }

            updateUser.ExecuteNonQuery();
            cmd.ExecuteNonQuery();
        }


        // ----------------------- OTHER FUNCTIONS -----------------------

        /**
         * <summary>Grabs the GameWindow that is open.</summary>
         * <returns>GameWindow</returns>
         */
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