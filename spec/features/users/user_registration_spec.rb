require 'rails_helper'

RSpec.describe 'User registration', type: :feature do

  it 'works' do
    allow_any_instance_of(Users::RegistrationsController).to receive(:verify_recaptcha).and_return(true)
    user = attributes_for(:user)
    visit root_path

    # TODO fix out-dated reCAPTCHA
    click_on 'Sign up'
    fill_in 'Email', with: user[:email]
    fill_in 'Password', with: user[:password]
    fill_in 'Password confirmation', with: user[:password]
    find('#commit').click
    expect(current_path).to eq root_path
  end

end
