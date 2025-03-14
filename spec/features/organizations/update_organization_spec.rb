require 'rails_helper'

RSpec.describe 'Updating an Organization', type: :feature do
    before do 
        @user = create(:user, :organization_approved)
        @fake_name = 'FAKE'
    end 

    it "can update an organization" do
        
        log_in_as(@user)

        visit root_path

        click_on 'Dashboard'

        click_on 'Edit Organization'

        fill_in 'Name', with: @fake_name
        fill_in 'Phone Number', with: '555-555-5555'
        fill_in 'Email', with: 'fake@gmail.com'
        fill_in 'Description', with: 'Boring stuff'

        expect(current_path).to be organizations.id
end

