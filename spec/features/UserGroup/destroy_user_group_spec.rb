require 'rails_helper'

RSpec.describe 'Delete group', type: :feature do
  feature 'as host' do
    scenario 'should work' do
      create_user!
      group = UserGroup.create!(name: 'Coolies', host_id: @user.id )
      login_and_logout_with_warden do
        visit user_group_path(group)
        click_on 'Delete Workplace'
        expect(page).to have_content('User group was successfully destroyed.')
      end
    end
  end

  feature 'as guest' do
    scenario 'shouldn\'t work' do
      user2 = User.create!(name: 'finch', email: 'foo@bar.com2', password: 'Bing111')
      group = UserGroup.create!(name: 'Taken Name', host_id: user2.id )
      create_user!
      login_and_logout_with_warden do
        visit user_group_path(group)
        expect(page).to_not have_content('Delete Workplace')
      end
    end
  end
end