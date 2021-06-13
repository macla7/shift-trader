require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { User.new(
    name: 'mitch',
    email: 'mitch@bing',
    password: 'Bing111'
  )}
  let(:group) { UserGroup.new(
    name: 'Cool Group',
    host_id: user.id
  )}
  let(:inv) { Invite.new(
    invitor_id: user.id,
    invitee_id: user.id,
    user_group_id: group.id,
    accepted: true,
    confirmed: true
  )}
  subject { described_class.new(
    body: 'Hi, buy me!',
    user_id: user.id,
    user_group_id: group.id,
    time_end: DateTime.now + (5/24.0)
  )}

  
  describe "ASSOCIATIONS" do
    it { should belong_to(:user).class_name('User') }
    it { should belong_to(:user_group) }
    # it { should have_many(:views) }
    # it { should have_many(:likes) }
    # it { should have_many(:comments) }
    # it { should have_one(:shift) }
    # it { should have_one(:auction) }
  end

  describe "VALIDATIONS" do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:user_group_id) }
  end
end
