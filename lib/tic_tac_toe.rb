require 'pry'

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [2,4,6],
  [0,4,8], ]
  
def input_to_index(number)
  number.to_i - 1
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end 
 
def turn_count(board)
  board.count("X") + board.count("O")
end
 
 def current_player(board)
   if turn_count(board) % 2 == 0 
        "X"
   else "O"
  end
end
 
 def move(board, index, player)
   board[index] = player
end
 
def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
   if valid_move?(board, index)
   move(board, index, current_player(board))
   else
     turn(board)
  end
  display_board(board)
end

def won?(board)
   WIN_COMBINATIONS.detect do |win_combination|
   win_index_1 = win_combination[0]
   win_index_2 = win_combination[1]
   win_index_3 = win_combination[2]
   
   position_1 = board[win_index_1]
   position_2 = board[win_index_2]
   position_3 = board[win_index_3]
   
    position_1 == position_2 && position_2 ==  position_3 && position_taken?(board, win_index_1)
   end
end
  
def full?(board)
  board.all? {|spot| spot == "X" || spot == "O"}
end

def draw?(board)
   !won?(board) && full?(board)
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  if win = won?(board)
   board[win[0]]
 end
end

def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
  winner(board) == "X" || winner(board) == "O"
  puts "Congratulations #{winner(board)}!"
  else
  puts "Cat's Game!"
 end
end 