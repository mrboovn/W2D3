class HumanPlayer
    attr_reader :mark
    def initialize(mark)
        @mark = mark  # is this to determine if a player is :O or :X?
    end

    def get_position(legal_position)

        until @board.legal_positions.include?(legal_position)
            puts "Enter the position as two numbers with space between then like `4 7` "
            position = gets.chomp # returns '4 7' and not '4 7\n'
            coordinates_arr = position.split #  ['4','7']
            coordinates = []

            if coordinates_arr.all? {|ele| ele.to_i.to_s == ele } && coordinates_arr.length == 2
                coordinates_arr.each {|ele| coordinates << ele.to_i}
            else
                raise "Not a valid position, please try again"
            end
            coordinates
        end

    end

    
    
end