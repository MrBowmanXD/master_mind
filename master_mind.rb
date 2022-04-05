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
    puts "Let's play, shall we?\n\n"
  end

  def game_mode_invalid
    puts "\n\nChoose the correct letter dumbass\n\n"
  end
end

class Game 
  include Message

  def initialize 
    greetings
  end

  def welcome_message
    @game_mode = gets.chomp
    system("clear")
    "Welcome to #{@game_mode == 's' ? 'SinglePlayer' : 'Multiplayer' }"
    question_player_one
    @player_one = gets.chomp
    if @game_mode == 'm'
      question_player_two
      @player_two = gets.chomp
    elsif @game_mode == 's'
      @player_two = 'Computer'
      computer_intro
    else
      welcome_message
    end
  end
end

game = Game.new 
game.welcome_message