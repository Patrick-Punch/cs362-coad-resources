require 'rails_helper'

RSpec.describe OrganizationsController, type: :controller do
# POST   /organizations/:id/approve(.:format)                      organizations#approve
# POST   /organizations/:id/reject(.:format)                       organizations#reject
# GET    /organizations/:id/resources(.:format)                    organizations#resources
# GET    /organizations(.:format)                                  organizations#index
# POST   /organizations(.:format)                                  organizations#create
# GET    /organizations/new(.:format)                              organizations#new
# GET    /organizations/:id/edit(.:format)                         organizations#edit
# GET    /organizations/:id(.:format)                              organizations#show
# PATCH  /organizations/:id(.:format)                              organizations#update
# PUT    /organizations/:id(.:format)                              organizations#update
# DELETE /organizations/:id(.:format)                              organizations#destroy
    let(:user) { create (:user) }
    let(:admin) { create(:user, :admin)}
    let (:organization) { create(:organization)}

describe 'as a logged out user' do
        it 'index' do
            get :index
            expect(response).to redirect_to(new_user_session_path)
        end 

        it 'create' do 
            post(:create, params: { organization: attributes_for(:organization)})
            expect(response).to redirect_to(new_user_session_path)
        end 

        it 'new' do 
            get(:new)
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
            patch(:update, params: { id: organization.id, organization: { name: 'Updated Name' } })
            expect(response).to redirect_to new_user_session_path
        end

        it 'approve' do
            post(:approve, params: { id: organization.id })
            expect(response).to redirect_to new_user_session_path
        end

        it 'reject' do
            post(:reject, params: { id: organization.id })
            expect(response).to redirect_to new_user_session_path
        end

        
    end
end 
