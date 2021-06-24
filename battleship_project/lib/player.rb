class Player
    def get_move
        p "enter a position with coordinates separated with a space like `4 7"
        user_input=gets.chomp
        strPos=user_input.split(" ")
        ret=[]
        strPos.each {|e| ret<< e.to_i}
        ret
    end
end
