
require 'rails_helper'

RSpec.describe 'Creating User - No Phone', type: :feature do
  feature "Signup through Devise" do
    scenario 'valid inputs' do
      visit new_user_registration_path
      fill_in 'Name', with: 'Bonk'
      fill_in 'Email', with: 'Bonk@glomail.com'
      fill_in 'Password', with: 'Bing111'
      fill_in 'Password confirmation', with: 'Bing111'
      click_on 'Sign up'
      visit users_path
      expect(page).to have_content('bonk@glomail.com')
    end

    scenario 'invalid inputs' do
      visit new_user_registration_path
      click_on 'Sign up'
      expect(page).to have_content("Email can't be blank")
      expect(page).to have_content("Name can't be blank")
      expect(page).to have_content("Password can't be blank")
    end
  end

end
