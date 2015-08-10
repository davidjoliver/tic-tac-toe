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

  def move marker, row, col
    board.mark_square(marker, row, col) if board.grid[row][col].to_s.empty?
    board.show
  end

  def over?
    over = board.game_over?
    self.result = board.result
    over
  end

  def unplayed?
    self.board.empty_state?
  end
end

