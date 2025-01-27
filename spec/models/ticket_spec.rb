require 'rails_helper'

RSpec.describe Ticket, type: :model do

  let (:ticket) { Ticket.new(id: 123) }

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
      expect(ticket).to validate_length_of(:name).is_at_most(255)
      expect(ticket).to validate_length_of(:name).is_at_least(1)
    end

    it "validates description length" do
      expect(ticket).to validate_length_of(:description).is_at_most(1020)
    end

    it "validates presence of phone" do
      expect(ticket).to validate_presence_of(:phone)
    end

    it "validates phony_plausible" do
      expect(ticket).not_to allow_value("hello").for(:phone)
      expect(ticket).to allow_value('+1-971-470-2258').for(:phone)
    end
  end

  ## MEMBER FUNCTION TESTS
  describe "member function tests" do
    it "should not be closed if open" do
      expect(ticket.open?).not_to eq "closed" 
    end

    it "should be captured if it belongs to an organization" do
      region = Region.create!(name: "region1")
      resource = ResourceCategory.create!(name: "resource1")

      organization = Organization.create!(
        name: "organization1",
        email: "organization@hotmail.com",
        phone: "+1-555-555-5555",
        secondary_phone: "+1-666-666-6666",
        status: "approved",
        primary_name: "primary",
        secondary_name: "secondary",
      )
      local_ticket = Ticket.create!(
        name: "ticket",
        phone: "+1-555-555-1212",
        region_id: region.id,
        resource_category_id: resource.id,
        organization_id: organization.id
      )
      expect(local_ticket.captured?).to eq true
    end

    it "converts to string" do
      expect(ticket.to_s).to eq "Ticket 123"
    end
  end

  describe "scope tests" do

    it "scopes open tickets" do
      region = Region.create!(name: "region1")
      resource = ResourceCategory.create!(name: "resource1")

      ticket = Ticket.create!(
        name: "ticket",
        phone: "+1-555-555-1212",
        region_id: region.id,
        resource_category_id: resource.id,
        organization_id: nil,
        closed: false
      )
      expect(Ticket.closed).to_not include(ticket)
      expect(Ticket.open).to include(ticket)
    end

    it "scopes closed tickets" do
      region = Region.create!(name: "region1")
      resource = ResourceCategory.create!(name: "resource1")

      ticket = Ticket.create!(
        name: "ticket",
        phone: "+1-555-555-1212",
        region_id: region.id,
        resource_category_id: resource.id,
        closed: true
      )

      # How we look at scopes:
      #Ticket.closed
      #Ticket.open

      expect(Ticket.closed).to include(ticket)
      expect(Ticket.open).to_not include(ticket)
    end
  end

end
