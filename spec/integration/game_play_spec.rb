require 'spec_helper'

describe "the gameplay" do
  context "as the computer player" do
    let!(:game) do
      game = TicTacToe.new
      game.external_player = Player.new
      game
    end

    let(:computer_player) { game.computer_player }
    let(:external_player) { game.external_player }

    it "knows it can win on the next move" do
      expect(game).to receive(:move).with(computer_player.marker).and_return [[0,0]]
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
      allow(game).to receive(:winning_moves).with(computer_player.marker).and_return nil
      allow(game).to receive(:winning_moves).with(external_player.marker).and_return [[1,1]]
      expect(game).to receive(:move).with(computer_player.marker, 1, 1)
      computer_player.move
    end
  end
end
