require 'spec_helper'

describe Brain do
  context "within potential game scenarios" do
    let!(:game) { Game.new }
    let(:brain) { Brain.new(game: game) }

    it "awards 10 'points' if the computer wins" do
      game.board.result = game.computer_player.marker
      expect(brain.weight(game.board)).to eq 10
    end

    it "deducts 10 'points' if the opponent wins" do
      game.board.result = game.opponent.marker
      expect(brain.weight(game.board)).to eq -10
    end

    it "returns 0 for a draw" do
      game.board.result = :draw
      expect(brain.weight(game.board)).to eq 0
    end

    it "picks the highest score for computer" do
      weights = {[2, 0]=>10, [2, 1]=>0, [2, 2]=>-10}
      result = brain.do_min_max(game.computer_player.marker, weights)
      expect(result[0]).to eq [2,0]
    end

    it "picks the lowest score for opponent" do
      weights = {[2, 0]=>10, [2, 1]=>0, [2, 2]=>-10}
      result = brain.do_min_max(game.opponent.marker, weights)
      expect(result[0]).to eq [2,2]
    end
  end
end

