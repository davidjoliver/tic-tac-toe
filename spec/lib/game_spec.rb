require 'spec_helper'

describe Game do
  it "initializes with a board" do
    expect(subject.board).to_not be_nil
  end

  it "registers the computer player" do
    expect(subject.computer_player).to_not be_nil
  end

  it "registers the external player" do
    subject.opponent = Player.new(marker: "O")
    expect(subject.opponent.marker).to eq "O"
  end

  it "marks the specified square on a move" do
    subject.move "X", 1, 1
    subject.board.value_at(1, 1).should == "X"
  end
end

