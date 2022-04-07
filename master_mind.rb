module Message
  def greetings 
    system("clear")
    puts "Welcome to master mind\n\n"
    puts "This game will test your limits\n\n"
    puts "Be prepared and have fun\n\n"
    puts "Select the game mode:\n\n"
    puts "s) for SinglePlayer\n"
    puts "m) for MultiPlayer\n"
  end

  def question_player_one
    system("clear")
    puts "\n\nWhat is your name, player one?\n\n"
  end

  def question_player_two
    system("clear")
    puts "\n\nWhat is your name, player two?\n\n"
  end

  def computer_intro
    system("clear")
    puts "Hello there, I'm the computer\n\n"
    puts "Nice to meet you, soon you will lose human\n\n"
    puts "HAHAHAHAAHAHAHAHAHAHAHAHAAHAHAHAHAHA\n\n"
    puts "Let's play, shall we?[y/n]\n\n"
  end

  def game_mode_invalid
    puts "\n\nChoose the correct letter dumbass\n\n"
  end

  def question 
    system("clear")
    puts "Guess the correct color order!\n\n"
    puts "(Put your guess in order and with spaces between colors)\n\n"
    puts "(Pick from red, green, yellow and blue)\n\n"
  end

  def player_lost
    puts "\n\nYou lose"
    puts "\n\n(How that's possible...)"
  end

  def continue
    puts "\n\nWant to continue?\n\n"
    puts "[y/n]"
  end

  def mode_options
    system("clear")
    puts "Choose if you want to be the guesser or the creator of the secret code\n\n"
    puts "g) Guesser\n"
    puts "c) Creator of the secret code\n"
  end
end

module Colors
  COLORS = ['red', 'green', 'yellow', 'blue']
end

class Game 
  include Message
  include Colors

  def initialize 
    greetings
    @win_condition = Array.new(4, false)
    @rounds = 0
    @player_lost = false
    @player_won = false
  end

  public
  def welcome_message
    @game_mode = gets.chomp
    system("clear")
    "Welcome to #{@game_mode == 's' ? 'SinglePlayer' : 'Multiplayer' }"
    question_player_one
    @player_one = gets.chomp
    if @game_mode == 'm'
      question_player_two
      @player_two = gets.chomp
      guesser_or_coder
    elsif @game_mode == 's'
      @player_two = 'Computer'
      guesser_or_coder
      computer_intro
    end
    while @continue != 'y' || @continue != 'n' do
      @continue = gets.chomp
      if @continue == 'y' && @options == 'g'
        round
        break
      elsif @continue == 'n'
        break
      end
    end
  end

  private 
  def guesser_or_coder
    mode_options
    @options = gets.chomp
    while @options != 'g' || @options != 'c' do
      if @options == 'g' || @options == 'c'
        break
      end
    end
  end

  private 
  def player_round
    question
    @response = gets.chomp
    @response_array = @response.split(" ")
    @response_array.each_with_index do |response, index|
      if response == @computer_code[index]
        @win_condition[index] = true
        system("clear")
        puts "Correct guess"
        sleep(5)
      else
        system("clear")
        puts "Wrong order buddy"
        sleep(5)
      end
        puts "\n\nDone checking..."
        sleep(5)
      if @win_condition[0] == true && @win_condition[1] == true && @win_condition[2] == true && @win_condition[3] == true
        system("clear")
        puts "Well done, you win!"
        sleep(5)
        @player_won = true
      end
    end
    if @player_won == false && @rounds == 12
      @player_lost = true
    end
    @rounds += 1
  end

  private
  def random_colors
    @colors = COLORS.shuffle
    @colors
  end

  private
  def reset 
    @player_won = false
    @rounds = 0
    @player_lost = false
  end

  private
  def round
    @computer_code = random_colors
    while @player_won == false || @player_lost == false do
      player_round
      if @player_won == true || @player_lost == true
        break
      end
    end
    if @player_won == true
      continue
      while @continue != 'y' || @continue != 'n' do
        @continue = gets.chomp
        if @continue == 'y'
          reset
          round
          break
        elsif @continue == 'n'
          break
        end
      end
    elsif @player_won == false && @rounds == 12
      player_lost
      @player_lost = true
      continue
      while @continue != 'y' || @continue != 'n' do
        @continue = gets.chomp
        if @continue == 'y'
          reset
          round
          break
        elsif @continue == 'n' 
          break
        end
      end
    end
  end
end

game = Game.new 
game.welcome_message