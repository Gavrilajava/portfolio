require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.build(:user) }

  describe 'Devise functionalities' do
    it 'should be database authenticatable' do
      expect(user).to respond_to(:encrypted_password)
    end

    it 'should be registerable' do
      expect(FactoryBot.create(:user)).to be_persisted
    end

    it 'should be recoverable' do
      expect(user).to respond_to(:reset_password_token)
    end

    it 'should be rememberable' do
      expect(user).to respond_to(:remember_created_at)
    end

    it 'should be validatable' do
      user = FactoryBot.build(:user, email: 'invalid', password: nil)
      expect(user).not_to be_valid
    end
  end

  describe 'Validations' do
    it 'is valid with valid attributes' do
      expect(user).to be_valid
    end

    it 'is not valid without a name' do
      user.name = nil
      expect(user).not_to be_valid
    end

    it 'is valid only if acknowledgement is accepted on create' do
      new_user = FactoryBot.build(:user, acknowledgement: false)
      expect(new_user).not_to be_valid if new_user.new_record?
    end
  end

  describe 'Roles' do
    it 'should have a default role of user' do
      expect(user.role).to eq('user')
    end

    it 'should be able to be assigned as admin' do
      user.admin!
      expect(user.role).to eq('admin')
    end
  end
end
