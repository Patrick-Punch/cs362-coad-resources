require 'rails_helper'

RSpec.describe Ticket, type: :model do

  let (:ticket) { Ticket.new }

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
      organization = create(:organization)
      ticket = Ticket.new(organization_id: organization.id)

      expect(ticket.captured?).to eq true
    end

    it "should be not be captured if it doesn't belong to an organization" do
      expect(ticket.captured?).to eq false
    end

    it "is an id as a string" do
      ticket.id = 123
      expect(ticket.to_s).to eq "Ticket #{ticket.id}"
    end

    it "is empty if there's no id" do
      expect(ticket.to_s).to eq "Ticket "
    end
  end

  describe "scope tests" do

    it "should include open tickets in an open scope" do
      ticket = create(
        :ticket,
        closed: false
      )

      expect(Ticket.open).to include(ticket)
      expect(Ticket.closed).to_not include(ticket)
    end

    it "include closed tickets in a closed scope" do
      ticket = create(
        :ticket,
        closed: true
      )

      expect(Ticket.closed).to include(ticket)
      expect(Ticket.open).to_not include(ticket)
    end
  end

end
