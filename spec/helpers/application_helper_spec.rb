require 'rails_helper'
RSpec.describe ApplicationHelper, type: :helper do
  describe '#navbar_links' do
    let(:user) { instance_double('User', admin?: false) }
    let(:admin) { instance_double('User', admin?: true) }

    context 'when the current user is not an admin' do
      before do
        allow(helper).to receive(:current_user).and_return(user)
      end

      it 'returns the correct links for a regular user' do
        expect(helper.navbar_links).to eq({
                                            home: root_path,
                                            urls: urls_path,
                                            contacts: contacts_path
                                          })
      end
    end

    context 'when the current user is an admin' do
      before do
        allow(helper).to receive(:current_user).and_return(admin)
      end

      it 'returns the correct links for an admin user' do
        expect(helper.navbar_links).to eq({
                                            home: root_path,
                                            urls: urls_path,
                                            contacts: admin_contact_requests_path,
                                            users: admin_users_path
                                          })
      end
    end
  end
end
