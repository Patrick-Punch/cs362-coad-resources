require 'rails_helper'

RSpec.describe 'Rejecting an organization', type: :feature do
    before do
        @organization = create(:organization)
        @admin = create(:user, :admin)
    end

    it 'organization can be rejected' do
        log_in_as(@admin)

        visit root_path

        click_on "Organizations"
        click_on "All"
        click_on @organization.name
        click_on "Reject"

        expect(current_path).to eq '/organizations'
    end 

end



