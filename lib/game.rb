class Game
  attr_accessor :board, :computer_player, :opponent, :result, :ui

  def initialize board=nil
    @board = board || Board.new
    @computer_player = ComputerPlayer.new(game: self)
    @opponent = Player.new(game: self)
    @ui = UI.new
  end

  def init_state
    ui.welcome_message
    marker = ui.prompt_for_marker
    opponent.marker = marker.empty? ? opponent.marker : marker
    computer_player.marker = marker == "X" ? "O" : "X"
    ui.player_markers_message opponent.marker, computer_player.marker
    self.board.show
  end

  def start
    while true
      handle_game_over if over?
      choice = ui.prompt_for_move
      exit(1) if choice == "quit"
      opponent.move *choice.split(",").map(&:to_i)
      ui.computer_thinking_message
      computer_player.move
    end
  end

  def handle_game_over
    if self.result == :draw
      message = "The game was a draw!"
    else
      message = "#{result} is the winner!"
    end
    ui.log message
    exit 1
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

