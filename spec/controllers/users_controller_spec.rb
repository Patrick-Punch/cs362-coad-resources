require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'UsersController exists and redirects to proper view' do
    let(:admin) { create(:user, :admin) }

    describe 'index' do
      it 'is succesful if logged in as admin' do
        sign_in admin
        get(:index)
        expect(response).to be_successful
      end

      it 'redirects to sign-in page if not logged in' do
        get(:index)
        expect(response).to redirect_to new_user_session_path
      end

      it 'redirects to dashboard if logged in but not admin' do
        user = create(:user)
        sign_in user
        get(:index)
        expect(response).to redirect_to dashboard_path
      end

    end

  end
end
