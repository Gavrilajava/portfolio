require 'rails_helper'

RSpec.describe Url, type: :model do
  let(:valid_url) { FactoryBot.build(:url) }
  let(:invalid_url) { FactoryBot.build(:url, long: 'invalid_url') }
  let(:unsafe_url) { FactoryBot.build(:url, long: 'http://www.google.com') }

  describe 'Callbacks' do
    it 'sets timestamps before validation' do
      url = FactoryBot.build(:url, created_at: nil, updated_at: nil)
      url.valid?
      expect(url.created_at).not_to be_nil
      expect(url.updated_at).not_to be_nil
    end
  end

  describe 'Validations' do
    context 'when URL is valid' do
      it 'is valid' do
        expect(valid_url).to be_valid
      end
    end

    context 'when URL is invalid' do
      it 'invalid_url is not valid' do
        expect(invalid_url).not_to be_valid
        expect(invalid_url.errors[:long]).to include('Should be a valid and secure URL')
      end

      it 'unsafe_url is not valid' do
        expect(unsafe_url).not_to be_valid
        expect(unsafe_url.errors[:long]).to include('Should be a valid and secure URL')
      end
    end
  end

  describe '#save' do
    context 'when URL is valid' do
      it 'saves the URL' do
        expect(valid_url.save).to be_truthy
      end
    end

    context 'when URL is invalid' do
      it 'does not save the URL' do
        expect(invalid_url.save).to be_falsey
      end
    end
  end
end
