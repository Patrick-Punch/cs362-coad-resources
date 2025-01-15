#TODO

require 'rails_helper'

RSpec.describe Region, type: :model do

  let(:region) { Region.new }

  it "has a name" do
    expect(region).to respond_to(:name)
  end

  it "has a string representation that is its name" do
    region.name = 'Mt. Hood'
    region.to_s
  end

  ## CARDINALITY

  it "has many tickets" do
    should have_many(:tickets)
  end

end
