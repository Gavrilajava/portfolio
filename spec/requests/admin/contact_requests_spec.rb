require 'rails_helper'

RSpec.describe 'Admin::ContactRequests', type: :request do
  let(:admin_user) { FactoryBot.create(:user, :admin) }
  let(:contact_request) { FactoryBot.create(:contact_request) }

  before do
    sign_in admin_user
  end

  describe 'GET /index' do
    it 'returns http success' do
      get admin_contact_requests_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /edit' do
    it 'returns http success' do
      get edit_admin_contact_request_path(contact_request)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PUT /update' do
    context 'with valid parameters' do
      it 'updates the contact request and redirects' do
        put admin_contact_request_path(contact_request), params: { contact_request: { status: 'in_progress' } }
        expect(response).to redirect_to(admin_contact_requests_path)
        expect(contact_request.reload.status).to eq('in_progress')
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the contact request and redirects' do
      delete admin_contact_request_path(contact_request)
      expect(response).to redirect_to(admin_contact_requests_path)
      expect(ContactRequest.exists?(contact_request.id)).to be_falsey
    end
  end
end
