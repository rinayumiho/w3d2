require 'set'
require 'byebug'

def sudoku_solver
    @rows = Hash.new { |h, k| h[k] = Set.new }
    @cols = Hash.new { |h, k| h[k] = Set.new }
    @squares = Hash.new { |h, k| h[k] = Set.new }
    @grid = []
    create_grid
    fill_givens
    helper_solver(0, 0)
    @grid.each { |arr| puts arr.join(" ") }
end

def helper_solver(i, j)
    if j == 9
        j = 0
        i += 1
    end
    return true if i == 9
    return helper_solver(i, j + 1) if @grid[i][j] != "_"
    (1..9).each do |val|
        next if cannot_fill?(i, j, val)
        fill_value(i, j, val)
        return true if helper_solver(i, j + 1)
        remove_value(i, j)
    end
    false
end

def create_grid
    File.open("sudoku1.txt", "r") do |file|
        file.each_line do |line|
            arr = []
            line.chomp.split("").each do |ch|
                if ch == "0"
                    arr << "_"
                else
                    arr << ch.to_i
                end
            end
            @grid << arr
        end
    end
end

def cannot_fill?(i, j, value)
    @rows[i].include?(value) || @cols[j].include?(value) || @squares[(i / 3) * 3 + (j / 3)].include?(value)
end

def fill_givens
    (0..8).each do |i|
        (0..8).each do |j|
            value = @grid[i][j]
            next if value == "_"
            fill_value(i, j, value)
        end
    end
end

def fill_value(i, j, value)
    @grid[i][j] = value
    @rows[i] << value
    @cols[j] << value
    squ = (i / 3) * 3 + (j / 3)
    @squares[squ] << value
end

def remove_value(i, j)
    value = @grid[i][j]
    @grid[i][j] = "_"
    @rows[i].delete(value)
    @cols[j].delete(value)
    @squares[(i / 3) * 3 + (j / 3)].delete(value)
end

# debugger
sudoku_solver