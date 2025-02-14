
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
      #TODO expect to not work because not signed in
      pending
      get(:show, params: { id: ticket.id })
    end

    it 'capture' do
      #TODO expect to not work because not signed in
      pending
      raise "fail"
      post(:capture, params: { id: ticket.id })
    end

    it 'release' do
      #TODO expect to not work because not signed in
      pending
      raise "fail"
      post(:release, params: { id: ticket.id })
    end

    it 'close' do
      #TODO expect to not work because not signed in
      pending
      raise "fail"
      patch(:close, params: { id: ticket.id })
    end

    it 'destroy' do
      #TODO expect to not work because not admin
      pending
      raise "fail"
      delete(:destroy, params: { id: ticket.id })
    end
  end

  describe 'as a logged in user' do
    let(:user) { create(:user) }
    let(:ticket) { create(:ticket) }

    before(:each) { sign_in user }

    it 'show' do
      get(:show, params: { id: ticket.id })
      expect(response).to redirect_to dashboard_path

      # TODO expect not to redirect if user_organization is not approved
    end

    it 'capture' do
      # TODO
      post(:capture, params: { id: ticket.id })
    end

    it 'destroy' do
      #TODO expect to not work because not admin
      pending
      raise "fail"
      delete(:destroy, params: { id: ticket.id })
    end
  end

  describe 'as an admin' do
    let(:user) { FactoryBot.create(:user, :admin) }
    before(:each) { sign_in user }

    it { expect(get(:new)).to be_successful }
  end

end
