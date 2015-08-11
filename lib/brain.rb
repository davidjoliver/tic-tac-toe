# Use 'Min-Max' algorithm to score possible moves and pick the highest-scored one
class Brain
  attr_accessor :player, :game, :best_move

  def initialize options={}
    @game = options[:game]
    @computer = @game.computer_player
    @player = Player.new(marker: @computer.marker == "X" ? "O" : "X")
  end

  def ponder_moves(board, marker)
    return weight(board) if board.game_over?

    weights = {}.tap do |memo|
      board.empty_squares.each do |square|
        dup_board = board.dup
        dup_board.mark_square(marker, square[0], square[1])
        memo[square] = ponder_moves(dup_board, flip_marker(marker))
      end
    end

    min_max = do_min_max marker, weights
    @best_move = min_max[0]
    min_max[1]
  end

  def weight(board)
    if board.result == @computer.marker
      return 10
    elsif board.result == @player.marker
      return -10
    end
    0
  end

  def do_min_max(marker, weights)
    if marker == @computer.marker
      weights.max_by {|k, v| v}
    else
      weights.min_by {|k, v| v}
    end
  end

  def flip_marker marker
    marker == "X" ? "O" : "X"
  end
end

