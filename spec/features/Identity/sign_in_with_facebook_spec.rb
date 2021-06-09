require 'rails_helper'

RSpec.describe 'Sign in with Facebook', type: :feature do
  feature 'logs in' do
    scenario 'works' do
      visit users_path
      user2 = User.create!(name: 'finch', email: 'foo@bar.com2', password: 'Bing111')
      identity = Identity.create!(provider: 'facebook', uid: '12345', user_id: user2.id)
      click_on 'Sign in with Facebook'
      expect(page).to have_content('Successfully logged in with Facebook account.')
    end
  end
end