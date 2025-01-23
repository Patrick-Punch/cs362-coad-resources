require 'rails_helper'

RSpec.describe Organization, "it should have certain attributes" , type: :model do

  let(:org) { Organization.new(id: 123, name: 'Patrick', phone: '1111111111', primary_name: 'Patrick', secondary_name: 'punch') }

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
  describe "cardinality tests" do
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

  ## VALIDATION TESTS
  describe "validation tests" do 

    ##Pesences of 
    it "validates presence of email" do 
      expect(org).to validate_presence_of(:email)
    end
    it "validates presence of name" do 
      expect(org).to validate_presence_of(:name)
    end
    it "validates presence of phone" do 
      expect(org).to validate_presence_of(:phone)
    end
    it "validates presence of status" do 
      expect(org).to validate_presence_of(:status)
    end
    it "validates presence of primary_name" do 
      expect(org).to validate_presence_of(:primary_name)
    end
    it "validates presence of secondary_name" do 
      expect(org).to validate_presence_of(:secondary_name)
    end
    it "validates presence of secondary_phone" do 
      expect(org).to validate_presence_of(:secondary_phone)
    end
    
      #Length 
    it "validates email length" do
      expect(org).to validate_length_of(:email).is_at_most(255)
      expect(org).to validate_length_of(:email).is_at_least(1)
    end
    it "validates name length" do
      expect(org).to validate_length_of(:name).is_at_most(255)
      expect(org).to validate_length_of(:name).is_at_least(1)
    end
    it "validates description length" do
      expect(org).to validate_length_of(:description).is_at_most(1020)
    end

      #email format 
      specify {
        should allow_values('pppunch@hotmail.com','aksdjhf3h423kha@osu.edu').for(:email)
      }
    
    #uniqueness 
    it "validates uniqueness of email" do 
      expect(org).to validate_uniqueness_of(:email).case_insensitive
    end
    it "validates uniqueness of name" do 
      expect(org).to validate_uniqueness_of(:name).case_insensitive
    end
  end 

## MEMBER FUNCTION TESTS
describe "member function tests" do
  let(:organization) { Organization.new(name: 'example', email: 'example@hotmail.com') }
  it "returns the organization's name when to_s is called" do
    expect(organization.to_s).to eq 'example'
  end
  it "sets the status to approved" do
    org.approve
    expect(org.status).to eq 'approved'
  end

  it "sets the status to rejected" do
    org.reject
    expect(org.status).to eq 'rejected'
  end

  it "sets the default status to submitted when no status is provided" do
    organization = Organization.new(name: 'Example Org', email: 'example@hotmail.com')
    expect(organization.status).to eq 'submitted'
  end

  it "does not override an already set status" do
    organization = Organization.new(name: 'Example Org', email: 'example@hotmail.com', status: :approved)
    expect(organization.status).to eq 'approved'
  end

end 

describe "scope tests" do

end
end
