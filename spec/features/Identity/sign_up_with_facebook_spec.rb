require 'rails_helper'

RSpec.describe 'Sign up with Facebook', type: :feature do

  feature 'creates profile' do
    scenario 'works' do
      visit users_path
      click_on 'Sign in with Facebook'
      expect(page).to have_content('Successfully authenticated from Facebook account.')
      expect(User.last.identities.first.uid).to eql('12345')
      expect(User.last.identities.first.provider).to eql('facebook')
    end
  end
end