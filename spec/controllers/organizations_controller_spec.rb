RSpec.describe OrganizationsController, type: :controller do
    let(:user) { FactoryBot.create(:user) }
    let(:admin) { FactoryBot.create(:user, :admin) }
    let(:organization) { FactoryBot.create(:organization) }
    let(:unapproved_user) { FactoryBot.create(:user, organization: nil) }
    let(:approved_user) { FactoryBot.create(:user, organization: organization) }
  
    before do
      allow(UserMailer).to receive_message_chain(:with, :new_organization_application, :deliver_now)
    end
  
    describe 'as a logged-out user' do
      it 'index redirects to login' do
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end
  
      it 'create redirects to login' do
        post :create, params: { organization: FactoryBot.attributes_for(:organization) }
        expect(response).to redirect_to(new_user_session_path)
      end
  
      it 'new redirects to login' do
        get :new
        expect(response).to redirect_to(new_user_session_path)
      end
  
      it 'show redirects to login' do
        get :show, params: { id: organization.id }
        expect(response).to redirect_to(new_user_session_path)
      end
  
      it 'edit redirects to login' do
        get :edit, params: { id: organization.id }
        expect(response).to redirect_to(new_user_session_path)
      end
  
      it 'update redirects to login' do
        patch :update, params: { id: organization.id, organization: { name: 'Updated Name' } }
        expect(response).to redirect_to(new_user_session_path)
      end
  
      it 'approve redirects to login' do
        post :approve, params: { id: organization.id }
        expect(response).to redirect_to(new_user_session_path)
      end
  
      it 'reject redirects to login' do
        post :reject, params: { id: organization.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  
    describe 'as a logged-in user without organization' do
      before { sign_in unapproved_user }
  
      it 'index renders successfully' do
        get :index
        expect(response).to be_successful
      end
  
      it 'create redirects to application submitted page' do
        post :create, params: { organization: FactoryBot.attributes_for(:organization) }
        expect(response).to redirect_to(organization_application_submitted_path)
      end
  
      it 'new renders successfully' do
        get :new
        expect(response).to be_successful
      end
  
      it 'show redirects to dashboard' do
        get :show, params: { id: organization.id }
        expect(response).to redirect_to(dashboard_path)
      end
  
      it 'edit redirects to dashboard' do
        get :edit, params: { id: organization.id }
        expect(response).to redirect_to(dashboard_path)
      end
  
      it 'update redirects to dashboard' do
        patch :update, params: { id: organization.id, organization: { name: 'Updated Name' } }
        expect(response).to redirect_to(dashboard_path)
      end
  
      it 'approve redirects to dashboard' do
        post :approve, params: { id: organization.id }
        expect(response).to redirect_to(dashboard_path)
      end
  
      it 'reject redirects to dashboard' do
        post :reject, params: { id: organization.id }
        expect(response).to redirect_to(dashboard_path)
      end
    end
  
    describe 'as logged-in user with organization' do
      before { sign_in approved_user }
  
      it 'index renders successfully' do
        get :index
        expect(response).to be_successful
      end
  
      it 'create redirects to dashboard' do
        post :create, params: { organization: FactoryBot.attributes_for(:organization) }
        expect(response).to redirect_to(dashboard_path)
      end
  
      it 'new redirects to dashboard' do
        get :new
        expect(response).to redirect_to(dashboard_path)
      end
  
      it 'show redirects to dashboard' do
        get :show, params: { id: organization.id }
        expect(response).to redirect_to(dashboard_path)
      end
  
      it 'edit redirects to dashboard' do
        get :edit, params: { id: organization.id }
        expect(response).to redirect_to(dashboard_path)
      end
  
      it 'update redirects to dashboard' do
        patch :update, params: { id: organization.id, organization: { name: 'Updated Name' } }
        expect(response).to redirect_to(dashboard_path)
      end
  
      it 'approve redirects to dashboard' do
        post :approve, params: { id: organization.id }
        expect(response).to redirect_to(dashboard_path)
      end
  
      it 'reject redirects to dashboard' do
        post :reject, params: { id: organization.id }
        expect(response).to redirect_to(dashboard_path)
      end
    end
  
    describe 'as admin' do
      before { sign_in admin }
  
      it 'index renders successfully' do
        get :index
        expect(response).to be_successful
      end
  
      it 'create redirects to dashboard' do
        post :create, params: { organization: FactoryBot.attributes_for(:organization) }
        expect(response).to redirect_to(dashboard_path)
      end
  
      it 'new redirects to dashboard' do
        get :new
        expect(response).to redirect_to(dashboard_path)
      end
  
      it 'show renders successfully' do
        get :show, params: { id: organization.id }
        expect(response).to be_successful
      end
  
      it 'edit redirects to dashboard' do
        get :edit, params: { id: organization.id }
        expect(response).to redirect_to(dashboard_path)
      end
  
      it 'update redirects to dashboard' do
        patch :update, params: { id: organization.id, organization: { name: 'Updated Name' } }
        expect(response).to redirect_to(dashboard_path)
      end
  
      it 'approve redirects to organizations index' do
        post :approve, params: { id: organization.id }
        organization.reload
        expect(organization.status).to eq('approved')
        expect(response).to redirect_to(organizations_path)
      end
  
      it 'reject redirects to organizations index' do
        post :reject, params: { id: organization.id, organization: { rejection_reason: 'Test Reason' } }
        organization.reload
        expect(organization.status).to eq('rejected')
        expect(response).to redirect_to(organizations_path)
      end
    end
  end