require 'rails_helper'

RSpec.describe 'Host kicking worker', type: :feature do
  feature 'deleting invite' do
    scenario 'successful' do
      create_user!
      invitee = User.create!(name: 'finch', email: 'foo@bar.com2', password: 'Bing111')
      group = UserGroup.create!(host_id: @user.id, name: 'Coolies0')
      Invite.create!(user_group_id: group.id, invitee_id: invitee.id, invitor_id: @user.id, accepted: true, confirmed: true)
      login_and_logout_with_warden do
        visit user_group_path(group)
        expect(page).to have_content('finch')
        click_on 'kick'
        expect(page).to have_content('finch was kicked.')
      end
    end
  end
end