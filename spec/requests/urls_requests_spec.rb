# spec/requests/urls_request_spec.rb
require 'rails_helper'

RSpec.describe 'Urls', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get urls_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      let(:valid_attributes) { { url: { long: 'https://www.example.com' } } }

      it 'creates a new Url and returns http success' do
        expect do
          post urls_path, params: valid_attributes
        end.to change(Url, :count).by(1)

        expect(response).to have_http_status(:success)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_attributes) { { url: { long: 'invalid-url' } } }

      it 'does not create a new Url and returns an unprocessable entity status' do
        expect do
          post urls_path, params: invalid_attributes
        end.not_to change(Url, :count)

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'GET /show' do
    let!(:url) { FactoryBot.create(:url) }

    it 'redirects to the long URL' do
      get url_redirect_path(url.short)
      expect(response).to redirect_to(url.long)
    end

    context 'with non-existing short URL' do
      it 'returns a not found error response' do
        get url_redirect_path('nonexisting')
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
