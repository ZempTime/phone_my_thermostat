require 'rails_helper'
require 'ostruct'

RSpec.describe ThermostatConverser, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"

  it "identifies number in range" do
    message = OpenStruct.new(body: "77")
    expect(ThermostatConverser::Identifier.execute(message)).to eq("SetTarget")
  end

  it "identifies number out of range" do
    message = OpenStruct.new(body: "777")
    expect(ThermostatConverser::Identifier.execute(message)).to eq("InvalidSetTarget")
  end

  it "identifies away" do
    message = OpenStruct.new(body: "away")
    expect(ThermostatConverser::Identifier.execute(message)).to eq("SetAway")
  end

  it "identifies target query" do
    message = OpenStruct.new(body: "target")
    expect(ThermostatConverser::Identifier.execute(message)).to eq("QueryTarget")
  end

  it "identifies target query" do
    message = OpenStruct.new(body: "current")
    expect(ThermostatConverser::Identifier.execute(message)).to eq("QueryCurrent")
  end
end
