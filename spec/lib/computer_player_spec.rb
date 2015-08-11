require 'spec_helper'

describe ComputerPlayer do
  it "initializes with X" do
    expect(subject.marker).to eq "X"
  end

  example "marker can be set" do
    subject.marker = "foo"
    expect(subject.marker).to eq "foo"
  end
end

