require 'spec_helper'

describe "the gameplay" do
  let!(:game) { TicTacToe.new }
  let(:computer_player) { game.computer_player }
  let(:external_player) { game.external_player }

  context "when a square already has a value" do
    it "disallows marking the square" do
      game.board.grid[0][0].value = "foo"
      game.move("Doesn't matter", 0, 0)
      expect(game.board.grid[0][0].value).to eq "foo"
    end
  end

  context "when a player is in a turn" do
    it "disallows the opponent to move" do
      game.current_player = "Foo"
      expect(game.move("", 0, 0)).to eq :opponent_in_turn
    end
  end

  context "as the computer player" do
    it "marks the first empty spot" do
      row_1 = [Square.new(value: "X"), Square.new, Square.new]
      row_2 = [Square.new, Square.new, Square.new(value: "Foo")]
      row_3 = [Square.new, Square.new, Square.new]
      game.board = Board.new [row_1, row_2, row_3]
      expect(game).to receive(:move).with(computer_player.marker, 0, 1)
      computer_player.move
    end

    it "knows it can win on the next move" do
      allow(game).to receive(:winning_moves).with(external_player.marker).and_return [[0,0]]
      expect(game).to receive(:winning_moves).with(computer_player.marker).and_return [[0,0]]
      computer_player.move
    end

    it "knows the opponent can win on the next move" do
      allow(game).to receive(:winning_moves).with(computer_player.marker).and_return [[0,0]]
      expect(game).to receive(:winning_moves).with(game.external_player.marker).and_return [[0,0]]
      computer_player.move
    end

    it "makes the move to win" do
      allow(game).to receive(:winning_moves).with(computer_player.marker).and_return [[0,0]]
      allow(game).to receive(:winning_moves).with(external_player.marker).and_return [[1,1]]
      expect(game).to receive(:move).with(computer_player.marker, 0, 0)
      computer_player.move
    end

    it "makes the move to block" do
      allow(game).to receive(:winning_moves).with(computer_player.marker).and_return []
      allow(game).to receive(:winning_moves).with(external_player.marker).and_return [[1,1]]
      expect(game).to receive(:move).with(computer_player.marker, 1, 1)
      computer_player.move
    end
  end
end

