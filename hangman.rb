class Hangman
  attr_accessor :board, :turns

  def initialize(turns = 10)
    self.turns = 10
  end

  def play

    #Get A Secret Word From Prosecutor

    #Prosecutor Tells Defendent How Many Letters In The Word

    #Print The Board

    #While Game Is Not Over

    #Get Letter From Defendent

    # Prosecutor Tells Defendent If It's Correct

    # One Step Closer To Death

    # Prisoner Is Dead If Turns Run Out

    # Defendent Wins

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