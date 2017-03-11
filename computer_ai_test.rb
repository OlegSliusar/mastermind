class Computer
  attr_accessor :correct_counter
  attr_reader :secret_code, :guess_code

  def initialize
    puts "Computer is ready..."
  end

  def generate_guess(colors)
    @guess_code = []
    @previous_code ||= []
    @ignore_index = []
    @previous_ignore_index ||= []
    @correct_counter ||= 0
    @previous_correct_counter ||= 0
    puts "Computer makes a guess...\n\n"
    sleep 3
    # puts "Test with correct_counter == #{@correct_counter}"
    if @previous_correct_counter > @correct_counter
      (@previous_correct_counter - @correct_counter).times do
        @previous_ignore_index.delete_at(rand(@previous_ignore_index.length))
        # puts "\nItems deleted...\n\n"
      end
    end
    # puts "@previous_ignore_index is: #{@previous_ignore_index}\n\n"
    # puts "@ignore_index is: #{@ignore_index}\n\n"
    if @previous_ignore_index.size > 0
      @ignore_index = @previous_ignore_index
      # puts "\n@ignore_index = @previous_ignore_index\n\n"
    end
    # puts "@previous_ignore_index is: #{@previous_ignore_index}\n\n"
    # puts "@ignore_index is: #{@ignore_index}\n\n"
    if @correct_counter > @previous_correct_counter
      # puts "I'm inside if @correct_counter > @previous_correct_counter\n\n"
      (@correct_counter - @ignore_index.size).times do |i|
        random_number = rand(4)
        redo if @ignore_index.include?(random_number)
        @ignore_index << random_number
        # puts "Color with index(#{random_number}) will be reserved."
      end
    end
    # puts "#" * 20
    4.times do |i|
      if @ignore_index.include?(i)
        puts "Element with index #{i} is ignored..."
        @guess_code[i] = @previous_code[i]
        next
      end
      @guess_code[i] = rand(6)
      puts "Random number(#{@guess_code[i]}) generated for @guess_code"
    end

    puts "The guess code is #{@guess_code}"

    @guess_code.each_with_index do |item, index|
      @guess_code[index] = colors[item] unless item.class == String
    end
    puts "#" * 30
    puts "@previous_code is: #{@previous_code}"
    puts "@previous_correct_counter is: #{@previous_correct_counter}"
    puts "@previous_ignore_index is: #{@previous_ignore_index}"
    puts "#" * 30
    @previous_code = @guess_code
    @previous_correct_counter = @correct_counter
    @previous_ignore_index = @ignore_index
    puts "@previous_code assigned with: #{@previous_code}"
    puts "@previous_correct_counter assigned with: #{@previous_correct_counter}"
    puts "@previous_ignore_index assigned with: #{@previous_ignore_index}"
    puts "#" * 90
    p @guess_code
    @guess_code
  end
end

colors = %w{blue green orange purple red black}
my_computer = Computer.new
my_computer.generate_guess(colors)
my_computer.correct_counter = 1
my_computer.generate_guess(colors)
my_computer.correct_counter = 2
my_computer.generate_guess(colors)
my_computer.correct_counter = 3
my_computer.generate_guess(colors)
puts "DECREASING ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||"
my_computer.correct_counter = 3
my_computer.generate_guess(colors)
my_computer.correct_counter = 2
my_computer.generate_guess(colors)
my_computer.correct_counter = 1
my_computer.generate_guess(colors)
my_computer.correct_counter = 2
my_computer.generate_guess(colors)
