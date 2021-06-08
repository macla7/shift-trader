require 'rails_helper'

RSpec.describe 'Updating a User Group', type: :feature do
  
  feature "with Name" do
    scenario 'valid input' do
      create_user!
      UserGroup.create!(name: 'Coolies', host_id: @user.id )
      login_and_logout_with_warden do
        visit user_groups_path
        click_on 'Show'
        click_on 'Edit'
        fill_in 'Name', with: 'New Name Boi'
        click_on 'Submit'
        expect(page).to have_content('Workplace: New Name Boi')
      end
    end

    scenario 'already taken' do
      create_user!
      group = UserGroup.create!(name: 'Coolies', host_id: @user.id )
      UserGroup.create!(name: 'Taken Boi', host_id: @user.id )
      login_and_logout_with_warden do
        visit user_group_path(group)
        click_on 'Edit'
        fill_in 'Name', with: 'Taken Boi'
        click_on 'Submit'
        expect(page).to have_content('Name has already been taken')
      end
    end
  end
end