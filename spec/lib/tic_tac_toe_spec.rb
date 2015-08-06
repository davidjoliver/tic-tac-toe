require 'spec_helper'

describe TicTacToe do
  it "initializes with a board" do
    expect(subject.board).to_not be_nil
  end

  context "about to win" do
    example "if two leading same values" do
      line = [Square.new(value: 1), Square.new(value: 1), Square.new]
      expect(subject.winning_move_for_line line, 1).to eq 2
    end

    example "if two trailing same values" do
      line = [Square.new, Square.new(value: 1), Square.new(value: 1)]
      expect(subject.winning_move_for_line line, 1).to eq 0
    end

    example "unless no two in a row" do
      line = [Square.new, Square.new, Square.new(value: 1)]
      expect(subject.winning_move_for_line line, 1).to be_nil
    end

    example "if same on edges" do
      line = [Square.new(value: 1), Square.new, Square.new(value: 1)]
      expect(subject.winning_move_for_line line, 1).to eq 1
    end
  end

  context "position knowledge" do
    it "knows if X can win on the next move" do
      row_1 = [Square.new(value: "X"), Square.new(value: "X"), Square.new(row: 0, column: 2)]
      row_2 = [Square.new, Square.new, Square.new]
      row_3 = [Square.new, Square.new, Square.new]
      board = Board.new([row_1, row_2, row_3])
      game = TicTacToe.new(board)
      expect(game.winning_moves "X").to eq [[0,2]]
    end

    it "knows that X can not win yet" do
      row_1 = [Square.new(value: "X"), Square.new, Square.new]
      row_2 = [Square.new, Square.new, Square.new]
      row_3 = [Square.new, Square.new, Square.new]
      board = Board.new [row_1, row_2, row_3]
      game = TicTacToe.new(board)
      expect(game.winning_moves "X").to be_empty
    end
  end
end

