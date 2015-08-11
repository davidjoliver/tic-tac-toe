require 'rake'
require File.expand_path('../config/environment', __FILE__)

desc "access the environment"
task :env do
  binding.pry
end

task :play do
  puts "-------------------------"
  puts "- Welcome to TicTacToe! -"
  puts "-------------------------"
  puts "- Type 'quit' to leave  -"
  puts "-------------------------"

  game = Game.new

  print "Would you like to be X or O? (O is default) : "
  marker = STDIN.gets.chomp.upcase

  game.opponent.marker = marker.empty? ? game.opponent.marker : marker
  game.computer_player.marker = marker == "X" ? "O" : "X"

  puts "\n\n"
  print "You are #{game.opponent.marker} and the computer will be #{game.computer_player.marker}"
  puts "\n\n"

  game.show_board
  while true
    if game.over?
      if (result = game.result) == :draw
        message = "The game was a draw!"
      else
        message = "#{game.result} is the winner!"
      end
      puts message
      exit 1
    end
    puts
    print "Pick a square: "
    choice = STDIN.gets.chomp
    break if choice == "quit"
    game.opponent.move *choice.split(",").map(&:to_i)
    puts "The computer needs to think a bit"
    3.times { sleep(0.25); print "." }
    puts "\n"
    game.computer_player.move
    puts
  end
end

