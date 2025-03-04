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

    it 'ticket status: open' do
      get(:index, params: {status: 'Open'})
      expect(assigns(:pagy)).to be_a(Pagy)
      expect(response).to be_successful
    end

    it 'ticket status: closed' do
      get(:index, params: {status: 'Closed'})
      expect(assigns(:pagy)).to be_a(Pagy)
      expect(response).to be_successful
    end

    it 'ticket status: captured' do
      get(:index, params: {status: 'Captured'})
      expect(assigns(:pagy)).to be_a(Pagy)
      expect(response).to be_successful
    end

    it 'ticket status: my captured' do
      get(:index, params: {status: 'My Captured'})
      expect(assigns(:pagy)).to be_a(Pagy)
      expect(response).to be_successful
    end

    it 'ticket status: my closed' do
      get(:index, params: {status: 'My Closed'})
      expect(assigns(:pagy)).to be_a(Pagy)
      expect(response).to be_successful
    end

    it 'ticket status: none' do
      get(:index, params: {status: ''})
      expect(assigns(:pagy)).to be_a(Pagy)
      expect(response).to be_successful
    end
  end
end
