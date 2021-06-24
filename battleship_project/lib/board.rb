require "byebug"

class Board

    # instance variables:
        # grid
        # size

    attr_reader :size

    def initialize(n)
        @grid=Array.new(n) {Array.new(n, :N)} # nxn board
        @size=n*n # total # of indices in grid
    end
    
    # pos: a pair of indices in an array resprenting [row,col] in the grid
    def [](pos)
        row,col=pos[0],pos[1]
        @grid[row][col]
    end

    # pos: a pair of indices in an array resprenting [row,col] in the grid
    # value: the value we want to set at pos
    def []=(pos,value)
        row,col=pos[0],pos[1]
        @grid[row][col]=value
    end
    
    def num_ships
        count=0
        @grid.each do |subArr|
            count+=subArr.count {|ele| ele==:S}
        end
        count
    end

    # pos: a pair of indices in an array resprenting [row,col] in the grid
    def attack(pos)
        status=self[pos] # the ele contained in @grid at position pos
        if status==:S # there is a ship at this position
            self[pos]=:H # changed status of @grid[pos] to "hit" i.e., :H
            p "you sunk my battleship!"
            return true
        else # there is no ship at this position
            self[pos]=:X
            return false
        end
    end

    # takes into consideration when there is a large amount of enemy ships on board
    # randomly set 25% of @grid's ele to :S (based on @grid's dimension)
    # setting ships at random position
    def place_random_ships
        numShips=(0.25*size).to_i # number of ships that need to be placed

        n=@grid.length

        # dictionary to keep track of "free" positions
        # key=row index, value=col indices array with respect to row
        dict=Hash.new {|h,k| h[k]=[]}
        n.times do |r|
            n.times do |c|
                dict[r]<<c
            end
        end

        while numShips>0
            # takes random indices only from available positions
            randRow=dict.keys.sample # takes a random row from available rows
            randCol=dict[randRow].sample # takes random col from available cols

            # delete [key=row if value=cols] when array is empty
            dict.delete(randRow) if dict[randRow].empty?
            # delete [value=col with respect to key=row] every single time
            dict[randRow].delete(randCol)

            pos=[randRow,randCol]
            self[pos]=:S

            numShips-=1 # decre num of remaining ships needing to be placed
        end
    end

    def hidden_ships_grid
        hidden_grid=[]
        @grid.each do |subArr|
            hidden_grid<<subArr.map {|ele| (ele==:S)? :N : ele}
        end
        hidden_grid
    end

    def self.print_grid(grid)
        grid.each do |subArr|
            subArr.each_with_index do |ele,i|
                if i<subArr.length-1
                    print ele.to_s + "\s"
                else
                    print ele.to_s
                end
            end
            print "\n"
        end
    end

    def cheat
        Board.print_grid(@grid)
    end

    def print 
        Board.print_grid(self.hidden_ships_grid)
    end
end
