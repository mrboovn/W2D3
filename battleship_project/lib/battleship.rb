require_relative "board"
require_relative "player"

class Battleship

    # instance variables:
        # player
        # board

    attr_reader :player, :board

    def initialize(n)
        @player=Player.new
        @board=Board.new(n)
        @remaining_misses=@board.size/2
    end

    def start_game
        @board.place_random_ships
        p (0.25*@board.size).to_i
        @board.print
    end

    def lose?
        if @remaining_misses<=0
            p "you lose"
            return true
        else
            return false
        end
    end

    def win?
        numShips=@board.num_ships # number of enemy ships remaining on board
        p "reamining enemy ships: " + numShips.to_s
        if numShips==0
            p "you win"
            return true
        else
            return false
        end
    end

    def game_over?
        if self.win? || self.lose?
            return true
        else
            return false
        end
    end

    def turn
        user_input=@player.get_move
        # status: boolean indicating whether an attack succeeded or failed
        status=@board.attack(user_input)
        if !status # if attack failed
            @remaining_misses-=1
        end

        # testing
        # @board.cheat
        # puts

        @board.print
        p "remaining misses: " + @remaining_misses.to_s
    end
end
