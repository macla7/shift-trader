require 'rails_helper'

RSpec.describe 'Creating a User Group', type: :feature do

  feature "Creating a User Group" do
    scenario 'valid name' do
      create_user!
      login_and_logout_with_warden do
        visit user_groups_path
        click_on 'New Workplace'
        fill_in 'Name', with: 'Cool Group'
        click_on 'Submit'
        expect(page).to have_content('Workplace: Cool Group')
      end
    end

    scenario 'Taken name' do
      create_user!
      user2 = User.create!(name: 'finch', email: 'foo@bar.com2', password: 'Bing111')
      UserGroup.create!(name: 'Taken Name', host_id: user2.id )
      login_and_logout_with_warden do
        visit user_groups_path
        click_on 'New Workplace'
        fill_in 'Name', with: 'Taken Name'
        click_on 'Submit'
        expect(page).to have_content('Name has already been taken')
      end
    end

    scenario 'Name can\'t be blank' do
      create_user!
      login_and_logout_with_warden do
        visit user_groups_path
        click_on 'New Workplace'
        click_on 'Submit'
        expect(page).to have_content('Name can\'t be blank')
      end
    end
  end
end