require 'rails_helper'

# Using the FakeSMS class in spec/support. This is hijacking the twilio APIR in the config/initializers folder.
RSpec.describe 'twilio verification', type: :feature do
  feature "upon sign up, with phone number" do
    scenario "with right code" do
      visit new_user_registration_path
      fill_in 'Name', with: 'Bonk'
      fill_in 'Email', with: 'Bonk@glomail.com'
      fill_in 'Phone number', with: '54321'
      fill_in 'Password', with: 'Bing111'
      fill_in 'Password confirmation', with: 'Bing111'
      click_on 'Sign up'

      expect(page).to have_content('Verify')
      last_message = FakeSMS.messages.last
      fill_in 'Verification code', with: last_message.code
      click_on "Verify"
  
      expect(page).to have_content("User is being verified")
      expect(User.last.verified).to eql true
    end
  end
end