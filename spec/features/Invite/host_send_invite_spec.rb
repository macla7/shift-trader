require 'rails_helper'

RSpec.describe 'Host send invite', type: :feature do
  feature 'from show page' do
    scenario 'is succesful' do
      create_user!
      invitee = User.create!(name: 'finch', email: 'foo@bar.com2', password: 'Bing111')
      group = UserGroup.create!(host_id: @user.id, name: 'Coolies0')
      login_and_logout_with_warden do
        visit user_group_path(group)
        fill_in 'Email', with: 'foo@bar.com2'
        click_on 'Invite'
        expect(page).to have_content('Invite Sent!')
        expect(Invite.last.invitor_id).to eql(@user.id)
        expect(Invite.last.invitee_id).to eql(invitee.id)
        expect(Invite.last.confirmed).to eql true
        expect(Invite.last.accepted).to eql false
        expect(Invite.last.user_group_id).to eql(group.id)
      end
    end

    scenario 'already in group' do
      create_user!
      invitee = User.create!(name: 'Litch', email: 'foo@bar.com3', password: 'Bing111')
      group = UserGroup.create!(host_id: @user.id, name: 'Coolies1')
      Invite.create!(user_group_id: group.id, invitee_id: invitee.id, invitor_id: @user.id, accepted: true, confirmed: true)
      login_and_logout_with_warden do
        visit user_group_path(group)
        fill_in 'Email', with: 'foo@bar.com3'
        click_on 'Invite'
        expect(page).to have_content('Worker already in group.')
      end
    end

    scenario 'already sent invite' do
      create_user!
      invitee = User.create!(name: 'Critch', email: 'foo@bar.com4', password: 'Bing111')
      group = UserGroup.create!(host_id: @user.id, name: 'Coolies2')
      Invite.create!(user_group_id: group.id, invitee_id: invitee.id, invitor_id: @user.id, accepted: false, confirmed: true)
      login_and_logout_with_warden do
        visit user_group_path(group)
        fill_in 'Email', with: 'foo@bar.com4'
        click_on 'Invite'
        expect(page).to have_content("Already sent an invite to #{invitee.email}!")
      end
    end

    scenario 'alredy requested to join' do
      create_user!
      invitee = User.create!(name: 'Witch', email: 'foo@bar.com5', password: 'Bing111')
      group = UserGroup.create!(host_id: @user.id, name: 'Coolies3')
      Invite.create!(user_group_id: group.id, invitee_id: invitee.id, invitor_id: @user.id, accepted: true, confirmed: false)
      login_and_logout_with_warden do
        visit user_group_path(group)
        fill_in 'Email', with: 'foo@bar.com5'
        click_on 'Invite'
        expect(page).to have_content("#{invitee.email} has already requested to join!")
      end
    end
  end
end