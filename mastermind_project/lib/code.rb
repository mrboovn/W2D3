require "byebug"

class Code

  attr_reader :pegs

  POSSIBLE_PEGS = {
    "R" => :red,
    "G" => :green,
    "B" => :blue,
    "Y" => :yellow
  }

  # instance variables:
    # pegs: array of capital characters
  
  def initialize(char_arr)
    flag=Code.valid_pegs?(char_arr)
    if !flag
      raise "argument not valid"
    else
      @pegs=char_arr.map {|char| char.upcase}
    end
  end
  
  def self.valid_pegs?(char_arr)
    valid_pegs=POSSIBLE_PEGS.keys # array of possible pegs

    # Code#POSSIBLE_PEGS contain capital chars as keys
    char_arr.all? {|peg| valid_pegs.include?(peg.upcase)}
  end

  # returns a Code instance with array of length with random pegs in each index
  def self.random(length)
    code=[]
    possible_keys=POSSIBLE_PEGS.keys
    length.times do
      rand_num=rand(3)
      code<<possible_keys[rand_num]
    end
    Code.new(code)
  end

  # returns a Code instance from an string
  def self.from_string(pegs_str)
    code=[]
    pegs_str.each_char do |char|
      code<<char.upcase
    end
    Code.new(code)
  end

  def [](index)
    @pegs[index]
  end

  def length
    @pegs.length
  end

  # return exact matches of code_instance's pegs to self's pegs
  def num_exact_matches(code_instance)
    count=0
    self.pegs.each_with_index do |peg,i|
      count+=1 if peg==code_instance.pegs[i]
    end
    count
  end

  # return exact matches of code_instance's pegs to self's pegs
  # excludes exact matches
  def num_near_matches(code_instance)
    count=0
    
    guess=code_instance.pegs
    solution=self.pegs

    guess_matched=[] # indices that are banned for guess pegs
    solution_matched=[] # indices that are banned for solution pegs

    # exact matches (index match and char match)
    # are banned for both guess and solution
    guess.length.times do |i|
      if guess[i]==solution[i]
        guess_matched<<i 
        solution_matched<<i
      end
    end

    guess.length.times do |i|
      guess_banned=guess_matched.include?(i) # true when i is banned
      next if guess_banned # skip iteration if i is banned
      solution.length.times do |j|
        solution_banned=solution_matched.include?(j) # true when j is banned
        match=(guess[i]==solution[j]) # true when a match is found
        next if solution_banned || !match # skip iteration if j is banned or match not found
        guess_matched<<i
        solution_matched<<j
        count+=1
        break # only match one guess char to one solution char
      end
    end
    count
  end

  def ==(code_instance)
    if !(self.length==code_instance.length)
      return false
    else
      if self.pegs==code_instance.pegs
        return true
      else 
        false
      end
    end
  end
end
