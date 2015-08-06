class ComputerPlayer < Player
  def initialize options={}
    super(options.merge!(marker: "X"))
  end

  def move
    my_winning_moves = game.winning_moves(self.marker)
    opponent_winning_moves = game.winning_moves(game.external_player.marker)
    if my_winning_moves.nil? && !opponent_winning_moves.nil?
      super(opponent_winning_moves.first)
    else
      super(my_winning_moves.first)
    end
  end
end

