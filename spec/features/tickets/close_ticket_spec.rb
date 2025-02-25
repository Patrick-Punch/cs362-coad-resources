require 'rails_helper'

RSpec.describe 'Closing a ticket', type: :feature do
  before do
    @user = create(:user, :admin)
    @ticket = create(:ticket, :open)
  end

  it 'should work' do
    log_in_as(@user)

    visit root_path
    click_on 'Dashboard'
    click_on @ticket.name
    click_on 'Close'

    expect(current_path).to eq '/dashboard'
  end

end
