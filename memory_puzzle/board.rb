require_relative "card.rb"

class Board
    @@alpha = ("A".."Z").to_a

    def self.get_symbols(num)
        symbols = @@alpha.sample(num)
        #[A, B, A, B]
        symbols += symbols
        symbols.shuffle!
    end

    def initialize(size)
        @grid = Array.new(size) { Array.new(size,"*") }
        @cards = [] #[A, B, A, B]
        symbols = Board.get_symbols(size * size / 2)

        while symbols.empty?
            @cards << Card.new(symbols.pop)
        end
    end

    def populate
        index = 0
        (0...@grid.size).each do |i|
            (0...@grid.size).each do |j|
                @grid[i][j] = @cards[index]
                index += 1
            end
        end
    end

    def render 
        @grid.each do |array|
            str = ""
            array.each do |card|
                if card.face_up
                    str += card.face_value + " "
                else
                    str += "* "
                end
            end
            puts str
        end
    end

end