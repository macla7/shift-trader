require 'rails_helper'

RSpec.describe "posts/new", type: :view do
  before(:each) do
    assign(:post, Post.new(
      body: "MyString",
      user_group_id: 1,
      user_id: 1
    ))
  end

  # it "renders new post form" do
  #   render
# 
  #   assert_select "form[action=?][method=?]", posts_path, "post" do
# 
  #     assert_select "input[name=?]", "post[body]"
# 
  #     assert_select "input[name=?]", "post[user_group_id]"
# 
  #     assert_select "input[name=?]", "post[user_id]"
  #   end
  # end
end
