RSpec.describe OrganizationsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:admin) { FactoryBot.create(:user, :admin) }
  let(:organization) { FactoryBot.create(:organization) }
  let(:unapproved_user) { FactoryBot.create(:user, organization: nil) }
  let(:approved_user) { FactoryBot.create(:user, :organization_approved, organization: organization) }

  before do
    allow(UserMailer).to receive_message_chain(:with, :new_organization_application, :deliver_now)
  end

  describe 'as a logged-out user' do
    it 'index redirects to login' do
      get :index
      expect(response).to redirect_to(new_user_session_path)
    end

    it 'create' do
      post :create, params: { organization: FactoryBot.attributes_for(:organization) }
      expect(response).to redirect_to(new_user_session_path)
    end

    it 'new' do
      get :new
      expect(response).to redirect_to(new_user_session_path)
    end

    it 'show' do
      get :show, params: { id: organization.id }
      expect(response).to redirect_to(new_user_session_path)
    end

    it 'edit' do
      get :edit, params: { id: organization.id }
      expect(response).to redirect_to(new_user_session_path)
    end

    it 'update' do
      patch :update, params: { id: organization.id, organization: { name: 'Updated Name' } }
      expect(response).to redirect_to(new_user_session_path)
    end

    it 'approve' do
      post :approve, params: { id: organization.id }
      expect(response).to redirect_to(new_user_session_path)
    end

    it 'reject' do
      post :reject, params: { id: organization.id }
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe 'as a logged-in user without organization' do
    let(:unapproved_user) { FactoryBot.create(:user, organization: nil) }
    let(:invalid_organization_params) { FactoryBot.attributes_for(:organization, name: nil) }

    before { sign_in unapproved_user }

    context 'when organization creation fails' do
      it 'renders the new template and assigns @organization' do
        post :create, params: { organization: invalid_organization_params }
        expect(response).to render_template(:new)
        expect(assigns(:organization)).to be_a_new(Organization)
      end
    end

    it 'index' do
      get :index
      expect(response).to be_successful
    end

    it 'create' do
      post :create, params: { organization: FactoryBot.attributes_for(:organization) }
      expect(response).to redirect_to(organization_application_submitted_path)
    end

    it 'new' do
      get :new
      expect(response).to be_successful
    end

    it 'show' do
      get :show, params: { id: organization.id }
      expect(response).to redirect_to(dashboard_path)
    end

    it 'edit' do
      get :edit, params: { id: organization.id }
      expect(response).to redirect_to(dashboard_path)
    end

    it 'update' do
      patch :update, params: { id: organization.id, organization: { name: 'Updated Name' } }
      expect(response).to redirect_to(dashboard_path)
    end

    it 'approve' do
      post :approve, params: { id: organization.id }
      expect(response).to redirect_to(dashboard_path)
    end

    it 'reject' do
      post :reject, params: { id: organization.id }
      expect(response).to redirect_to(dashboard_path)
    end
  end

  describe 'as logged-in user with organization' do
    let(:approved_user) { FactoryBot.create(:user, :organization_approved) }
    let(:invalid_organization) { FactoryBot.attributes_for(:organization, name: nil) }

    before { sign_in approved_user }

    context 'when organization update fails' do
      it 'redirects to dashboard' do
        patch :update, params: { id: organization.id, organization: invalid_organization }
        expect(response).to render_template(:edit)
      end
    end

    it 'index' do
      get :index
      expect(response).to be_successful
    end

    it 'create' do
      post :create, params: { organization: FactoryBot.attributes_for(:organization) }
      expect(response).to redirect_to(dashboard_path)
    end

    it 'new' do
      get :new
      expect(response).to redirect_to(dashboard_path)
    end

    it 'show' do
      get :show, params: { id: organization.id }
      expect(response).to be_successful
    end

    it 'edit' do
      get :edit, params: { id: organization.id }
      expect(response).to be_successful
    end

    it 'update' do
      patch :update, params: { id: organization.id, organization: { name: 'Updated Name' } }
      expect(response).to redirect_to(organization_path(organization))
    end

    it 'approve' do
      post :approve, params: { id: organization.id }
      expect(response).to redirect_to(dashboard_path)
    end

    it 'reject' do
      post :reject, params: { id: organization.id }
      expect(response).to redirect_to(dashboard_path)
    end
  end

  describe 'as admin' do
    let(:admin) { FactoryBot.create(:user, :admin) }
    let(:organization) { FactoryBot.create(:organization) }
  
    before { sign_in admin }
  
    context 'approval fails' do
      before do
        allow_any_instance_of(Organization).to receive(:save).and_return(false)
        allow(controller).to receive(:render).and_return(true)
      end
  
      it 'renders organiztion page' do
        post :approve, params: { id: organization.id }
        expect(controller).to have_received(:render).with(organization_path(id: organization.id))
      end
    end
  
    context 'rejection fails' do
      before do
        allow_any_instance_of(Organization).to receive(:save).and_return(false)
        allow(controller).to receive(:render).and_return(true)
      end
  
      it 'renders organization page' do
        post :reject, params: { id: organization.id, organization: { rejection_reason: 'Test Reason' } }
        expect(controller).to have_received(:render).with(organization_path(id: organization.id))
      end
    end

    it 'index' do
      get :index
      expect(response).to be_successful
    end

    it 'create' do
      post :create, params: { organization: FactoryBot.attributes_for(:organization) }
      expect(response).to redirect_to(dashboard_path)
    end

    it 'new ' do
      get :new
      expect(response).to redirect_to(dashboard_path)
    end

    it 'show' do
      get :show, params: { id: organization.id }
      expect(response).to be_successful
    end

    it 'edit' do
      get :edit, params: { id: organization.id }
      expect(response).to redirect_to(dashboard_path)
    end

    it 'update' do
      patch :update, params: { id: organization.id, organization: { name: 'Updated Name' } }
      expect(response).to redirect_to(dashboard_path)
    end

    it 'approve' do
      post :approve, params: { id: organization.id }
      expect(response).to redirect_to(organizations_path)
    end

    it 'reject' do
      post :reject, params: { id: organization.id, organization: { rejection_reason: 'Test Reason' } }
      expect(response).to redirect_to(organizations_path)
    end
  end
end