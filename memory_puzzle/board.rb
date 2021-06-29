class Board
    @@alpha = ("A".."Z").to_a

    def self.get_symbols(num)
        symbols = @@alpha.sample(num)
        #[A, B]
        symbols += symbols
    end

    def self.create_card(symbols)

    end

    def initialize(size)
        @grid = Array.new(size) { Array.new(size,"*") }
        @cards = []
        symbols = Board.get_symbols(size * size / 2)

    end

    def []=()

    end
end