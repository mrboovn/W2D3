require_relative "code"

class Mastermind
    def initialize(length)
        @secret_code=Code.random(length)
    end

    def print_matches(code_instance)
        p @secret_code.num_exact_matches(code_instance)
        p @secret_code.num_near_matches(code_instance)
    end

    def ask_user_for_guess
        print "Enter a code (RGBY): \n"
        user_input=gets.chomp
        guess=Code.from_string(user_input)
        print_matches(guess)
        @secret_code==guess
    end
end
