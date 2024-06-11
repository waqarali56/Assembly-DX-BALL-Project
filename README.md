DX Ball Game in Assembly Language ( NOTE : Please with Full Screen)

Overview:
This project implements a DX Ball game using x86 assembly language with Irvine32 library support.
The game involves a bouncing ball that the player must keep from falling off the screen using a 
paddle. The player can move the paddle horizontally to bounce the ball back into play and break 
bricks arranged on the screen. The game includes features like a welcome screen, difficulty level
selection, scoring system, and a game over screen.




Components:
Data Segment:
Game Graphics and Messages:
Strings for the welcome message, difficulty levels, game over message, and score display.
Characters for ball, paddle, and bricks.

Game Variables:
Variables to track the ball position, paddle position, screen boundaries, speed, score, 
and other game states.




Procedures:
Welcome Screen (welcome proc):
Displays the welcome message. Prompts the user to enter their name and choose a difficulty 
level.

Input Handling (input proc):
Reads player input for moving the paddle left ('a') or right ('s').

Score Update (scoreup proc):
Increments the score each time the ball hits a brick.

Game Over (gameoverr proc):
Displays the game over screen with the player's name and score.

Paddle Drawing:
black_color proc: Clears the previous paddle position.

my_color proc: Draws the paddle at the new position.

Main Game Loop (main proc):
Initializes game settings and screen boundaries. Draws borders and bricks. Contains the main 
loop for ball movement and collision detection.




Game Mechanics:
Ball Movement:
The ball moves in one of four possible diagonal directions, bouncing off walls, bricks, and 
the paddle.

Collision Detection:
Checks for collisions with walls to change the ball's direction. Checks if the ball hits the
paddle or goes past it, resulting in game over if missed. Updates the score when the ball hits
a brick.

Difficulty Levels:
Adjusts the ball's speed based on the chosen difficulty (Beginner, Medium, Hard).

Rendering and Delay:
Uses procedures for setting text color, positioning the cursor (gotoxy), and rendering text on
the screen. Implements delays to control the speed of ball movement and animations.




Game Flow:
Initialization:
Sets up the game screen, borders, and bricks.

Game Loop:
Continuously moves the ball, checks for collisions, updates the paddle position based on player 
input, and refreshes the display.

End Condition:
Ends the game when the ball is missed by the paddle, displaying the game over screen and final score.

Notable Points:
The game uses a combination of direct hardware manipulation (e.g., gotoxy for cursor positioning) and 
higher-level constructs (e.g., string handling with writestring) provided by the Irvine32 library.
Collision detection and response are handled using basic arithmetic and comparison operations, typical
in assembly language programming. The project demonstrates fundamental game programming concepts like 
state management, user input handling, and simple AI for ball movement.


Conclusion:
This DX Ball game project showcases the ability to create interactive, graphical applications using 
assembly language. It combines low-level programming techniques with structured design to create a 
functional and engaging game, highlighting the intricacies and capabilities of assembly language in 
handling real-time applications.
