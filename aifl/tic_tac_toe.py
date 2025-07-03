import math

# Initialize board
board = [' ' for _ in range(9)]

# Display the board
def print_board():
    print("\n")
    for i in range(3):
        print(" " + board[3*i] + " | " + board[3*i+1] + " | " + board[3*i+2])
        if i < 2:
            print("---|---|---")
    print()

# Check if a player has won
def is_winner(player):
    win_combos = [
        [0,1,2], [3,4,5], [6,7,8],  # rows
        [0,3,6], [1,4,7], [2,5,8],  # columns
        [0,4,8], [2,4,6]            # diagonals
    ]
    return any(all(board[i] == player for i in combo) for combo in win_combos)

# Check if board is full
def is_draw():
    return ' ' not in board

# Minimax algorithm
def minimax(is_maximizing):
    if is_winner('O'):
        return 1
    elif is_winner('X'):
        return -1
    elif is_draw():
        return 0

    if is_maximizing:
        best_score = -math.inf
        for i in range(9):
            if board[i] == ' ':
                board[i] = 'O'
                score = minimax(False)
                board[i] = ' '
                best_score = max(score, best_score)
        return best_score
    else:
        best_score = math.inf
        for i in range(9):
            if board[i] == ' ':
                board[i] = 'X'
                score = minimax(True)
                board[i] = ' '
                best_score = min(score, best_score)
        return best_score

# Computer move
def computer_move():
    best_score = -math.inf
    best_move = None
    for i in range(9):
        if board[i] == ' ':
            board[i] = 'O'
            score = minimax(False)
            board[i] = ' '
            if score > best_score:
                best_score = score
                best_move = i
    board[best_move] = 'O'

# Human move
def human_move():
    while True:
        try:
            move = int(input("Enter your move (1-9): ")) - 1
            if 0 <= move <= 8 and board[move] == ' ':
                board[move] = 'X'
                break
            else:
                print("Invalid move. Try again.")
        except:
            print("Enter a number between 1 and 9.")

# Game loop
def play_game():
    print("Welcome to Tic Tac Toe!")
    print("You are X, Computer is O")
    print_board()

    while True:
        human_move()
        print_board()
        if is_winner('X'):
            print("Congratulations! You win!")
            break
        if is_draw():
            print("It's a draw!")
            break

        print("Computer is making a move...")
        computer_move()
        print_board()
        if is_winner('O'):
            print("Computer wins! Better luck next time.")
            break
        if is_draw():
            print("It's a draw!")
            break

play_game()
