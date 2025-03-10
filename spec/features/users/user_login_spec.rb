require 'rails_helper'

RSpec.describe 'Logging in', type: :feature do

  it 'works' do
    user = create(:user)
    visit root_path

    click_on 'Log in'
    fill_in 'Email address', with: user.email
    fill_in 'Password', with: user.password
    find('#commit').click
    expect(current_path).to eq dashboard_path

  end

end
