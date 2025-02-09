require 'rails_helper'

RSpec.describe Region, type: :model do

  let(:region) { build(:region) }

  it "has a name" do
    expect(region).to respond_to(:name)
  end

  it "has a string representation that is its name" do
    expect(region.to_s).to eq region.name
  end

  ## CARDINALITY
  it "has many tickets" do
    should have_many(:tickets)
  end

  ## VALIDATION
  describe "validation tests" do

    it "validates presence of name" do
      expect(region).to validate_presence_of(:name)
    end

    it "validates name length" do
      expect(region).to validate_length_of(:name).is_at_most(255)
      expect(region).to validate_length_of(:name).is_at_least(1)
    end

    it "validates uniqueness of name" do
      expect(region).to validate_uniqueness_of(:name).case_insensitive
    end
  end

  ## MEMBER FUNCTION TESTS
  describe "member function tests" do

    it "can be unspecified" do
      region = Region.unspecified
      expect(region.name).to eq "Unspecified"
    end

    it "has a string representation that is its name" do
        expect(region.to_s).to eq region.name
      end
  end
end
