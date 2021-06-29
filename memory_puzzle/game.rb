require_relative "board.rb"
require_relative "card.rb"

class Game
    def initialize(size)
        @board = Board.new(size)
        @size = size
        @prev_guesses = [] #[1, 2]
        @previous_i, @previous_j = nil
    end

    def make_guess(pos)
        cur_card = @board.grid[r][c]
        r, c = pos
        cur_card.reveal
        if previous_i.nil?
            @previous_i, @previous_j = r, c
        else
            prev_card =@board.grid[previous_i][previous_j]
            if cur_card == prev_card
                prev_guesses << pos
                prev_guesses << [@previous_i, @previous_j]
            else
                cur_card.hide
                prev_card.hide
            end
            @previous_i, @previous_j = nil
        end
    end

    def play
        until @board.won?
            
            @board.render
            position = gets.chomp.split
            while position.length != 2 && ("0"...@size.to_s).include?(position[0]) && ("0"...@size.to_s).include?(position[1]) && previous_i != position[0] && previous_j != position[1]
                puts "invalid input. please re-enter: "
                position = gets.chomp.split
            end

            #if pos already check next

            indices = postion.map(&:to_i)
            self.make_guess(indices)
        end
    end

    def system_clear(word_clear)

    end

end

# game = Game.new(4)

