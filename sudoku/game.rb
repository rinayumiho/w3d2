require_relative "board"
require_relative "tile"

board = Board.new
puts "Welcome to play SUDOKU"
puts
until board.win?
    board.render
    board.play
end
puts
board.render
puts "Win"