class Board
  attr_accessor :grid, :result
  def initialize initial_grid_state=nil
    @grid = initial_grid_state || Array.new(3) { Array.new(3) }
  end

  def empty_state?
    grid.each do |row|
      row.each do |square|
        return false unless square.to_s.empty?
      end
    end
    true
  end

  def dup
    Board.new(Array.new(3) { |row| Array.new(3) { |col|
          self.grid[row][col]
        }
      }
    )
  end

  def empty_squares
    [].tap do |memo|
      grid.each_with_index do |row, row_index|
        row.each_with_index do |square, col_index|
          memo << [row_index, col_index] if square.nil?
        end
      end
    end
  end

  def value_at(row, column)
    grid[row][column]
  end

  def mark_square(value, row, column)
    grid[row][column] = value
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

  def game_over?
    did_win? || did_draw?
  end

  def did_draw?
    lines.each do |line|
      return false if line.any? { |square| square.to_s.empty? }
    end
    self.result = :draw
    true
  end

  def did_win?
    lines.each do |line|
      if line.all? { |square| square == line[0] && !square.nil? }
        self.result = line.first
        return true
      end
    end
    false
  end

  def show
    grid.each do |line|
      one = line[0].to_s.empty? ? "_" : line[0]
      two = line[1].to_s.empty? ? "_" : line[1]
      three = line[2].to_s.empty? ? "_" : line[2]
      print "#{one}|#{two}|#{three}\n"
    end
    nil
  end
end

