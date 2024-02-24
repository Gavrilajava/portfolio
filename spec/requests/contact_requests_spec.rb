require 'rails_helper'

RSpec.describe 'ContactRequests', type: :request do
  describe 'GET /new' do
    it 'renders the new template' do
      get contacts_path
      expect(response).to render_template(:new)
    end

    it 'responds with success' do
      get contacts_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      let(:valid_attributes) { { contact_request: { email: 'test@example.com', message: 'Hello!' } } }

      it 'creates a new ContactRequest' do
        expect do
          post contact_requests_path, params: valid_attributes
        end.to change(ContactRequest, :count).by(1)
      end

      it 'redirects to the root path' do
        post contact_requests_path, params: valid_attributes
        expect(response).to redirect_to(root_path)
      end

      it 'sets a flash notice' do
        post contact_requests_path, params: valid_attributes
        expect(flash[:notice]).to be_present
      end
    end

    context 'with invalid parameters' do
      let(:invalid_attributes) { { contact_request: { email: '', message: '' } } }

      it 'does not create a new ContactRequest' do
        expect do
          post contact_requests_path, params: invalid_attributes
        end.not_to change(ContactRequest, :count)
      end

      it 're-renders the new template' do
        post contact_requests_path, params: invalid_attributes
        expect(response).to render_template(:new)
      end

      it 'responds with unprocessable entity status' do
        post contact_requests_path, params: invalid_attributes
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'sets a flash error' do
        post contact_requests_path, params: invalid_attributes
        expect(flash[:error]).to be_present
      end
    end
  end
end
