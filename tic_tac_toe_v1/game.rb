require_relative "human_player"
require_relative "board"

class Game
    def initialize(player_1_mark, player_2_mark)
        @board = Board.new
        @player_1 = HumanPlayer.new(player_1_mark)
        @player_2 = HumanPlayer.new(player_2_mark)
        @current_player = @player_1
    end

    def switch_turn 
        @current_player == @player_1 ? @current_player = @player_2 : @current_player = @player_1
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