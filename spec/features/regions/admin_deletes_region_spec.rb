require 'rails_helper'

RSpec.describe 'Deleting a Region', type: :feature do
  before do
    @admin = create(:user, :admin)
    @region = create(:region)
  end

  it 'works' do
    log_in_as(@admin)
    visit root_path
    click_on 'Regions'
    click_on @region.name
    click_on 'Delete'
    expect(current_path).to eq regions_path
  end
end
