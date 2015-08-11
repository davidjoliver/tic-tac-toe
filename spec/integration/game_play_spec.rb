require 'spec_helper'

describe "the gameplay" do
  let!(:game) { Game.new }
  let(:computer_player) { game.computer_player }
  let(:external_player) { game.external_player }

  context "when a square already has a value" do
    it "disallows marking the square" do
      game.board.grid[0][0] = "foo"
      game.move("Doesn't matter", 0, 0)
      expect(game.board.grid[0][0]).to eq "foo"
    end
  end

  context "computer is the first player" do
    it "chooses the upper left corner" do
      computer_player.move
      expect(game.board.value_at(0,0)).to eq computer_player.marker
    end
  end

  context "can't lose" do
    it "goes for the virtical block" do
      game.board = Board.new [
        ["X", "O", "X"],
        [nil, "O", nil],
        [nil, nil, nil],
      ]
      computer_player.move
      expect(game.board.value_at(2,1)).to eq computer_player.marker
    end

    it "goes for the horizontal block" do
      game.board = Board.new [
        [nil, "O", "O"],
        [nil, nil, nil],
        ["X", nil, nil],
      ]
      computer_player.move
      expect(game.board.value_at(0,0)).to eq computer_player.marker
    end

    it "goes for the diagonal block" do
      game.board = Board.new [
        ["O", nil, nil],
        [nil, "O", nil],
        ["X", nil, nil],
      ]
      computer_player.move
      expect(game.board.value_at(2,2)).to eq computer_player.marker
    end

    it "goes for the middle square block" do
      game.board = Board.new [
        ["X", nil, nil],
        ["O", nil, "O"],
        [nil, nil, nil],
      ]
      computer_player.move
      expect(game.board.value_at(1,1)).to eq computer_player.marker
    end

    it "makes the optimal defensive move" do
      game.board = Board.new [
        ["O", nil, nil],
        [nil, nil, nil],
        [nil, nil, nil],
      ]
      computer_player.move
      expect(game.board.value_at(1,1)).to eq computer_player.marker
    end
  end
end

