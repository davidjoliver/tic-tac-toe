require 'spec_helper'

describe Board do
  context "initializing with a grid" do
    it "has 3 rows" do
      expect(subject.grid.size).to eq 3
    end

    example "the rows have 3 columns" do
      subject.grid.each do |row|
        expect(row.size).to eq 3
      end
    end

    it "can be initialized with an initial state" do
      grid_double = double(:grid)
      board = Board.new(grid_double)
      expect(board.grid).to eq grid_double
    end
  end

  describe "access to the grid" do
    it "grants access to a square" do
      board = Board.new([
        [1, Square.new(value: 2), 3],
        [4, 5, 6],
        [7, 8, 9],
      ])
      expect(board.value_at(0, 1)).to eq 2
    end

    it "allows setting the value for a specific square" do
      subject.mark_square("foo", 0, 0)
      expect(subject.value_at(0,0)).to eq "foo"
    end
  end

  describe "game state" do
    let(:board) {
      Board.new([
        [1, 2, 3],
        [4, 5, 6],
        [7, 8, 9],
      ])
    }

    it "returns the values of the two diagonal rows" do
      expect(board.diagonals).to eq [[1,5,9], [3,5,7]]
    end

    it "returns the collection of all possible lines" do
      all_lines = [
        [1,2,3],
        [4,5,6],
        [7,8,9],
        [1,4,7],
        [2,5,8],
        [3,6,9],
        [1,5,9],
        [3,5,7]
      ]
      expect(board.lines).to eq all_lines
    end

    it "finds all the empty squares" do
      row_1 = [Square.new(value: "X"), Square.new(value: "X"), Square.new]
      row_2 = [Square.new, Square.new(value: "Bar"), Square.new(value: "Foo")]
      row_3 = [Square.new, Square.new, Square.new(value: "Baz")]
      board = Board.new [row_1, row_2, row_3]
      board.empty_squares.should =~ [[0,2], [1,0], [2, 0], [2,1]]
    end
  end
end

