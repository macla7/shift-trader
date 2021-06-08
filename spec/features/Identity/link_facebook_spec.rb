require 'rails_helper'

RSpec.describe 'Link User to Identity', type: :feature do

  # My first mock (kinda done for me but still!)
  feature 'with facebook' do
    scenario 'works' do
      create_user!
      login_and_logout_with_warden do
        visit users_path
        click_on 'Link Facebook account'
        expect(page).to have_content('Successfully linked that account!')
        expect(@user.identities.first.uid).to eql('12345')
      end
    end

    scenario 'already linked' do
      create_user!
      login_and_logout_with_warden do
        visit users_path
        click_on 'Link Facebook account'
        click_on 'Link Facebook account'
        expect(page).to have_content('Already linked that account!')
        expect(@user.identities.first.uid).to eql('12345')
      end
    end
  end


end