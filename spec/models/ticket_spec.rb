require 'rails_helper'

RSpec.describe Ticket, type: :model do

  let(:ticket) { Ticket.new }

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
