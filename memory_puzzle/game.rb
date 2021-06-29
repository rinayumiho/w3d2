require_relative "board.rb"
require_relative "card.rb"

class Game
    def initialize(size)
        @board = Board.new(size)
        @size = size
    end

    def play
        until @board.won?
            previous_i, previous_j = nil
            position = gets.chomp.split
            while position.length != 2 && ("0"...@size.to_s).include?(position[0]) && ("0"...@size.to_s).include?(position[1]) && previous_i != position[0] && previous_j != position[1]
                puts "invalid input. please re-enter"
                position = gets.chomp.split
            end
        end
    end

end

# game = Game.new(4)

