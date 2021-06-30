class Tile
    attr_reader :val

    def initialize(val)
        @val = val
    end

    def value_change(new_value)
        @val = new_value
    end

end