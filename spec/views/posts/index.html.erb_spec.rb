require 'rails_helper'

RSpec.describe "posts/index", type: :view do
  before(:each) do
    assign(:posts, [
      Post.create!(
        body: "Body",
        user_group_id: 2,
        user_id: 3
      ),
      Post.create!(
        body: "Body",
        user_group_id: 2,
        user_id: 3
      )
    ])
  end

  # it "renders a list of posts" do
  #   render
  #   assert_select "tr>td", text: "Body".to_s, count: 2
  #   assert_select "tr>td", text: 2.to_s, count: 2
  #   assert_select "tr>td", text: 3.to_s, count: 2
  # end
end
