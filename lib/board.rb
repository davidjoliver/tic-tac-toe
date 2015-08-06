class Board
  attr_accessor :grid
  def initialize initial_grid_state=nil
    @grid = initial_grid_state || Array.new(3) { Array.new(3) { Square.new }}
  end

  def value_at(x, y)
    grid[x][y]
  end

  def mark_square(x, y, value)
    grid[x][y] = value
  end

  def diagonals
    [[grid[0][0], grid[1][1], grid[2][2]], [grid[0][2], grid[1][1], grid[2][0]]]
  end


  def lines
    rows + columns + diagonals
  end

  def rows
    grid
  end

  def columns
    grid.transpose
  end
end

