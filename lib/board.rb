class Board
  attr_accessor :grid
  def initialize initial_grid_state=nil
    @grid = initial_grid_state || Array.new(3) { Array.new(3) { Square.new }}
  end

  def value_at(row, column)
    grid[row][column].value
  end

  def mark_square(value, row, column)
    grid[row][column].value = value
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

