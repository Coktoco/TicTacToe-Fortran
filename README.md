# Tic-Tac-Toe in Fortran

Course: Applied Computer Science, Year 2
Semester: Spring 2024  

## Project Description

This is a console application that allows two players to play "Tic-Tac-Toe," written in Fortran. The game uses the "hot seat" technique, where players take turns making moves on the same computer.

## Game Rules

"Tic-Tac-Toe" is a simple two-player game where players alternately place their symbols (X or O) on a 3x3 board. The goal is to align three of your symbols horizontally, vertically, or diagonally. If a player achieves this, the game ends with a win. If all fields are occupied and neither player has aligned three symbols, the game ends in a draw.

## System Requirements

- A computer with a Fortran compiler installed (e.g., GNU Fortran - gfortran)
- Operating system: Linux, macOS, or Windows

## Program Structure

The code consists of the following sections:

1. **Variable Declarations** - Defining the main variables used in the program.
2. **Board Initialization** - Setting the initial state of the board as empty.
3. **Main Game Loop** - The loop controlling the game's progress and turns.
4. **Subroutines and Functions**:
   - `initialize_board` - Initializes the board with empty fields.
   - `print_board` - Displays the current state of the board.
   - `check_winner` - Checks if a player has won.
   - `menu` - Displays the main menu.
   - `get_move` - Gets the player's move.
   - `save_result` - Saves the game result to a file.
   - `instructions` - Displays game instructions.

## Implementation

### Variable Declarations

The program declares main variables such as:
- `board` (game board),
- `row, col` (user input for row and column),
- `turn` (turn counter),
- `game_over` (game over flag),
- `valid_move` (move validity flag),
- `player` (current player).

### Board Initialization

The `initialize_board` subroutine sets all board fields to empty (`' '`).

### Main Game Loop

The `DO WHILE` loop controls the game's progress:
- The player inputs the row and column.
- The program checks the validity of the move.
- The board is updated.
- It checks for win or draw conditions.
- The player is switched after each valid move.

## How to Run the Game

1. Compile the source code using a Fortran compiler, e.g., `gfortran -o tic_tac_toe tic_tac_toe.f90`.
2. Run the program in the terminal using the command `./tic_tac_toe`.

## Summary

The program is a simple implementation of the "Tic-Tac-Toe" game in Fortran, offering basic gameplay for two players. The project has the potential for further development and adding new features in the future.

## Future Enhancements

- Adding a graphical interface.
- Implementing a mode to play against the computer.
- Adding options to save and load the game state.

## License

This project is licensed under the MIT License. You are free to use, modify, and distribute it, provided you retain the original author information.
