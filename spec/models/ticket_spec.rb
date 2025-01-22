require 'rails_helper'

RSpec.describe Ticket, type: :model do

  let(:ticket) { Ticket.new(:id = 123) }

  describe "attribute tests" do
    it "has a name" do
      expect(ticket).to respond_to(:name)
    end

    it "has a description" do
      expect(ticket).to respond_to(:description)
    end

    it "has a phone" do
      expect(ticket).to respond_to(:phone)
    end

    it "has a closed attribute"  do
      expect(ticket).to respond_to(:closed)
    end
  end

  ## CARDINALITY
  describe "cardinality tests" do
    it "belongs to a region" do
      should belong_to(:region)
    end

    it "belongs to a resource category" do
      should belong_to(:resource_category)
    end

    it "can belong to an organization" do
      should belong_to(:organization).optional
    end
  end

  ## VALIDATION TESTS
  describe "validation tests" do
    it "validates presence of name" do
      expect(ticket).to validate_presence_of(:name)
    end

    it "validates name length" do
      expect(ticket).to validate_length_of(:name)is_at_most(255)
      expect(ticket).to validate_length_of(:name)is_at_least(1)
    end
  end

  ## MEMBER FUNCTION TESTS
  describe "member function tests" do
    it "converts to string" do
      expect(ticket.to_s).to eq "Ticket 123"
    end
  end

  ## SCOPE TESTS
  describe "scope tests" do
    it "scopes closed tickets" do 
      region = Region.create!(name: "region1")
      resource_category = ResourceCategory.create!(name: "resource1")

      ticket = Ticket.create!(
        name: "ticket",
        phone: "+1-555-555-1212",
        region_id: region.id,
        resource_category_id: resource.id,
        closed: true
      )

      # How we look at scopes:
      # Ticket.closed
      # Ticket.open
      
      expect(Ticket.closed).to include(ticket)
      expect(Ticket.open).to_not include(ticket)
    end
  end

end
