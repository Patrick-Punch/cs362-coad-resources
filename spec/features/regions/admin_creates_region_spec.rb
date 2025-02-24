require 'rails_helper'

RSpec.describe 'Creating a Region', type: :feature do

  before do
    @admin = create(:user, :admin)
    @fake_name = 'FAKE'
  end

  it 'can be created from the home screen' do
    log_in_as(@admin)

    visit root_path

    click_on 'Regions'
    click_on 'Add Region'

    fill_in 'Name', with: @fake_name

    click_on 'Add Region'

    expect(current_path).to eq '/regions'
    expect(page.body).to have_text(@fake_name)
  end
end
