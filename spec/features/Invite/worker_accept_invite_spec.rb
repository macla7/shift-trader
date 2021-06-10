require 'rails_helper'

RSpec.describe 'Accept invite', type: :feature do
  feature 'from host' do
    scenario 'successful' do
      create_user!
      host = User.create!(name: 'Litch', email: 'foo@bar.com1', password: 'Bing111')
      group = UserGroup.create!(host_id: host.id, name: 'Coolies')
      Invite.create!(user_group_id: group.id, invitee_id: @user.id, invitor_id: host.id, accepted: false, confirmed: true)
      login_and_logout_with_warden do
        visit user_group_path(group)
        click_on 'Accept Invite'
        expect(page).to have_content('Invite accepted!')
        expect(page).to_not have_button('Accept Request')
      end
    end
  end
end