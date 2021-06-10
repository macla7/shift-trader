require 'rails_helper'

RSpec.describe 'Accept ask invite', type: :feature do
  feature 'from worker' do
    scenario 'successful' do
      create_user!
      invitee = User.create!(name: 'Litch', email: 'foo@bar.com1', password: 'Bing111')
      group = UserGroup.create!(host_id: @user.id, name: 'Coolies')
      Invite.create!(user_group_id: group.id, invitee_id: invitee.id, invitor_id: @user.id, accepted: true, confirmed: false)
      login_and_logout_with_warden do
        visit user_group_path(group)
        click_on 'Accept Request'
        expect(page).to have_content('Request accepted!')
        expect(page).to_not have_button('Accept Request')
      end
    end
  end
end