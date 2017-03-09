class Game

  def initialize
    @computer = Computer.new
    interface
  end

  def interface
    @turns_limit = 12
    begin
      p @computer.secret_code
      puts "Enter you guess:"
      print ">"
      user_input = gets.strip.scan(/[a-zA-Z]+/)
      if user_input.size == 4 && (user_input - @computer.colors).size == 0
        @turns_limit -= 1
        victory = feedback(user_input)
      elsif user_input.join == "help"
        puts File.read('help.txt')
      else
        puts "Wrong input!"
      end
    end until user_input == "exit" || victory == 1 || @turns_limit == 0
  end

  def feedback(input)
    correct_counter = 0
    color_match_counter = 0
    color_catcher = Hash.new(0)
    input.each_with_index do |color, index|
      color_catcher[color] += 1
      if @computer.secret_code[index] == input[index]
        correct_counter += 1
      elsif @computer.secret_code.include?(color) && color_catcher[color] < 2
        color_match_counter += 1
      end
    end
    puts "Correct: #{correct_counter}"
    puts "Color match: #{color_match_counter}"
    you_win(@computer.secret_code, correct_counter)
  end

  def you_win(code, correct_counter)
    if correct_counter == 4
      puts "You guessed the code!"
      puts "The code is | #{code.join(" | ")} |"
      return 1
    else
      if @turns_limit > 0
        puts "#{@turns_limit - 1} more turns left."
        puts "Try again..."
      elsif @turns_limit == 0
        puts "You ran out of limit in 12 guesses..."
      end
    end
  end
end

class Computer
  attr_reader :secret_code, :colors

  def initialize
    @colors = %w{blank blue green orange purple red black}
    generate_code
  end

  def generate_code
    @secret_code = []

    4.times do |i|
      @secret_code << rand(7)
    end
    p @colors
    @secret_code.each_with_index do |item, index|
      @secret_code[index] = @colors[item]
    end
  end
end

new_game = Game.new
