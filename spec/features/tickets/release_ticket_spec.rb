require 'rails_helper'

RSpec.describe 'Releasing a ticket by an', type: :feature do
  before do
    @user = create(:user, :organization_approved)
    @ticket = create(:ticket, :captured, org_id: @user.organization.id)
  end

  it 'organization should work' do
    log_in_as(@user)

    visit root_path
    click_on 'Dashboard'
    click_on 'Tickets'
    click_on @ticket.name
    click_on 'Release'

    expect(current_path).to eq '/dashboard'
  end

end
