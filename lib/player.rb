class Player
  attr_accessor :marker
  attr_reader :game

  def initialize options={}
    @marker = options[:marker] || "O"
    @game = options[:game]
  end

  def move(row, column)
    game.move(self.marker, row, column)
  end
end

