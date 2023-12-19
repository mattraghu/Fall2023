# UNO Card Game
# Types of Cards:
# Numbered Cards: Cards with numbers from 0 to 9 in four different colors (Red, Blue, Green, Yellow).
# Action Cards: Special cards like Draw Two, Skip, and Reverse, also in four colors.
# Other Cards: Wild, Wild Draw Four, and Spy Card, which can change the game dynamics.
# 

# How to Play:
# - Players take turns playing a card that matches either the color or the value of the top card on the discard pile.
# - Special action cards have specific effects, like making the next player draw cards or changing the direction of play.
# - Wild cards allow the player to choose a new color or reveal other players' hands in the case of the Spy Card.

from tkinter import *
import customtkinter as ctk
import random

class Card:
    # The UNO card class
    def __init__(self, color, value):
        self.color = color # Red, Blue, Green, Yellow, Wild
        self.value = value # 0-9, Draw Two, Skip, Reverse, Wild, Wild Draw Four,

    def __str__(self): # Returns a string representation of the card
        return f"{self.color} {self.value}"

class Deck:
    # The UNO deck class
    def __init__(self):
        self.cards = [] # The deck of cards
        self.build() # Builds the deck

    def build(self):
        # Builds the deck
        
        for color in ["Red", "Blue", "Green", "Yellow"]:
            for value in range(0, 10):
                self.cards.append(Card(color, value))  
                if value != 0:
                    self.cards.append(Card(color, value)) # Draw two of each num card except 0
            for value in ["Draw Two", "Skip", "Reverse"]:  # Draw two of each action card
                self.cards.append(Card(color, value))
                self.cards.append(Card(color, value))

        for value in ["Wild", "Draw Four", "Spy Card"]:
            for _ in range(4): # Draw four of each wild card
                self.cards.append(Card("Wild", value))
            

    def show(self):
        # Shows the deck
        for card in self.cards:
            print(card)

    def shuffle(self):
        # Shuffles the deck
        for i in range(len(self.cards) - 1, 0, -1):
            r = random.randint(0, i)
            self.cards[i], self.cards[r] = self.cards[r], self.cards[i]

    def draw(self):
        # Draws a card
        #Return none if no cards left
        if len(self.cards) == 0:
            return None

        return self.cards.pop()
class Player:
    # The UNO player class
    def __init__(self, name):
        self.name = name # The player's name
        self.hand = [] # The player's hand

    def draw(self, deck):
        # Draws a card
        newCard = deck.draw() 
        if newCard != None:
            self.hand.append(newCard)
            return True
        else:
            return False
        

    def showHand(self):
        # Shows the player's hand
        print(f"{self.name}'s hand:")
        for i, card in enumerate(self.hand):
            print(f"{i + 1}: {card}")


    def playCard(self, card):
        # Plays a card
        self.hand.remove(card)

    def hasWon(self):
        # Checks if the player has won
        return len(self.hand) == 0
