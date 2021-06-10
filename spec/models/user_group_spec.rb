require 'rails_helper'

RSpec.describe UserGroup, type: :model do

  let(:user) { User.new(
    name: 'mitch',
    email: 'mitch@bing',
    password: 'Bing111'
  )}
  subject { described_class.new(
    name: 'Cool Group',
    host_id: user.id
  )}
  let(:invite) { Invite.new(
    invitor_id: user.id,
    invitee_id: user.id,
    user_group_id: subject.id,
    accepted: true,
    confirmed: true
  )}
  
  describe "ASSOCIATIONS" do
    it { should belong_to(:host).class_name('User') }
    it { should have_many(:invites) }
    it { should have_many(:members) }
    it { should have_many(:member_invites) }
    it { should have_many(:ask_invites) }
  end

  describe "VALIDATIONS" do
    it { should validate_presence_of(:host_id) }
    it { should validate_presence_of(:name) }
  end

  describe "#has_member?" do
    context 'group has member' do
      it 'return true' do
        user.save!
        subject.save!
        invite.save!
        expect(subject).to be_has_member(user)
      end
    end

    context "invitee hasn't accepted" do
      it 'return false' do
        user.save!
        subject.save!
        invite.accepted = false
        invite.save!
        expect(subject).to_not be_has_member(user)
      end
    end

    context "host hasn't confirmed ask_invite" do
      it 'return false' do
        user.save!
        subject.save!
        invite.confirmed = false
        invite.save!
        expect(subject).to_not be_has_member(user)
      end
    end
  end

  describe "#has_ask_invite?" do
    context 'that does exist' do
      it 'returns true' do
        user.save!
        subject.save!
        invite.confirmed = false
        invite.save!
        expect(subject).to be_has_ask_invite(user)
      end
    end

    context 'that does exist' do
      it 'returns true' do
        user.save!
        subject.save!
        invite.accepted = false
        invite.save!
        expect(subject).to_not be_has_ask_invite(user)
      end
    end
  end
end
