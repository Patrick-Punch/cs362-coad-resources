require 'rails_helper'

# GET    /regions(.:format)           regions#index
# POST   /regions(.:format)           regions#create
# GET    /regions/new(.:format)       regions#new
# GET    /regions/:id/edit(.:format)  regions#edit
# GET    /regions/:id(.:format)       regions#show
# PATCH  /regions/:id(.:format)       regions#update
# PUT    /regions/:id(.:format)       regions#update
# DELETE /regions/:id(.:format)       regions#destroy

RSpec.describe RegionsController, type: :controller do

  describe 'as a logged out user' do
    let(:user) { FactoryBot.create(:user) } 
    let(:region) { FactoryBot.create(:region) }

    it { expect(get(:index)).to redirect_to new_user_session_path }
    it {
      post(:create, params: { region: FactoryBot.attributes_for(:region) })
      expect(response).to redirect_to new_user_session_path
    }
    it { expect(get(:new)).to redirect_to new_user_session_path }
    it { expect(get(:edit, params: { id: region.id })).to redirect_to new_user_session_path }
    it { expect(get(:show, params: { id: region.id })).to redirect_to new_user_session_path }

    it { expect(patch(:update, params: { id: region.id, region: { name: 'Updated Name' } })).to redirect_to new_user_session_path }
    it { expect(delete(:destroy, params: { id: region.id })).to redirect_to new_user_session_path }
  end

  describe 'as a logged in user' do
    let(:user) { FactoryBot.create(:user) }
    let(:region) { FactoryBot.create(:region) }
    before(:each) { sign_in user }

    it { expect(get(:index)).to redirect_to dashboard_path }
    it {
      post(:create, params: { region: FactoryBot.attributes_for(:region) })
      expect(response).to redirect_to dashboard_path
    }
    it { expect(get(:new)).to redirect_to dashboard_path }
    it { expect(get(:edit, params: { id: region.id })).to redirect_to dashboard_path }
    it { expect(patch(:update, params: { id: region.id, region: { name: 'Updated Name' } })).to redirect_to dashboard_path }
    it { expect(delete(:destroy, params: { id: region.id })).to redirect_to dashboard_path }
  end

  describe 'as an admin' do
    let(:user) { FactoryBot.create(:user, :admin) }
    let(:region) { FactoryBot.create(:region) }
    before(:each) { sign_in user }

    it { expect(get(:index)).to be_successful }
    it {
      post(:create, params: { region: FactoryBot.attributes_for(:region) })
      expect(response).to redirect_to regions_path
    }
    it { expect(get(:new)).to be_successful }
    it { expect(get(:edit, params: { id: region.id })).to be_successful } 
    it { expect(get(:show, params: { id: region.id })).to be_successful } 

    it 'does not create a region with invalid parameters' do
      post(:create, params: { region: { name: '' } })
      expect(response).to render_template('new')
    end

    it 'updates the region' do
      patch(:update, params: { id: region.id, region: { name: 'Updated Name' } })
      region.reload
      expect(region.name).to eq('Updated Name')
      expect(response).to redirect_to region_path(region)
    end

    it 'renders the edit page if the update fails' do
      patch(:update, params: { id: region.id, region: { name: '' } })
      expect(response).to render_template('edit')
    end

    it 'deletes the region and reassigns associated tickets to Unspecified' do
      unspecified_region = Region.find_by(name: 'Unspecified')
      delete(:destroy, params: { id: region.id })

      expect(flash[:notice]).to eq("Region #{region.name} was deleted. Associated tickets now belong to the 'Unspecified' region.")
      expect(response).to redirect_to(regions_path)
    end
  end
end