class Game:
    # The Game Class
    def __init__ (self): 
        self.deck = Deck()
        self.currentCard = None
        self.players = []
        self.screenManager = ScreenManager(self)

        self.currentPlayer = 0
        self.direction = 1

    def checkCard(self, card):
        # Checks if the card is valid
        if self.currentCard == None:
            return True
        
        # Set the color if the card is wild
        if card.color == "Wild":
            # notValidColor = True
            # validColors = ["Red", "Blue", "Green", "Yellow"]
            # while notValidColor:
            #     print("What color would you like to change it to?")
            #     newColor = input(">> ").capitalize()
            #     if newColor in validColors:
            #         card.color = newColor
            #         notValidColor = False
            #     else:
            #         print("Invalid color.")

            # # Power up cards
            # if card.value == "Spy Card": 
            #     print("You can now see everyone's hand.")
            #     for player in self.players:
            #         player.showHand()

            #     print("Press enter to continue.")
            #     input()

            return True
        if card.color == self.currentCard.color or card.value == self.currentCard.value:
            return True
        return False
    
    def start(self):
        self.screenManager.show_screen("AddPlayers")
        self.screenManager.root.mainloop()

    def start_old(self):
        self.deck.shuffle()
        # Get Players
        i = 0 # Player number
        while True:
            name = input(f"Enter Player {i + 1}'s name (or leave blank to start game): ")
            if name == "":
                #Verify that there are at least 2 players
                if len(self.players) < 2:
                    print("You must have at least 2 players to play.")
                    continue
                else:
                    break
            self.players.append(Player(name))
            i += 1

            #Break if there are 10 players
            if i == 10:
                print("You can only have up to 10 players... starting game.")
                break

        # Deal 7 cards to each player
        for player in self.players:
            for _ in range(7):
                player.draw(self.deck)

        # Testing: Give a player a spy card
        self.players[0].hand.append(Card("Wild", "Spy Card"))

        # Draw a card from the deck to start the game
        while True:
            self.currentCard = self.deck.draw()
            if self.currentCard.color != "Wild":
                break

        # Round Logic
        currentPlayer = 0
        direction = 1

        while True: #Loop until someone wins
            # Clear the console
            print("\n" * 100)
            print(f"\n{self.players[currentPlayer].name}'s turn.")
            print(f"Current Card: {self.currentCard}") 
            print("Type a number to play a card, type 'draw' to draw a card, 'show' to show your hand, or 'quit' to quit.")

            inputValid = False
            drewCard = False

            while not inputValid:
                # Get input
                playerInput = input(">> ").lower()

                # Play a card
                if playerInput.isdigit():
                    playerInput = int(playerInput) - 1
                    if playerInput < len(self.players[currentPlayer].hand):
                        card = self.players[currentPlayer].hand[playerInput]
                        if self.checkCard(card):
                            self.players[currentPlayer].playCard(card)
                            self.currentCard = card
                            inputValid = True
                            drewCard = True
                        else:
                            print("That card is not valid.")
                    else:
                        print("That card does not exist.")
                # Draw a card
                elif playerInput == "draw":
                    self.players[currentPlayer].draw(self.deck)
                    #Check if the player can play the card they drew
                    if self.checkCard(self.players[currentPlayer].hand[-1]):
                        self.currentCard = self.players[currentPlayer].hand[-1]
                        self.players[currentPlayer].playCard(self.currentCard)
                        drewCard = True

                    inputValid = True
                # Show hand
                elif playerInput == "show":
                    self.players[currentPlayer].showHand()
                # Quit
                elif playerInput == "quit":
                    print("Thanks for playing!")
                    return
                else:
                    print("Invalid input.")

            # Check if the player has won
            if self.players[currentPlayer].hasWon():
                print(f"\n{self.players[currentPlayer].name} has won!")
                break

            if drewCard:
                # Reverse
                if self.currentCard.value == "Reverse":
                    direction *= -1
                    currentPlayer += 1 * direction

                # Skip
                elif self.currentCard.value == "Skip":
                    currentPlayer += 2 * direction

                # Draw Two
                elif self.currentCard.value == "Draw Two":
                    currentPlayer += 1 * direction
                    for _ in range(2):
                        self.players[currentPlayer].draw(self.deck)
                    currentPlayer += 1 * direction

                # Draw Four
                elif self.currentCard.value == "Draw Four":
                    currentPlayer += 1 * direction
                    for _ in range(4):
                        self.players[currentPlayer].draw(self.deck)
                    currentPlayer += 1 * direction

                else:
                    currentPlayer += 1 * direction
            else: 
                currentPlayer += 1 * direction

            # Put the next player in bounds
            currentPlayer = currentPlayer % len(self.players)


# def main():
#     game = Game()
#     game.start()

# if __name__ == "__main__":
#     main()

class ScreenManager:
    def __init__(self, game):
        self.root = ctk.CTk()
        self.game = game
        
        #Set base size
        self.root.geometry("800x400")

        self.current_screen = None
        self.screens = {
            "AddPlayers": AddPlayersScreen(self),
            "Game": GameScreen(self),
            "GameOver": GameOverScreen(self),
        }
        

        #Hide all screens
        for screen in self.screens.values():
            screen.hide()
            
            

    def show_screen(self, screen_name):
        if screen_name in self.screens:
            if self.current_screen != None:
                self.screens[self.current_screen].hide()

            self.current_screen = screen_name
            self.screens[self.current_screen].show()

class ScreenClass:
    def __init__(self, manager):
        self.manager = manager
        self.frame = ctk.CTkFrame(self.manager.root, width=800, height=400)
        self.frame.pack()

    def show(self):
        self.frame.pack()

    def hide(self):
        self.frame.pack_forget()

