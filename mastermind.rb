class Game

  def initialize
    @colors = %w{blue green orange purple red black}
    @turns_limit = 12
    @computer = Computer.new
    interface
  end

  def interface
    puts "Mastermind"
    puts "\nColors in the game are #{@colors[0..-1].join(', ')}.\n\n"
    puts "Would you like to be the codemaker or codebreaker?"
    print ">"
    answer = gets.strip.scan(/[a-zA-Z]+/)
    # answer = "codemaker"    # For faster testing
    if answer.include?("codebreaker") && !answer.include?("codemaker")
      @computer.generate_code(@colors)
      puts "You have #{@turns_limit} turns to guess the code."
      begin
        puts "Enter your guess:"
        print ">"
        user_input = gets.strip.scan(/[a-zA-Z]+/)
        puts "\n"
        puts "#" * 60
        puts "\n"
        if user_input.size == 4 && (user_input - @colors).size == 0
          @turns_limit -= 1
          victory = feedback(user_input, @computer.secret_code, "user")
        elsif user_input.join == "help"
          puts File.read('help.txt')
        elsif user_input.join == "exit"
          puts "Are you sure you want to leave the game?(y/n)"
          answer = gets.strip
          user_input = [] unless answer == "y"
        else
          puts "Wrong input!"
        end
      end until user_input.join == "exit" || victory || @turns_limit == 0
    elsif answer.include?("codemaker") && !answer.include?("codebreaker")
      puts "Enter your secret code: "
      print ">"
      users_secret_code = gets.strip.scan(/[a-zA-Z]+/)
      # users_secret_code = %w{blue red black green}    # For faster testing
      if users_secret_code.size == 4 && (users_secret_code - @colors).size == 0
        puts "Computer has #{@turns_limit} turns to guess the code.\n\n"
        begin
          @computer.generate_guess(@colors)
          @turns_limit -= 1
          puts "Computer's guess is | #{@computer.guess_code.join(' | ')} |"
          victory = feedback(@computer.guess_code, users_secret_code, "computer")
          puts "\n"
          puts "#" * 60
          puts "\n"
        end until victory || @turns_limit == 0
      elsif users_secret_code.join == "help"
        puts File.read('help.txt')
      else
        puts "Wrong input!"
      end
    else
      puts "I don't understand that."
    end
  end

private

  def feedback(guess_code, secret_code, codebreaker)
    correct_counter = 0
    color_match_counter = 0
    color_catcher = Hash.new(0)
    guess_code.each { |color| color_catcher[color] += 1 }
    guess_code.each_with_index do |color, index|
      if secret_code[index] == guess_code[index]
        correct_counter += 1
      elsif secret_code.include?(color) && color_catcher[color] < 2
        color_match_counter += 1
      end
    end
    puts "Correct color, and in the right hole: #{correct_counter}"
    puts "Correct color, but in the wrong hole: #{color_match_counter}"
    victory?(correct_counter, secret_code, codebreaker)
  end

  def victory?(correct_counter, secret_code, codebreaker)
    if codebreaker == "user"
      if correct_counter == 4
        puts "You guessed the code!"
        puts "The code is | #{code.join(" | ")} |"
        true
      elsif @turns_limit > 0
        puts "#{@turns_limit} more turns left."
        puts "Try again..."
        false
      elsif @turns_limit == 0
        puts "You ran out of limit in 12 guesses..."
        puts "Computer's code was | #{secret_code.join(" | ")} |"
        true
      end
    elsif codebreaker == "computer"
      if correct_counter == 4
        puts "Computer guessed the code!"
        puts "The code is | #{code.join(" | ")} |"
        true
      elsif @turns_limit > 0
        puts "#{@turns_limit} more turns left."
        puts "Computer is trying again..."
        false
      elsif @turns_limit == 0
        puts "Computer ran out of limit in 12 guesses..."
        puts "Your secret code was | #{secret_code.join(" | ")} |"
        true
      end
    end
  end
end

class Computer
  attr_reader :secret_code, :guess_code

  def initialize
    # puts "Computer is ready..." # For fun sake :-D
    @secret_code = []
  end

  def generate_code(colors)
    4.times do
      @secret_code << rand(6)
    end
    @secret_code.each_with_index do |item, index|
      @secret_code[index] = colors[item]
    end
    puts "Computer generated the code..."
  end

  def generate_guess(colors)
    @guess_code = []
    puts "Computer makes a guess..."
    sleep 3
    4.times do
      @guess_code << rand(6)
    end
    @guess_code.each_with_index do |item, index|
      @guess_code[index] = colors[item]
    end
    @guess_code
  end
end

new_game = Game.new
