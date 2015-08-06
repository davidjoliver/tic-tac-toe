require 'spec_helper'

describe ComputerPlayer do
  it "initializes with X" do
    expect(subject.marker).to eq "X"
  end

  example "marker can be set" do
    subject.marker = "foo"
    expect(subject.marker).to eq "foo"
  end

  describe "the computer player's turn" do
    let(:game) do
      game = TicTacToe.new
      game.external_player = Player.new
      game
    end

    it "knows it can win on the next move" do
      computer_player = game.computer_player
      expect(game).to receive(:winning_moves).with(computer_player.marker).and_return [[0,0]]
      computer_player.move
    end

    it "knows it can win on the next move" do
      computer_player = game.computer_player
      expect(game).to receive(:winning_moves).with(game.external_player.marker).and_return [[0,0]]
      computer_player.move
    end
  end
end