class AddPlayersScreen(ScreenClass):
    def __init__(self, manager):
        self.manager = manager
        self.game = self.manager.game
        self.frame = ctk.CTkFrame(self.manager.root, width=800, height=400)
        self.frame.pack()

        self.infoLabel = ctk.CTkLabel(self.frame, text="Enter Player Names")
        self.infoLabel.place(relx = 0.5, rely = 0.1, anchor = CENTER)

        self.playerNameEntry = ctk.CTkEntry(self.frame) 
        self.playerNameEntry.place(relx = 0.5, rely = 0.3, anchor = CENTER)

        self.addPlayerButton = ctk.CTkButton(self.frame, text="Add Player", command=self.addPlayer)
        self.addPlayerButton.place(relx = 0.5, rely = 0.5, anchor = CENTER)

        self.startGameButton = ctk.CTkButton(self.frame, text="Start Game", command=self.startGame, state="disabled")
        self.startGameButton.place(relx = 0.5, rely = 0.65, anchor = CENTER)

        self.currentlyAddedPlayersFrame = ctk.CTkFrame(self.frame, width=200, height=350)
        self.currentlyAddedPlayersFrame.place(relx = 0.9, rely = 0.5, anchor = E)

        self.currentlyAddedPlayersList = ctk.CTkScrollableFrame(self.currentlyAddedPlayersFrame, label_text = "Currently Added Players")

        self.currentlyAddedPlayersList.place(relwidth = .9, relheight = 1, relx = .05, rely = 0)

        # #Add a test label
        # self.testLabel = ctk.CTkLabel(self.currentlyAddedPlayersList, text="Test", fg_color="red")
        # self.testLabel.grid(row=0, column=0, padx=10, pady=10, sticky = "nsew")

        # #Add a test label
        # self.testLabel = ctk.CTkLabel(self.currentlyAddedPlayersList, text="Test", fg_color="red")
        # self.testLabel.grid(row=1, column=0, padx=10, pady=10, sticky = "nsew")

        




    def addPlayer(self):
        if self.playerNameEntry.get() != "":
            self.game.players.append(Player(self.playerNameEntry.get()))

            #Add a test label
            newPlayer = ctk.CTkLabel(self.currentlyAddedPlayersList, text=self.playerNameEntry.get())#, fg_color="red")
            newPlayer.grid(row=len(self.game.players)-1, column=0, padx=10, pady=10, sticky = "nsew")

            self.playerNameEntry.delete(0, END)

            #Check if we have enough players to start the game
            if len(self.game.players) >= 2:
                self.startGameButton.configure(state="normal")

            #Check if we have too many players (if so start)
            if len(self.game.players) >= 10:
                self.startGame()
            
    def startGame(self):
        if len(self.game.players) >= 2:
            #Start the game

            # Shuffle the deck
            self.game.deck.shuffle()

            # Deal 7 cards to each player
            for player in self.game.players:
                for _ in range(7):
                    player.draw(self.game.deck)

            # Testing: Give a player a spy card
            self.game.players[0].hand.append(Card("Wild", "Spy Card"))

            # Draw a card from the deck to start the game
            while True:
                self.game.currentCard = self.game.deck.draw()
                if self.game.currentCard.color != "Wild":
                    break

            # Round Logic
            self.game.currentPlayer = 0
            self.game.direction = 1

            #Force Update the game screen
            self.manager.screens["Game"].update()

            self.manager.show_screen("Game")

                
        
    def show(self):
        print("Showing screen 1")
        self.frame.pack()

    def hide(self):
        self.frame.pack_forget()

