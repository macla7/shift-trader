require 'rails_helper'

RSpec.describe 'Worker leaving group', type: :feature do
  feature 'deleting invite' do
    scenario 'successful' do
      create_user!
      host = User.create!(name: 'finch', email: 'foo@bar.com2', password: 'Bing111')
      group = UserGroup.create!(host_id: host.id, name: 'Coolies0')
      inv = Invite.create!(user_group_id: group.id, invitee_id: @user.id, invitor_id: host.id, accepted: true, confirmed: true)
      login_and_logout_with_warden do
        visit user_group_path(group)
        expect(page).to have_content('mitch')
        click_on 'Leave Group'
        expect(page).to have_content('You left Coolies0')
      end
    end
  end
end