class ComputerPlayer < Player
  def initialize options={}
    super(options.merge!(marker: "X"))
  end

  def brain
    @brain ||= Brain.new game: self.game
  end

  def move
    if game.unplayed?
      super(0,0)
    else
      brain.ponder_moves game.board, self.marker
      super(*brain.best_move)
    end
  end
end

