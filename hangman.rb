class Hangman
  attr_accessor :board, :turns, :prosecutor, :defendant

  def initialize(prosecutor, defendant, turns = 10)
    self.turns = 10
    self.prosecutor = prosecutor
    self.defendant = defendant
  end

  def play
    puts "Welcome to the game of hangman, where the prisoner may escape punishment but the system stays unchanged, always, just the way it's meant to be. \n \n"
    #Get A Secret Word From Prosecutor And Updates Board
    board_size = prosecutor.make_secret
    self.board = Array.new(board_size,"_")


    #Game Tells Defendent How Many Letters In The Word
    defendant.get_secrete_hint(board_size)
    puts " 'The Code is #{board_size} letters long.' The Prosecutor says with a blank expression on her face. What could it possibly be?? \n \n"
    #Print The Board
    render

    #While Game Is Not Over
    while self.turns > 0 && self.board.select{|l| l == "_"}.length != 0

      #Get Letter From Defendent
      guess = defendant.guess_letter
      puts "'And the defendant guesses #{guess.upcase}!!' The jury murmurs amongst themselves.\n\n"
      # Prosecutor Tells Defendent If It's Correct
      pos = prosecutor.judge_guess(guess)
      pos.each do |p|
        self.board[p] = guess
      end
      if pos.count == 0
        render
        puts "The prisoner walks one step closer to the gallows, who would've thought #{guess} was a good idea?\n\nGood job defendant! \n\n"
      else
        render
        puts "Looks like the defendant was able to scrap by with some questionable evidence. \nPrisoner, feel free to take another breathe, enjoy it.\n\n"
      end
      # One Step Closer To Death
      self.turns -= 1

    end
    # Defendent Is Dead If Turns Run Out
    if self.turns == 0
      puts "'Thump!' The prisoner's boots have finally reached the steps leading toward the gallows.His face is as white as the knuckles of his interrogator last night (before all the blood of course).\nAnd another quick victory for the prosecutor, a glorious example of how the legal system should work.\n\nLook, the beautiful murder of ravens are already circling above!\n\n"
    end
    # Defendent Wins
    if self.board.select{|l| l == "_"}.length == 0
      puts "The defendant snatched another victim from jaws of the law. \nNext time, he wouldn't be so lucky.\n\n"
    end
  end

  def render
    puts self.board.join("") + "\n\n"
  end
end

class Player

  def make_secret
    #make a secret word if prosecuting
  end

  def get_secret_hint
    #gets length of secret if defending
  end

  def guess_letter
    #guesses the next letter if defending
  end

  def judge_guess
    #gets defendents letter and let them know if they've guessed correctly
  end

  def process_judgement
    #process result of prosecutor's judgment (computer only)
  end
end

class ComputerPlayer
  attr_accessor :dictionary, :secret_code, :guessing

  def initialize(file_name)
    self.dictionary = File.readlines(file_name).map(&:chomp)
  end

  def get_secrete_hint(length)
    self.guessing = Array.new(length,'_')
  end

  def make_secret
    self.secret_code = self.dictionary.sample
    self.secret_code.length
  end

  def guess_letter
    ("a".."z").to_a.sample
  end

  def judge_guess(letter)
    pos = []
    self.secret_code.split('').each_with_index {|n,i| pos << i if n == letter}
    pos
  end

end

class HumanPlayer
  attr_accessor :letters_remain


  def initialize
    self.letters_remain = ("a".."z").to_a
  end

  def make_secret
    puts "Please think of a code prosecutor, and let us know how long it is.\n\nIt does not have to be a real word really, no need to go easy on these crimminal scums, anything that's a number will do!\n\n"
    word_length = gets.chomp
    raise "Please pick a number prosecutor, we need to at least pretend like they have a chance\n\n" unless Integer(word_length)
    Integer(word_length)
  end

  def get_secrete_hint(num)

  end

  def judge_guess(letter)
    puts "Did they get it right? Please let us know the positions where #{letter}, exists in the code, or make something up, it really doesn't matter.\n\n"
    pos = gets.chomp.split(' ').map{|l| l.to_i }
  end

  def guess_letter
    puts "You open your left hand and see the letters #{letters_remain.join(' ')}, which one will you pick next? \n\n"
    letter = gets.chomp
    unless self.letters_remain.include?(letter)
      "You've already used #{letter.upcase}, looks like you aren't very good at this thing. \n\nWorry not, we know not of second chances in these parts of the world\n\n"
    end
    self.letters_remain.delete(letter)
    puts "'#{letter.upcase}' You said, unsure if this is the one that will seal the prisoner's fate.\n\n"
    letter
  end
end

if __FILE__ == $PROGRAM_NAME

  computer = ComputerPlayer.new('dictionary.txt')
  human = HumanPlayer.new
  game = Hangman.new(human, computer)
  game.play
end





