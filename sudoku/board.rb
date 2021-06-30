require 'set'
require_relative "tile"

class Board
    def initialize
        @rows = Hash.new { |h, k| h[k] = Set.new }
        @cols = Hash.new { |h, k| h[k] = Set.new }
        @squares = Hash.new { |h, k| h[k] = Set.new }
        @givens = Set.new
        @grid = []
        @remains = 81
        create_grid
        fill_givens
    end

    def create_grid
        File.open("sudoku1.txt", "r") do |file|
            file.each_line do |line|
                arr = []
                line.chomp.split("").each do |ch|
                    if ch == "0"
                        arr << Tile.new("_")
                    else
                        arr << Tile.new(ch.to_i)
                    end
                end
                @grid << arr
            end
        end
    end

    def fill_givens
        (0..8).each do |i|
            (0..8).each do |j|
                next if @grid[i][j].val == "_"
                value = @grid[i][j].val
                fill_value(i, j, value)
                @givens << i * 9 + j
            end
        end
    end

    def render
        @grid.each do |arr|
            str = ""
            arr.each do |tile|
                if tile.val != "_"
                    str << tile.val.to_s + " "
                else
                    str << tile.val + " "
                end
            end
            puts str
        end
    end

    def invalid_input?(arr)
        arr.nil? || arr.length != 2 || arr[0].length != 1 || arr[1].length != 1 ||
         !("0".."8").include?(arr[0]) || !("0".."8").include?(arr[1]) || @givens.include?(arr[0].to_i * 9 + arr[1].to_i)
    end

    def cannot_fill?(i, j, value)
        @rows[i].include?(value) || @cols[j].include?(value) || @squares[(i / 3) * 3 + (j / 3)].include?(value)
    end

    def remove_value(i, j)
        tile = @grid[i][j]
        value = tile.val
        tile.value_change("_")
        @rows[i].delete(value)
        @cols[j].delete(value)
        @squares[(i / 3) * 3 + (j / 3)].delete(value)
        @remains += 1
    end

    def fill_value(i, j, value)
        tile = @grid[i][j]
        tile.value_change(value)
        @rows[i] << value
        @cols[j] << value
        squ = (i / 3) * 3 + (j / 3)
        @squares[squ] << value
        @remains -= 1
    end

    def win?
        @remains == 0
    end

    def play
        puts "You need to fill #{@remains} block(s)."
        puts "Please enter your location, two numbers (0 - 8) separated by a space:"
        position = gets.chomp.split
        while invalid_input?(position)
            puts "Invalid input, please re-enter it:"
            position = gets.chomp.split
        end
        i, j = position[0].to_i, position[1].to_i
        old_value = @grid[i][j].val
        if old_value != "_"
            remove_value(i, j)
            puts "You have already removed the old value #{old_value} in this position!"
            puts "You need to fill #{@remains} block(s)"
            puts 
        end
        puts "Please enter the value (1 - 9):"
        value = gets.chomp.to_i
        if value < 1 || value > 9 || cannot_fill?(i, j, value)
            puts "You cannot put #{value} in this position!"
            return
        end
        # raise "You cannot put #{value} in this position!"
        fill_value(i, j, value)
    end
end