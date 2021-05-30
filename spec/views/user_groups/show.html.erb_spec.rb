require 'rails_helper'

RSpec.describe "user_groups/show", type: :view do
  before(:each) do
    @user_group = assign(:user_group, UserGroup.create!(
      name: "Name",
      host: 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/2/)
  end
end
