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
    elsif @game_mode == 's'
      @player_two = 'Computer'
      computer_intro
    else
      welcome_message
    end
    while @continue != 'y' || @continue != 'n' do
      @continue = gets.chomp
      if @continue == 'y'
        round
      else
        return
      end
    end
  end

  private 
  def player_round
    question
    puts "\n#answer: #{@computer_code}"
    @response = gets.chomp
    @response_array = @response.split(" ")
    puts @response_array
    @response_array.each_with_index do |response, index|
      if response == @computer_code[index]
        @win_condition[index] = true
      else
        system("clear")
        puts "Wrong order buddy"
      end
        puts "\n\nDone checking..."
      if @win_condition[0] == true && @win_condition[1] == true && @win_condition[2] == true && @win_condition[3] == true
        system("clear")
        puts "Well done, you win!"
        @player_won = true
      end
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
  end

  public
  def round
      @computer_code = random_colors
      player_round
      if @player_won == true
        continue
        while @continue != 'y' || @continue != 'n' do
          @continue = gets.chomp
          if @continue == 'y'
            reset
            round
          else
            break
          end
        end
      elsif @player_won == false && @rounds == 12
        player_lost
        continue
        while @continue != 'y' || @continue != 'n' do
          @continue = gets.chomp
          if @continue == 'y'
            reset
            round
          else 
            break
          end
        end
      else
        player_round
      end
  end
end

game = Game.new 
game.welcome_message