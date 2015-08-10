class Game
  attr_accessor :board, :computer_player, :opponent, :result

  def initialize board=nil
    @board = board || Board.new
    @computer_player = ComputerPlayer.new(game: self)
    @opponent = Player.new(game: self)
  end

  def show_board
    self.board.show
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
    return 2 if (line[0].value == value && line[1].value == value && line[2].value.to_s.empty?)
    return 0 if (line[1].value == value && line[2].value == value && line[0].value.to_s.empty?)
    return 1 if (line[0].value == value && line[2].value == value && line[1].value.to_s.empty?)
  end

  def move marker, row, col
    board.mark_square(marker, row, col) if board.grid[row][col].value.to_s.empty?
    board.show
  end

  def over?
    board.game_over?
  end

  def unplayed?
    self.board.empty_state?
  end
end

