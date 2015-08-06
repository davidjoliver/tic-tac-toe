class TicTacToe
  attr_accessor :board
  def initialize board=nil
    @board = board || Board.new
  end

  def winning_moves value
    winning_coordinates = [].tap do |memo|
      board.lines.each do |line|
        winning_line_index = winning_move_for_line(line, value)
        winning_square = line[winning_line_index] unless winning_line_index.nil?
        memo << [winning_square.row, winning_square.column] unless winning_square.nil?
      end
    end
  end

  def winning_move_for_line line, value
    return 2 if (line[0].value == value && line[1].value == value)
    return 0 if (line[1].value == value && line[2].value == value)
    return 1 if (line[0].value == value && line[2].value == value)
  end
end

