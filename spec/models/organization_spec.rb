require 'rails_helper'

RSpec.describe Organization, "it should have certain attributes" , type: :model do

  let(:org) { Organization.new }

  it "has eight agreements" do
    expect(org).to respond_to(:agreement_one)
    expect(org).to respond_to(:agreement_two)
    expect(org).to respond_to(:agreement_three)
    expect(org).to respond_to(:agreement_four)
    expect(org).to respond_to(:agreement_five)
    expect(org).to respond_to(:agreement_six)
    expect(org).to respond_to(:agreement_seven)
    expect(org).to respond_to(:agreement_eight)
  end

  it "has a status" do
    expect(org).to respond_to(:status)
  end

  it "has transportation" do
    expect(org).to respond_to(:transportation)
  end

  it "has users" do
    expect(org).to respond_to(:users)
  end

  it "has tickets" do
    expect(org).to respond_to(:tickets)
  end

  it "has resource categories" do
    expect(org).to respond_to(:resource_categories)
  end

  it "has an email" do
    expect(org).to respond_to(:email)
  end

  it "has a name" do
    expect(org).to respond_to(:name)
  end

  it "has a primary name" do
    expect(org).to respond_to(:primary_name)
  end

  it "has a secondary name" do
    expect(org).to respond_to(:secondary_name)
  end

  it "has a phone" do
    expect(org).to respond_to(:phone)
  end

  it "has a secondary phone" do
    expect(org).to respond_to(:secondary_phone)
  end

  it "has a description" do
    expect(org).to respond_to(:description)
  end

  ## CARDINALITY

  it "has many users" do
    should have_many(:users)
  end

  it "has many users" do
    should have_many(:tickets)
  end

  it "has and belongs to many resource categories" do
    should have_and_belong_to_many(:resource_categories)
  end

end
