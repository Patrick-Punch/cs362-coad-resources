require 'rails_helper'

RSpec.describe 'When Deleting a Ticket', type: :feature do
  before do
    @ticket = create(:ticket)
    @admin = create(:user, :admin)
  end

  it 'should delete the ticket as admin' do
    log_in_as(@admin)

    visit root_path
    click_on 'Dashboard'
    click_on @ticket.name
    click_on 'Delete'

    expect(current_path).to eq dashboard_path
    expect(page.body).to have_no_text(@ticket.name)
  end
end
