require 'spec_helper'

describe Robot do
  it "beeps" do
    expect(Robot.new.beep).to eq("eee")
  end
end