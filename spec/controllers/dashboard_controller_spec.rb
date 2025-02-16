require 'rails_helper'

RSpec.describe DashboardController, type: :controller do

  describe "logged out user" do
    let(:user) { create(:user) }

    it 'index' do
      expect(get(:index)).to redirect_to new_user_session_path
    end
  end

  describe "logged in user" do
    let(:user) { create(:user) }
    before(:each) { sign_in user }

    it 'index' do
      expect(get(:index)).to be_successful
    end
  end

  describe "admin user" do
    let(:user) { create(:user, :admin) }
    before(:each) { sign_in user }

    it 'index' do
      expect(get(:index)).to be_successful
    end
  end
end
