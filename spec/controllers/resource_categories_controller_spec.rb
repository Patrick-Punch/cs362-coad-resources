require 'rails_helper'

# PATCH  /resource_categories/:id/activate(.:format)     resource_categories#activate
# PATCH  /resource_categories/:id/deactivate(.:format)   resource_categories#deactivate
# GET    /resource_categories(.:format)                  resource_categories#index
# POST   /resource_categories(.:format)                  resource_categories#create
# GET    /resource_categories/new(.:format)              resource_categories#new
# GET    /resource_categories/:id/edit(.:format)         resource_categories#edit
# GET    /resource_categories/:id(.:format)              resource_categories#show
# PATCH  /resource_categories/:id(.:format)              resource_categories#update
# PUT    /resource_categories/:id(.:format)              resource_categories#update
# DELETE /resource_categories/:id(.:format)              resource_categories#destroy

RSpec.describe ResourceCategoriesController, type: :controller do
  let(:admin) { FactoryBot.create(:user, :admin) }
  let(:user) { FactoryBot.create(:user) }
  let(:resource_category) { FactoryBot.create(:resource_category) }

  shared_examples 'redirects to dashboard' do
    it 'redirects to dashboard' do
      expect(response).to redirect_to(dashboard_path)
    end
  end

  describe 'as an authenticated admin' do
    before { sign_in admin }

    describe 'GET #index' do
      it 'assigns all resource categories to @resource_categories' do
        get :index
        expect(assigns(:resource_categories)).to eq([resource_category])
      end
    end

    describe 'GET #show' do
      it 'assigns the requested resource category to @resource_category' do
        get :show, params: { id: resource_category.id }
        expect(assigns(:resource_category)).to eq(resource_category)
      end
    end

    describe 'GET #new' do
      it 'assigns a new resource category to @resource_category' do
        get :new
        expect(assigns(:resource_category)).to be_a_new(ResourceCategory)
      end
    end

    describe 'POST #create' do
      context 'with valid parameters' do
        it 'creates a new resource category and redirects to index' do
          expect {
            post :create, params: { resource_category: { name: 'New Category' } }
          }.to change(ResourceCategory, :count).by(1)
          expect(response).to redirect_to(resource_categories_path)
        end
      end

      context 'with invalid parameters' do
        it 'does not create a new resource category and re-renders the new template' do
          expect {
            post :create, params: { resource_category: { name: '' } }
          }.not_to change(ResourceCategory, :count)
          expect(response).to render_template(:new)
        end
      end
    end

    describe 'GET #edit' do
      it 'assigns the requested resource category to @resource_category' do
        get :edit, params: { id: resource_category.id }
        expect(assigns(:resource_category)).to eq(resource_category)
      end
    end

    describe 'PATCH #update' do
      context 'with valid parameters' do
        it 'updates the resource category and redirects to show' do
          patch :update, params: { id: resource_category.id, resource_category: { name: 'Updated Name' } }
          expect(resource_category.reload.name).to eq('Updated Name')
          expect(response).to redirect_to(resource_category)
        end
      end

      context 'with invalid parameters' do
        it 'does not update the resource category and re-renders the edit template' do
          patch :update, params: { id: resource_category.id, resource_category: { name: '' } }
          expect(resource_category.reload.name).not_to eq('')
          expect(response).to render_template(:edit)
        end
      end
    end
    describe 'PATCH #activate' do
      it 'activates the resource category and redirects to show' do
        patch :activate, params: { id: resource_category.id }
        expect(response).to redirect_to(resource_category)
      end

      it 'fails to activate' do
        allow_any_instance_of(ResourceCategory).to receive(:activate).and_return(false)
        patch :activate, params: { id: resource_category.id }
        expect(flash[:alert]).to eq('There was a problem activating the category.')
      end
    end

    describe 'PATCH #deactivate' do
      it 'deactivates the resource category and redirects to show' do
        patch :deactivate, params: { id: resource_category.id }
        expect(resource_category.reload.active?).to be_falsey
        expect(response).to redirect_to(resource_category)
      end

      it 'fails to deactivate' do
        allow_any_instance_of(ResourceCategory).to receive(:deactivate).and_return(false)
        patch :deactivate, params: { id: resource_category.id }
        expect(flash[:alert]).to eq('There was a problem deactivating the category.') # returns nil?
      end
    end

    describe 'DELETE #destroy' do
      it 'destroys the resource category and redirects to index' do
        delete :destroy, params: { id: resource_category.id }
        expect(response).to redirect_to resource_categories_path
      end
    end
  end
end
