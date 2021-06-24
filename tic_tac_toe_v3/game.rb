require_relative "human_player"
require_relative "board"

class Game
    def initialize(n, *players_mark)
        @board = Board.new(n)
        @players = players_mark.map {|mark| HumanPlayer.new(mark)}
        @current_player = @players[0]
    end

    def switch_turn 
        @players.rotate!
        current_player = @players[0]
    end

    def play
        while @board.empty_positions?
            # print the board
            @board.print 

            #get position from current player
            position = @current_player.get_position
            
            # place mark at position of board
            @board.place_mark(position, @current_player.mark)

            #check if user wins
            if @board.win?(@current_player.mark)
                return "VICTORY!"  # might need to come back later and refactor
            else
                self.switch_turn
            end    
        end
        "DRAW"
    end

end