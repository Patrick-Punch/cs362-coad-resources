
require 'rails_helper'

RSpec.describe TicketsController, type: :controller do

  describe 'as a logged out user' do
    let(:user) { create(:user) }
    let(:ticket) { create(:ticket) }

    it 'create' do
      post(:create, params: { ticket: attributes_for(:ticket) })
      expect(response).to redirect_to ticket_submitted_path
    end

    it 'new' do
      expect(get(:new)).to be_successful
    end

    it 'show' do
      get(:show, params: { id: ticket.id })
      expect(response).to redirect_to dashboard_path
    end

    it 'capture' do
      post(:capture, params: { id: ticket.id })
      expect(response).to redirect_to dashboard_path
    end

    it 'release' do
      post(:release, params: { id: ticket.id })
      expect(response).to redirect_to dashboard_path
    end

    it 'close' do
      patch(:close, params: { id: ticket.id })
      expect(response).to redirect_to dashboard_path
    end

    it 'destroy' do
      #TODO test that it didn't actually destroy a ticket
      delete(:destroy, params: { id: ticket.id })
      expect(response).to redirect_to dashboard_path
    end
  end

  describe 'as a logged in user' do
    let(:user) { create(:user) }
    let(:ticket) { create(:ticket) }

    before(:each) { sign_in user }

    it 'create' do
      post(:create, params: { ticket: attributes_for(:ticket) })
      expect(response).to redirect_to ticket_submitted_path
    end

    it 'new' do
      expect(get(:new)).to be_successful
    end

    it 'show' do
      get(:show, params: { id: ticket.id })
      expect(response).to redirect_to dashboard_path
      #TODO test when organization.approved?
    end

    it 'capture' do
      post(:capture, params: { id: ticket.id })
      expect(response).to redirect_to dashboard_path
      #TODO test when organization.approved?
    end

    it 'release' do
      post(:release, params: { id: ticket.id })
      expect(response).to redirect_to dashboard_path
      #TODO test when organization.approved?
    end

    it 'close' do
      patch(:close, params: { id: ticket.id })
      expect(response).to redirect_to dashboard_path
      #TODO test when organization.approved?
    end

    it 'destroy' do
      #TODO test that it didn't actually destroy a ticket
      delete(:destroy, params: { id: ticket.id })
      expect(response).to redirect_to dashboard_path
    end
  end

  describe 'as an admin' do
    let(:user) { create(:user, :admin) }
    let(:ticket) { create(:ticket) }
    before(:each) { sign_in user }

    it 'create' do
      post(:create, params: { ticket: attributes_for(:ticket) })
      expect(response).to redirect_to ticket_submitted_path
    end

    it 'new' do
      expect(get(:new)).to be_successful
    end

    it 'show' do
      get(:show, params: { id: ticket.id })
      expect(response).to be_successful
    end

    it 'capture' do
      post(:capture, params: { id: ticket.id })
      expect(response).to redirect_to dashboard_path
      #TODO test other possibilites
    end

    it 'release' do
      post(:release, params: { id: ticket.id })
      expect(response).to redirect_to dashboard_path
    end

    it 'close' do
      patch(:close, params: { id: ticket.id })
      expect(response).to redirect_to "#{dashboard_path}#tickets:open"
      #TODO test other possibilities
    end

    it 'destroy' do
      #TODO test that it actually deleted ticket
      delete(:destroy, params: { id: ticket.id })
      expect(response).to redirect_to "#{dashboard_path}#tickets"
    end
  end
end
