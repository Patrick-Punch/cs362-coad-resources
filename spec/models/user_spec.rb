require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user) { User.new(email: 'example@hotmail.com') }

  describe "attribute tests" do
    it "has an email"  do
      expect(user).to respond_to(:email)
    end

    it "has a role"  do
      expect(user).to respond_to(:role)
    end

    it "can belong to an organization" do
      should belong_to(:organization).optional
    end

  end

  describe "validator tests" do
    specify { expect(user).to validate_presence_of(:email) }
    specify { expect(user).to validate_length_of(:email).is_at_most(255) }
    specify { expect(user).to validate_length_of(:email).is_at_least(1) }
    specify {
      should allow_values('foobarfoo@gmail.com','losthongking@micros.org').for(:email)
    }
    specify { expect(user).to validate_uniqueness_of(:email).case_insensitive }
    specify { expect(user).to validate_presence_of(:password).on(:create) }
    specify { expect(user).to validate_length_of(:password).is_at_most(255) }
    specify { expect(user).to validate_length_of(:password).is_at_least(7) }
  end

  describe "member function tests" do
    it "should return an email on to_s" do
      expect(user.to_s).to eq 'example@hotmail.com'
    end

    it "defines role as only accepting a value of admin or organization" do
      should define_enum_for(:role).with_values(%i[admin organization])
    end

    it "has a default value of organization" do
      expect(user.role).to eq("organization")
    end

    it "will reassign to a new value" do
      user.role = :admin
      expect(user.role).to eq "admin"
    end

  end

end
