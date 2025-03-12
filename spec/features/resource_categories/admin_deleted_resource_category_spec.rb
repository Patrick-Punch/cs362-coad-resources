require 'rails_helper'

RSpec.describe 'Deleting a Resource Category', type: :feature do
  before do
    @res_cat = create(:resource_category)
    @admin = create(:user, :admin)
  end

  it 'works' do
    log_in_as(@admin)

    visit root_path
    click_on 'Categories'
    click_on @res_cat.name
    click_on 'Delete'
    expect(current_path).to eq resource_categories_path
    expect(page.body).to have_content("Category #{@res_cat.name} was deleted")
  end

end
