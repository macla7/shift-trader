require 'rails_helper'

RSpec.describe 'Worker ask invite', type: :feature do
  feature 'sent to host' do
    scenario 'successful' do
      create_user!
      host = User.create!(name: 'finch', email: 'foo@bar.com2', password: 'Bing111')
      group = UserGroup.create!(host_id: host.id, name: 'Coolies0')
      login_and_logout_with_warden do
        visit user_group_path(group)
        click_on 'Request to Join'
        expect(page).to have_content("Request to join group sent!")
      end
    end

    scenario 'ask invite pending' do
      create_user!
      host = User.create!(name: 'ninch', email: 'foo@bar.com3', password: 'Bing111')
      group = UserGroup.create!(host_id: host.id, name: 'Coolies0')
      Invite.create!(user_group_id: group.id, invitee_id: @user.id, invitor_id: host.id, accepted: true, confirmed: false)
      login_and_logout_with_warden do
        visit user_group_path(group)
        expect(page).to have_button('Request sent', disabled: true)
      end
    end
  end
end