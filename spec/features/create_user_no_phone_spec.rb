
require 'spec_helper'

RSpec.describe 'Creating User - No Phone', type: :feature do
  scenario 'valid inputs' do
    visit new_user_registration_path
    fill_in 'Name', with: 'Bonk'
    fill_in 'Email', with: 'Bonk@glomail.com'
    fill_in 'Password', with: 'Bing111'
    fill_in 'Password confirmation', with: 'Bing111'
    click_on 'Sign up'
    visit users_path
    expect(page).to have_content('Bonk')
  end
end
