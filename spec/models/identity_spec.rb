require 'rails_helper'

RSpec.describe Identity, type: :model do
  let(:user) { User.new(
    name: 'Mitch',
    email: 'mitch@bing',
    password: 'Bing111'
  )}
  subject { described_class.new(
    uid: 1,
    provider: 2,
    user_id: user.id
  )}

  describe "ASSOCIATIONS" do
    it { should belong_to(:user) }
  end

  describe "VALIDATIONS" do
    it { should validate_presence_of(:uid) }
    it { should validate_presence_of(:provider) }
  end

  describe ".find_with_omniauth" do
    context 'if identity exists' do
      it 'return identity class' do
        user.save!
        subject.save!
        auth = { 'uid' => 1, 'provider' => 2 }
        expect(described_class.find_with_omniauth(auth)).to be_a Identity
      end
    end

    context 'if identity doesnt exist' do
      it 'return identity class' do
        user.save!
        auth = { 'uid' => 1, 'provider' => 2 }
        expect(described_class.find_with_omniauth(auth)).to be nil
      end
    end
  end

  describe ".create_with_omniauth" do
    context 'creates an identity with valid attributes' do
      it 'valid with all three attributes' do
        user.save!
        auth = { 'uid' => 1, 'provider' => 2 }
        identity = described_class.create_with_omniauth(auth)
        identity.user = user
        expect(identity.valid?).to be true
      end
    end

    context "shouldn't create Identity with invalid attributes" do
      it 'is not valid with no uid' do
        user.save!
        auth = { 'uid' => nil, 'provider' => 2 }
        identity = described_class.create_with_omniauth(auth)
        identity.user = user
        expect(identity.uid).to be nil
        expect(identity.valid?).to be false
      end

      it 'is not valid with no provider' do
        user.save!
        auth = { 'uid' => 1, 'provider' => nil }
        identity = described_class.create_with_omniauth(auth)
        identity.user = user
        expect(identity.provider).to be nil
        expect(identity.valid?).to be false
      end
    end
  end
end
