require 'rails_helper'

RSpec.describe TicketsController, type: :controller do

  describe 'as any user' do
    let(:user) { create(:user) }
    let(:ticket) { create(:ticket) }

    describe 'create' do
      it 'should create a ticket if parameters passed are valid' do
        post(:create, params: { ticket: attributes_for(:ticket) })
        expect(response).to redirect_to ticket_submitted_path
      end

      it 'should render "new" template if parameters save unsuccessfully' do
        ticket = build(:ticket)
        allow(Ticket).to receive(:new).and_return(ticket)
        allow(ticket).to receive(:save).and_return(false)
        post(:create, params: { ticket: attributes_for(:ticket) })
        expect(response).to be_successful
      end
    end

    it 'new' do
      expect(get(:new)).to be_successful
    end
  end

  describe 'as a logged out user' do
    let(:user) { create(:user) }
    let(:ticket) { create(:ticket) }

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

    it 'show' do
      get(:show, params: { id: ticket.id })
      expect(response).to redirect_to dashboard_path
      #TODO test when organization.approved?
    end

    describe 'capture' do
      it 'should redirect to dashboard if organization unapproved' do
        post(:capture, params: { id: ticket.id })
        expect(response).to redirect_to dashboard_path
      end

      it 'should be redirect to dashboard with an open ticket if organization approved' do
        user = create(:user, :organization_approved)
        sign_in user

        post(:capture, params: { id: ticket.id })
        expect(response).to redirect_to "#{dashboard_path}#tickets:open"
      end

      it 'should render :show if capture unsuccessful' do
        user = create(:user, :organization_approved)
        sign_in user

        allow(TicketService).to receive(:capture_ticket).and_return :not_ok

        post(:capture, params: { id: ticket.id })
        expect(response).to be_successful
      end
    end

    describe 'release' do
      it 'should redirect to dashboard if organization unapproved' do
        post(:release, params: { id: ticket.id })
        expect(response).to redirect_to dashboard_path
      end

      it 'should redirect to #tickets:organization if release successful' do
        user = create(:user, :organization_approved)
        sign_in user

        allow(TicketService).to receive(:release_ticket).and_return :ok

        post(:release, params: { id: ticket.id })
        expect(response).to redirect_to "#{dashboard_path}#tickets:organization"
      end

      it 'should render :show if release unsuccessful' do
        # sign_out user
        user = create(:user, :organization_approved)
        sign_in user

        post(:release, params: { id: ticket.id })
        expect(response).to be_successful
      end

    end

    describe 'close' do
      it 'should redirct to dashboard_path if organization is unapproved' do
        user = create(:user, :organization_unapproved)
        sign_in user

        patch(:close, params: { id: ticket.id })
        expect(response).to redirect_to dashboard_path
      end

      it 'should render :show if closing ticket is unsuccessful' do
        user = create(:user, :organization_approved)
        sign_in user

        allow(TicketService).to receive(:close_ticket).and_return :not_ok

        post(:close, params: { id: ticket.id })
        expect(response).to be_successful
      end

      it 'should redirect to #tickets:organization if close successful' do
        user = create(:user, :organization_approved)
        sign_in user

        allow(TicketService).to receive(:close_ticket).and_return :ok

        post(:close, params: { id: ticket.id })
        expect(response).to redirect_to "#{dashboard_path}#tickets:organization"
      end
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

    it 'show' do
      get(:show, params: { id: ticket.id })
      expect(response).to be_successful
    end

    it 'capture' do
      post(:capture, params: { id: ticket.id })
      expect(response).to redirect_to dashboard_path
    end

    describe 'release' do
      it 'should redirect to #tickets:captured if organization approved' do
        sign_out user
        user = create(:user, :organization_approved, :admin)
        sign_in user

        allow(TicketService).to receive(:release_ticket).and_return :ok

        post(:release, params: { id: ticket.id })
        expect(response).to redirect_to "#{dashboard_path}#tickets:captured"
      end
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
