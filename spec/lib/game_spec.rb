require 'spec_helper'

describe Game do
  it "initializes with a board" do
    expect(subject.board).to_not be_nil
  end

  it "registers the computer player" do
    expect(subject.computer_player).to_not be_nil
  end

  it "registers the external player" do
    subject.external_player = Player.new(marker: "O")
    expect(subject.external_player.marker).to eq "O"
  end

  it "marks the specified square on a move" do
    subject.move "X", 1, 1
    subject.board.value_at(1, 1).should == "X"
  end

  context "game over" do
    example "with a win on a horizontal row" do
      row_1 = [Square.new(value: "X"), Square.new(value: "X"), Square.new(value: "X")]
      row_2 = [Square.new, Square.new, Square.new]
      row_3 = [Square.new, Square.new, Square.new]
      subject.board = Board.new [row_1, row_2, row_3]
      expect(subject.game_over?).to be_truthy
    end

    example "with a win on a vertical column" do
      row_1 = [Square.new(value: "X"), Square.new, Square.new]
      row_2 = [Square.new(value: "X"), Square.new, Square.new]
      row_3 = [Square.new(value: "X"), Square.new, Square.new]
      subject.board = Board.new [row_1, row_2, row_3]
      expect(subject.game_over?).to be_truthy
    end

    example "with a win on a diagonal" do
      row_1 = [Square.new(value: "X"), Square.new, Square.new]
      row_2 = [Square.new, Square.new(value: "X"), Square.new]
      row_3 = [Square.new, Square.new, Square.new(value: "X")]
      subject.board = Board.new [row_1, row_2, row_3]
      expect(subject.game_over?).to be_truthy
    end

    example "with a draw" do
      row_1 = [Square.new(value: "X"), Square.new(value: "X"), Square.new(value: "O")]
      row_2 = [Square.new(value: "O"), Square.new(value: "O"), Square.new(value: "X")]
      row_3 = [Square.new(value: "X"), Square.new(value: "O"), Square.new(value: "X")]
      subject.board = Board.new [row_1, row_2, row_3]
      expect(subject.game_over?).to be_truthy
    end

    it "knows that the game has not ended" do
      row_1 = [Square.new(value: "X"), Square.new, Square.new(value: "O")]
      row_2 = [Square.new(value: "O"), Square.new(value: "O"), Square.new(value: "X")]
      row_3 = [Square.new(value: "X"), Square.new(value: "O"), Square.new(value: "X")]
      subject.board = Board.new [row_1, row_2, row_3]
      expect(subject.game_over?).to be_falsey
    end

    it "knows how the game ended" do
      row_1 = [Square.new(value: "X"), Square.new(value: "X"), Square.new(value: "O")]
      row_2 = [Square.new(value: "O"), Square.new(value: "O"), Square.new(value: "X")]
      row_3 = [Square.new(value: "X"), Square.new(value: "O"), Square.new(value: "X")]
      subject.board = Board.new [row_1, row_2, row_3]
      subject.game_over?
      expect(subject.result).to eq :draw
    end

    it "knows that there was a winner" do
      row_1 = [Square.new(value: "X"), Square.new(value: "X"), Square.new(value: "X")]
      row_2 = [Square.new, Square.new, Square.new]
      row_3 = [Square.new, Square.new, Square.new]
      subject.board = Board.new [row_1, row_2, row_3]
      subject.game_over?
      expect(subject.result).to eq "X"
    end
  end

  context "about to win" do
    example "except if no playable trailing square" do
      line = [Square.new(value: 1), Square.new(value: 1), Square.new(value: "Foo")]
      expect(subject.winning_move_for_line line, 1).to eq nil
    end

    example "if two leading same values" do
      line = [Square.new(value: 1), Square.new(value: 1), Square.new]
      expect(subject.winning_move_for_line line, 1).to eq 2
    end

    example "except if no playable leading square" do
      line = [Square.new(value: "foo"), Square.new(value: 1), Square.new(value: 1)]
      expect(subject.winning_move_for_line line, 1).to eq nil
    end

    example "if two trailing same values" do
      line = [Square.new, Square.new(value: 1), Square.new(value: 1)]
      expect(subject.winning_move_for_line line, 1).to eq 0
    end

    example "unless no two in a row" do
      line = [Square.new, Square.new, Square.new(value: 1)]
      expect(subject.winning_move_for_line line, 1).to be_nil
    end

    example "except if no playable middle square" do
      line = [Square.new(value: 1), Square.new(value: "bar"), Square.new(value: 1)]
      expect(subject.winning_move_for_line line, 1).to eq nil
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
      game = Game.new(board)
      expect(game.winning_moves "X").to eq [[0,2]]
    end

    it "knows that X can not win yet" do
      row_1 = [Square.new(value: "X"), Square.new, Square.new]
      row_2 = [Square.new, Square.new, Square.new]
      row_3 = [Square.new, Square.new, Square.new]
      board = Board.new [row_1, row_2, row_3]
      game = Game.new(board)
      expect(game.winning_moves "X").to be_empty
    end
  end
end

