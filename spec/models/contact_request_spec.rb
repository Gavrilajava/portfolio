require 'rails_helper'

RSpec.describe ContactRequest, type: :model do
  let(:contact_request) { FactoryBot.build(:contact_request) }

  describe 'Validations' do
    it 'is valid with a valid email' do
      expect(contact_request).to be_valid
    end

    it 'is not valid without an email' do
      contact_request.email = nil
      expect(contact_request).not_to be_valid
    end
  end

  describe 'Status' do
    it 'should have a default status of created' do
      new_request = FactoryBot.build(:contact_request)
      expect(new_request.status).to eq('created')
    end

    it 'can be set to in_progress' do
      contact_request.in_progress!
      expect(contact_request.status).to eq('in_progress')
    end

    it 'can be set to archived' do
      contact_request.archived!
      expect(contact_request.status).to eq('archived')
    end
  end
end
