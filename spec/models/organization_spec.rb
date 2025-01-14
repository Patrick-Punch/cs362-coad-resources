require 'rails_helper'

RSpec.describe Organization, type: :model do

  it "has eight agreements" do
    organization = Organization.new
    expect(organization).to respond_to(:agreement_one)
    expect(organization).to respond_to(:agreement_two)
    expect(organization).to respond_to(:agreement_three)
    expect(organization).to respond_to(:agreement_four)
    expect(organization).to respond_to(:agreement_five)
    expect(organization).to respond_to(:agreement_six)
    expect(organization).to respond_to(:agreement_seven)
    expect(organization).to respond_to(:agreement_eight)
  end

  it "has a status" do
    organization = Organization.new
    expect(organization).to respond_to(:status)
  end

  it "has transportation" do
    organization = Organization.new
    expect(organization).to respond_to(:transportation)
  end

  it "has users" do
    organization = Organization.new
    expect(organization).to respond_to(:users)
  end

  it "has tickets" do
    organization = Organization.new
    expect(organization).to respond_to(:tickets)
  end

  it "has resource categories" do
    organization = Organization.new
    expect(organization).to respond_to(:resource_categories)
  end

  it "has an email" do
    organization = Organization.new
    expect(organization).to respond_to(:email)
  end

  it "has a name" do
    organization = Organization.new
    expect(organization).to respond_to(:name)
  end

  it "has a primary name" do
    organization = Organization.new
    expect(organization).to respond_to(:primary_name)
  end

  it "has a secondary name" do
    organization = Organization.new
    expect(organization).to respond_to(:secondary_name)
  end

  it "has a phone" do
    organization = Organization.new
    expect(organization).to respond_to(:phone)
  end

  it "has a secondary phone" do
    organization = Organization.new
    expect(organization).to respond_to(:secondary_phone)
  end

  it "has a description" do
    organization = Organization.new
    expect(organization).to respond_to(:description)
  end

end
