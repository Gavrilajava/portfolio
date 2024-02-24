require 'rails_helper'

RSpec.describe 'Admin::Users', type: :request do
  let(:admin_user) { FactoryBot.create(:user, :admin) }
  let(:user) { FactoryBot.create(:user) }

  before do
    sign_in admin_user
  end

  describe 'GET /index' do
    it 'returns a success response' do
      get admin_users_path
      expect(response).to be_successful
    end

    it 'assigns all users as @objects' do
      get admin_users_path
      expect(assigns(:objects)).to contain_exactly(*User.order(role: :desc, created_at: :desc).limit(20).to_a)
    end
  end

  describe 'GET /edit' do
    it 'returns a success response' do
      get edit_admin_user_path(user)
      expect(response).to be_successful
    end
  end

  describe 'PUT /update' do
    context 'with valid params' do
      let(:new_attributes) { { name: 'New Name', email: 'newemail@example.com' } }

      it 'updates the requested user' do
        put admin_user_path(user), params: { user: new_attributes }
        user.reload
        expect(user.name).to eq('New Name')
        expect(user.email).to eq('newemail@example.com')
      end

      it 'redirects to the user list' do
        put admin_user_path(user), params: { user: new_attributes }
        expect(response).to redirect_to(admin_users_path)
      end
    end

    context 'with invalid params' do
      let(:invalid_attributes) { { name: '' } }

      it 'returns a unprocessable entity response' do
        put admin_user_path(user), params: { user: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested user' do
      delete admin_user_path(user)
      expect(User.exists?(user.id)).to be_falsey
    end

    it 'redirects to the users list' do
      delete admin_user_path(user)
      expect(response).to redirect_to(admin_users_path)
    end
  end
end
