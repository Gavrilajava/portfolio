require 'rails_helper'

RSpec.describe 'HealthCheck', type: :request do
  describe 'GET #show' do
    it 'returns http success' do
      get health_check_path
      expect(response).to have_http_status(:ok)
    end

    it "returns JSON body containing 'ok'" do
      get health_check_path
      expect(response.content_type).to eq('application/json; charset=utf-8')
      expect(response.body).to eq('ok'.to_json)
    end
  end
end