#Main game screen for displaying current players cards, current card, and buttons for drawing cards and quitting.
# Will also be used for 
class GameScreen(ScreenClass):
    def __init__(self, manager):
        self.manager = manager
        self.game = self.manager.game
        self.selectedCard = None
        # self.drewCard = False
        # self.playedCard = False
        self.frame = ctk.CTkFrame(self.manager.root, width=800, height=400)
        self.frame.pack()

        self.infoLabel = ctk.CTkLabel(self.frame, text="Player X", font=("Arial", 20))
        self.infoLabel.place(relx = 0.5, rely = 0.1, anchor = CENTER)

        self.currentCardLabel = ctk.CTkLabel(self.frame, text="Current Card", font=("Arial", 20), fg_color="gray", corner_radius = 10)
        self.currentCardLabel.place(relx = 0.5, rely = 0.2, anchor = CENTER)

        self.availableCardsFrame = ctk.CTkScrollableFrame(self.frame, width=777, height=150, orientation="horizontal")
        self.availableCardsFrame.place(relx = 0.5, rely = 0.3, anchor = "n")

        self.shownCards = []
        # #Test add a card (Make it card shaped with)
        # self.testCard = ctk.CTkButton(self.availableCardsFrame, text="Test",  corner_radius = 10, width = 100, height = 150)
        # self.testCard.grid(row=0, column=0, padx=10, pady=10, sticky = "nsew")

        # Draw Button 

        self.drawButton = ctk.CTkButton(self.frame, text="Draw", corner_radius = 10, width = 100, height = 30, command=lambda: self.drawCard())
        self.drawButton.place(relx = 0.5, rely = 0.77, anchor = "n")


        # Add a frame under for the colors when the player choses a wild card and a submit button (invis when start)
        self.wildCardFrame = ctk.CTkFrame(self.frame, width=700, height=140)
        self.wildCardFrame.place(relx = 0.5, rely = 0.77, anchor = "n")

        self.wildCardColorLabel = ctk.CTkLabel(self.wildCardFrame, text="Choose a color", font=("Arial", 20))
        self.wildCardColorLabel.place(relx = 0.5, rely = 0.15, anchor = CENTER)

        #Add a button for each color
        self.wildCardColorButtons = []
        for i, color in enumerate(["Red", "Blue", "Green", "Yellow"]):
            newButton = ctk.CTkButton(self.wildCardFrame, text=color,  corner_radius = 10, width = 100, height = 30, command=lambda color=color: self.colorSelected(color))
            newButton.grid(row=0, column=i, padx=10, pady=35, sticky = "nsew")
            self.wildCardColorButtons.append(newButton)

        #Hide the wild card frame
        self.wildCardFrame.place_forget()

        #Spy Card Frame at the bottom
        self.spyCardFrame = ctk.CTkScrollableFrame(self.frame, width=700, height=70, orientation="horizontal")
        self.spyCardFrame.place(relx = 0.5, rely = 0.77, anchor = "n")
        self.spyCardFrame.place_forget()

        #Spy Continue Button
        self.spyContinue = ctk.CTkButton(self.spyCardFrame, text="Continue",  corner_radius = 10, width = 100, height = 30,
        command=lambda: self.playCard(self.selectedCard))
        self.spyContinue.grid(row=0, column=0, padx=10, pady=10, sticky = "nsew")
        self.uniqueCards_Spy = []


    

        # # #Test add a label
        # self.testLabel = ctk.CTkLabel(self.spyCardFrame, text="Test", fg_color="red")
        # self.testLabel.grid(row=0, column=1, padx=10, pady=10, sticky = "nsew")


    def showUniqueCards_Spy(self):
        #Show all the unique cards that other players have in the game

        #First destroy all the shown cards
        for card in self.uniqueCards_Spy:
            card.destroy()

        self.uniqueCards_Spy = []

        #Hide the draw button
        self.drawButton.place_forget()

        #Create labels for each unique card
        for player in self.game.players:
            if player == self.game.players[self.game.currentPlayer]: #Skip the current player
                continue

            for card in player.hand:
                if card not in self.uniqueCards_Spy:
                    newCard = ctk.CTkLabel(self.spyCardFrame, text=card, fg_color="red")
                    newCard.grid(column=len(self.uniqueCards_Spy)+1, row=0, padx=10, pady=10, sticky = "nsew")
                    self.uniqueCards_Spy.append(newCard)



    def createCardButton(self, card):
        i = len(self.shownCards)

        #Creates a button for the given card
        newCard = ctk.CTkButton(self.availableCardsFrame, text=card,  corner_radius = 10, width = 100, height = 140, command=lambda card=card: self.cardSelected(card))
        newCard.grid(row=0, column=i, padx=10, pady=10, sticky = "nsew")
        card.button = newCard

        # Make card disabled if it is not valid
        if not self.game.checkCard(card):
            card.button.configure(state="disabled")
            
        self.shownCards.append(card)

    def update(self):
        #Updates the screen for the current player
        #First destroy all the shown cards
        for card in self.shownCards:
            card.button.destroy()

        self.shownCards = []

        # self.drewCard = False
        # self.playedCard = False
        self.selectedCard = None

        #Hide the spy card frame
        self.spyCardFrame.place_forget()

        #Re show the draw button
        self.drawButton.place(relx = 0.5, rely = 0.77, anchor = "n")

        #Show the current player
        self.infoLabel.configure(text=self.game.players[self.game.currentPlayer].name)

        #Show the current card
        self.currentCardLabel.configure(text=self.game.currentCard)

        #Show the current player's cards
        for i, card in enumerate(self.game.players[self.game.currentPlayer].hand):
            self.createCardButton(card)


        #Hide the wild card frame
        self.wildCardFrame.place_forget()

    def drawCard(self):
        # self.drewCard = True

        #Called when the draw button is pressed
        self.game.players[self.game.currentPlayer].draw(self.game.deck)

        #Check if the player can play the card they drew
        card = self.game.players[self.game.currentPlayer].hand[-1]
        if self.game.checkCard(card):
            self.createCardButton(card)
            self.cardSelected(card)
        else:
            self.game.currentPlayer += 1 * self.game.direction
            self.game.currentPlayer = self.game.currentPlayer % len(self.game.players)
            self.update()
            

    def playCard(self, card):
        # Called when a card is played

        # # First make sure the card is valid
        # if not self.game.checkCard(card):
        #     return

        #Play the card
        self.game.players[self.game.currentPlayer].playCard(card)
        self.game.currentCard = card


        # Check if the player has won
        if self.game.players[self.game.currentPlayer].hasWon():
            print(f"\n{self.game.players[self.game.currentPlayer].name} has won!")
            self.manager.screens["GameOver"].setWinner(self.game.players[self.game.currentPlayer].name)
            self.manager.show_screen("GameOver")
            return

        #Special card logic
        if self.selectedCard != None:
            if card.value == "Reverse":
                self.game.direction *= -1
                self.game.currentPlayer += 1 * self.game.direction
            elif card.value == "Skip":
                self.game.currentPlayer += 2 * self.game.direction
            elif card.value == "Draw Two":
                self.game.currentPlayer += 1 * self.game.direction
                self.game.currentPlayer = self.game.currentPlayer % len(self.game.players)
                for _ in range(2):
                    self.game.players[self.game.currentPlayer].draw(self.game.deck)
                self.game.currentPlayer += 1 * self.game.direction
            elif card.value == "Draw Four":
                self.game.currentPlayer += 1 * self.game.direction
                self.game.currentPlayer = self.game.currentPlayer % len(self.game.players)
                for _ in range(4):
                    self.game.players[self.game.currentPlayer].draw(self.game.deck)
                self.game.currentPlayer += 1 * self.game.direction
            else:
                self.game.currentPlayer += 1 * self.game.direction
        else:
            self.game.currentPlayer += 1 * self.game.direction
        # elif card.value == "Spy Card":
        #     print("You can now see everyone's hand.")
        #     for player in self.game.players:
        #         player.showHand()

        #     print("Press enter to continue.")
        #     input()

        

        #Put the next player in bounds
        self.game.currentPlayer = self.game.currentPlayer % len(self.game.players)

        print("Current Player: ", self.game.currentPlayer)

        #Update the screen
        self.update()

        print("Card Played: ", card)

    def cardSelected(self, card):
        #Called when a card is selected

        #First make sure the card is valid
        if not self.game.checkCard(card):
            return

        self.selectedCard = card

        #Make the wild card frame visible if the card is wild
        if card.color == "Wild":
            #First visually select the card 
            card.button.configure(fg_color="dark goldenrod")

            #Make the other cards unselectable
            for shownCard in self.shownCards:
                if shownCard != card:
                    shownCard.button.configure(state="disabled")

            #Reenable the wild card color buttons
            for button in self.wildCardColorButtons:
                button.configure(state="normal")

            #Show the wild card frame
            self.wildCardFrame.place(relx = 0.5, rely = 0.77, anchor = "n")

        else:
            self.playCard(card)


    def colorSelected(self, color):
        #Called when a color is selected
        #First make the other buttons unselectable
        for button in self.wildCardColorButtons:
            button.configure(state="disabled")

        #Make sure a card is selected and is wild
        if self.selectedCard == None or self.selectedCard.color != "Wild":
            return

        #Change the color of the selected card
        self.selectedCard.color = color

        if self.selectedCard.value == "Spy Card":
            #Show the spy card frame
            self.spyCardFrame.place(relx = 0.5, rely = 0.77, anchor = "n")

            #Show the unique cards
            self.showUniqueCards_Spy()
        else:
            #Play the card
            self.playCard(self.selectedCard)

class GameOverScreen(ScreenClass):
    def __init__(self, manager):
        self.manager = manager
        self.game = self.manager.game
        self.frame = ctk.CTkFrame(self.manager.root, width=800, height=400)
        self.frame.pack()

        self.infoLabel = ctk.CTkLabel(self.frame, text="Game Over", font=("Arial", 20))
        self.infoLabel.place(relx = 0.5, rely = 0.1, anchor = CENTER)

        self.winnerLabel = ctk.CTkLabel(self.frame, text="Winner: ", font=("Arial", 20))
        self.winnerLabel.place(relx = 0.5, rely = 0.2, anchor = CENTER)

    def setWinner(self, winner):
        self.winnerLabel.configure(text=f"Winner: {winner}")





    
    



game = Game()
game.start()

# test_screen_manager = ScreenManager(None)
# test_screen_manager.show_screen("Game")
# test_screen_manager.root.mainloop()
