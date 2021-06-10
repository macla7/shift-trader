require 'rails_helper'

RSpec.describe User, type: :model do
  subject { described_class.new(
    name: "Mitch",
    email: 'mitch@bing',
    password: 'Bing111'
  ) }
  let(:group) { UserGroup.new(
    name: "Cool Group",
    host_id: subject.id
    ) }
  let(:invite) { Invite.new(
    invitor_id: subject.id,
    invitee_id: subject.id,
    user_group_id: group.id,
    accepted: true,
    confirmed: true
  )}

  describe 'Associations' do
    it { should have_many(:identities) }
    it { should have_many(:invites)}
    it { should have_many(:my_sent_invites) }
    it { should have_many(:my_sent_invites) }
    it { should have_many(:my_rec_invites) }
    it { should have_many(:hosts_groups) }
    it { should have_many(:in_groups) }
  end

  describe 'Validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end
  
    it 'is not valid without a name' do
      subject.email = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without an email' do
      subject.email = nil
      expect(subject).to_not be_valid
    end
  end

  # Not testing these quite yet..
  describe '.create_with_omniauth' do
  end

  describe '.from_omniatuh' do
  end

  describe '#friends' do
  end

  describe '#friends_with?' do
  end

  describe '#send_request' do
  end

  describe "INVITE METHODS" do
    let(:user2) { described_class.new(
      name: "Katho",
      email: 'katho@bing',
      password: 'Bing111'
    ) }

    describe '#invite_for_group' do
      context 'Called with user' do
        it 'return invite, with acceped: false' do
          subject.save!
          puts subject.id
          user2.save!
          group.save!
          invite = subject.invite_for_group(group, user2)
          expect(invite.accepted).to be false
          expect(invite.confirmed).to be true
        end
      end

      context 'Called with no user' do
        it 'return invite, with confirmed: false' do
          subject.save!
          user2.save!
          group.save!
          invite = user2.invite_for_group(group)
          expect(invite.accepted).to be true
          expect(invite.confirmed).to be false
        end
      end
    end

    describe '#send_invite' do
      context "no invite already existing" do
        it 'make new invite w. confirmed: true' do
          subject.save!
          user2.save!
          group.save!
          expect(subject.send_invite(group, user2)).to be_a Invite
        end
      end
    end

    describe '#ask_invite' do
      context "my ask invite pending" do
        it 'return ask invite' do
          subject.save!
          user2.save!
          group.save!
          expect(user2.ask_invite(group)).to be_a Invite
        end
      end
    end 
  end

  describe "INVITE SUPPORT METHODS" do
    describe '#recieved_invite_from_group' do
      context "recieved invite from group" do
        it 'return true' do
          subject.save!
          group.save!
          invite.accepted = false
          invite.save!
          expect(subject.recieved_invite_from_group(group).first).to be_a Invite
        end
      end

      context "hasn't invite from group" do
        it 'return false' do
          subject.save!
          group.save!
          expect(subject.recieved_invite_from_group(group).first).to_not be_a Invite
        end
      end
    end

    describe '#already_invited?' do
      context "already requested to be in group" do
        it 'return true' do
          subject.save!
          group.save!
          invite.accepted = false
          invite.save!
          expect(subject).to be_already_invited(group, subject)
        end
      end

      context "hasn't already requested to be in group" do
        it 'return false' do
          subject.save!
          group.save!
          expect(subject).to_not be_already_invited(group, subject)
        end
      end
      
    end

    describe '#already_requested?' do
      context "already requested to be in group" do
        it 'return true' do
          subject.save!
          group.save!
          invite.confirmed = false
          invite.save!
          expect(subject).to be_already_requested(group, subject)
        end
      end

      context "hasn't already requested to be in group" do
        it 'return false' do
          subject.save!
          group.save!
          expect(subject).to_not be_already_requested(group, subject)
        end
      end 
    end

    describe '#already_in_group?' do
      context "in group" do
        it 'return true' do
          subject.save!
          group.save!
          invite.save!
          expect(subject).to be_already_in_group(group, subject)
        end
      end

      context "not in group" do
        it 'return false' do
          subject.save!
          group.save!
          expect(subject).to_not be_already_in_group(group, subject)
        end
      end
    end
  end

  describe "MEMBER METHODS" do

    describe '#find_membership' do
      context 'with member' do
        it 'return invite' do
          subject.save!
          group.save!
          invite.save!
          expect(subject.find_membership(group, subject)).to be_a Invite
        end
      end

      context 'no member' do
        it 'return invite, with confirmed: false' do
          subject.save!
          group.save!
          invite.confirmed = false
          invite.save!
          expect(subject.find_membership(group, subject)).to be nil
        end
      end
    end

    describe '#find_membership_with_group' do
      context "with member existing" do
        it 'return invite' do
          subject.save!
          group.save!
          invite.save!
          expect(subject.find_membership_with_group(group)).to be_a Invite
        end
      end

      context "not in group" do
        it 'return nil' do
          subject.save!
          group.save!
          invite.confirmed = false
          invite.save!
          expect(subject.find_membership_with_group(group)).to be nil
        end
      end
    end 
  end

end
