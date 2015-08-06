class Player
  attr_accessor :marker
  attr_reader :game

  def initialize options={}
    @marker = options[:marker] || "O"
    @game = options[:game]
  end

  def move(coordinates=nil)
    game.move(self.marker, *coordinates)
  end
end

