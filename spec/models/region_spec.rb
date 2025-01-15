#TODO

require 'rails_helper'

RSpec.describe Region, type: :model do

  let(:region) { Region.new }

  it "has a name" do
    expect(region).to respond_to(:name)
  end

  it "has a string representation that is its name" do
    region.name = 'Mt. Hood'
    result = region.to_s
  end

end
