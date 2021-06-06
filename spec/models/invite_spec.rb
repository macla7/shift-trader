require 'rails_helper'

RSpec.describe Invite, type: :model do
  let(:user) { User.new(
    name: 'mitch',
    email: 'mitch@bing',
    password: 'Bing111'
  )}
  let(:group) { UserGroup.new(
    name: 'Coolies',
    host_id: user.id
  )}
  subject { described_class.new(
    invitor_id: user.id,
    invitee_id: user.id,
    user_group_id: group.id,
    accepted: true,
    confirmed: true
  )}

  describe "ASSOCIATIONS" do
    it { should belong_to(:user_group) }
    it { should belong_to(:invitor) }
    it { should belong_to(:invitee) }
  end

  describe "VALIDATIONS" do
    it { should validate_presence_of(:user_group_id) }
    it { should validate_presence_of(:invitee_id) }
    it { should validate_presence_of(:invitor_id) }
  end

  describe "#to_partial_path" do
    context 'give member partial as base default' do
      it 'return string path' do
        user.save!
        group.save!
        subject.save!
        expect(subject.to_partial_path).to eql('invite/member')
      end
    end
  end

end
