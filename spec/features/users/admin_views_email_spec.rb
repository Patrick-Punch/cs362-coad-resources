require 'rails_helper'

RSpec.describe 'Admin views an email address', type: :feature do
  before do
    @admin = create(:user, :admin)
    @user = create(:user)
  end

  it "should work" do
    log_in_as(@admin)

    visit root_path
    click_on 'Users'
    expect(page).to have_content(@user.email)
  end
end
