require 'rails_helper'

RSpec.describe 'Updating a user', type: :feature do

  feature "Update users name, email, and password" do
    scenario 'valid inputs' do
      create_user!
      login_and_logout_with_warden do
        visit users_path
        # take a screenshot?
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
end
