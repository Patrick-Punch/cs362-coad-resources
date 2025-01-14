require 'rails_helper'

RSpec.describe Ticket, type: :model do


  it "has a name" do
    ticket = Ticket.new
    expect(ticket).to respond_to(:name)
  end

  it "has a description" do
    ticket = Ticket.new
    expect(ticket).to respond_to(:description)
  end

  it "has a phone" do
    ticket = Ticket.new
    expect(ticket).to respond_to(:phone)
  end

  it "has a closed attribute"  do
    ticket = Ticket.new
    expect(ticket).to respond_to(:closed)
  end

end
