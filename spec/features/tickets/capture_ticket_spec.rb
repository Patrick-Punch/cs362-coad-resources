require 'rails_helper'

RSpec.describe 'Capturing a ticket', type: :feature do
  before do
    @user = create(:user, :organization_approved)
    @ticket = create(:ticket)
  end

  it "should work" do
    log_in_as(@user)

    click_on 'Tickets'
    click_on @ticket.name
    click_on 'Capture'

    expect(current_path).to eq '/dashboard'
  end

end
