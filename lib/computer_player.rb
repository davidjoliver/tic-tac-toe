class ComputerPlayer < Player
  def initialize options={}
    super(options.merge!(marker: "X"))
  end

  def move
    my_winning_moves = game.winning_moves(self.marker)
    opponent_winning_moves = game.winning_moves(game.external_player.marker)
    if my_winning_moves.empty? && !opponent_winning_moves.empty?
      super(opponent_winning_moves.first)
    elsif !my_winning_moves.empty?
      super(my_winning_moves.first)
    else
      super(game.board.empty_squares.first)
    end
  end
end

