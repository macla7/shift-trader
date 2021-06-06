require 'rails_helper'

RSpec.describe 'Updating a user', type: :feature do
  include Devise::Test::IntegrationHelpers

  feature "Update users name, email, and password" do
    scenario 'valid inputs' do
      visit new_user_registration_path
      fill_in 'Name', with: 'Bonk'
      fill_in 'Email', with: 'Bonk@glomail.com'
      fill_in 'Password', with: 'Bing111'
      fill_in 'Password confirmation', with: 'Bing111'
      click_on 'Sign up'
      visit users_path
      click_on 'Show'
      click_on 'Edit'
      fill_in 'Name', with: 'Blek'
      fill_in 'Email', with: 'blek@blek'
      fill_in 'Password', with: 'Ching123'
      fill_in 'Password confirmation', with: 'Ching123'
      fill_in 'Current password', with: 'Bing111'
      click_on 'Update'
      visit users_path
      expect(page).to have_content('Blek')
    end
  end
end
