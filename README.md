# FPGA Tic Tac Toe Game

Project Team:

Emirhan Yılmaz Güney (@yilmaz0734)

Mehmet Kurt (@mehmetkurt20)

Tanel Gülerman (@Tanelglrmn)


## Intro
This paper provides our implementation of a 2-D Strategy Game in FPGA by using Verilog HDL. In the development stage, we firstly created a game logic by using state machine method and then implemented it in our game controller module. After completing the game logic part, we created the interface between the game outputs and VGA screen for visualization of the board and the game statistics. In these processes, we used Verilog HDL documentations, VGA working principle papers, and the pin assignment sheets of Altera DE-1 SoC board which we used for the implementation of the game. In addition to these major concepts, we also created a debouncer module and VGA sync module since it is required to drive the VGA screen and implement the game logic successfully.

![alt text](/img/realgameboard.jpeg)

## Pin Assignment

Since we used Altera DE1-SoC board, we utilized the pin assignment table of it. The main requirements were to make the connections of internal clock, VGA driving pins and VGA clock.

![alt text](/img/pinassignment.png)

## Game Modules
In the coding part, we utilized four modules, namely de- bouncer, game controller,VGA synchronizer and VGA main modules, and we used VGA main module as the top module. While debouncer is utilized to take inputs from players, game controller processes the inputs, then outputs the board situation and variables such as move numbers, win numbers etc. and checks the possible win and draw situations. The displaying process is handled by VGA synchronizer and VGA main modules.

![alt text](/img/modulediagram.png)

## State Diagram
The game controller consists of three states, namely IDLE, TRIPLAYS and CIRPLAYS. IDLE contains the start, win and draw sessions, whereas TRIPLAYS and CIRPLAYS defines the triangle and circle user’s commands respectively. In the IDLE state, we have a counter to stay in IDLE for 10 seconds, and the rest is about clearing the board and changing the scores. In TRIPLAYS and CIRPLAYS states, the 200 bit board variable is changed accordingly with the given inputs and the move numbers are increased. In addition to these, the checks for if the input is valid or not and the winning and draw conditions are done in these states too.

![alt text](/img/state.png)



