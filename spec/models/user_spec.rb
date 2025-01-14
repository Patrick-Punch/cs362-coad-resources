require 'rails_helper'

RSpec.describe User, type: :model do

  it "has an email"  do
    user = User.new
    expect(user).to respond_to(:email)
  end

  it "has a role"  do
    user = User.new
    expect(user).to respond_to(:role)
  end

end
