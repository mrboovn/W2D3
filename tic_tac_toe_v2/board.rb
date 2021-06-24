class Board
    attr_reader :grid

    def initialize(n)
        @grid = Array.new(n) {Array.new(n, "_")}
    end

    def valid?(pos) # pos is an array
        row = pos[0]
        col = pos[1]


        if row >= 0 && col >= 0 && row < @grid.length
            if @grid[row][col] != nil 
                return true 
            end
        else  
            # puts "Not a valid position please try again"
            return false
        end

        # if @grid[row][col] == nil || (row < 0 || col < 0) || (row >= n || col >= n)
        #     puts "Not a valid position please try again"
        #     return false  
        # end  

        # true
    end

    def empty?(pos)
        row = pos[0]
        col = pos[1]

        if @grid[row][col] == "_"
            return true 
        end
        false
    end

    def place_mark(pos, mark)
        if !self.valid?(pos) || !self.empty?(pos)
            raise "Not valid position, please try again"
        else
            @grid[pos[0]][pos[1]] = mark
        end
    end

    def print
        xo_grid = @grid.map do |arr|
            arr.map {|sym| sym.to_s}
        end

        xo_grid.each do |arr|
            puts arr.join(" ")
        end
    end

    def win_row?(mark)
        @grid.any? do |arr|
            arr.all? {|ele| ele == mark}
        end
    end

    def win_col?(mark)
        @grid.transpose.any? do |arr|
            arr.all? {|ele| ele == mark}
        end
    end

    def win_diagonal?(mark)
        diagonal_1 = (0...@grid.length).to_a.map {|index| @grid[index][index]}
        diagonal_2 = (0...@grid.length).to_a.map {|index| @grid[index][-index - 1]}
        if diagonal_1.all? {|ele| ele == mark} || diagonal_2.all? {|ele| ele == mark}
            return true
        end
        false
    end

    def win?(mark) # i feel like win?, win_diagonal? and win_col? is missing a position parameter
        if win_col?(mark) || win_diagonal?(mark) || win_row?(mark)
            return true  
        end 
        false
    end

    def empty_positions?
        @grid.flatten.any? {|ele| ele == "_"}
    end


end


# small = Board.new(4)

# p small
