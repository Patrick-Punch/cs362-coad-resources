require 'rails_helper'

RSpec.describe 'Creating a Region', type: :feature do
  
  before do
    @region = create(:region)
    @resource_category = create(:resource_category)
    @admin = create(:user, :admin)
  end

  it 'can be created from the home screen' do
    log_in_as(@admin)

    visit root_path

    click_on 'Regions'
    click_on 'Add Region'

    fill_in 'Name', with: 'Test Name'

    click_on 'Add Region'

    expect(current_path).to eq '/regions'
  end
end
