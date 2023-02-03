require 'rails_helper'

RSpec.describe "Admin::V1::Contacts", type: :request do
  let(:user) { create(:user) }

  context "GET /contacts" do
    let(:url) { "/admin/v1/contacts" }
    let!(:contacts) { create_list(:contact, 1 ) }

    it "returns all Contacts" do
      get url, headers: auth_header(user)
      expect(body_json['contacts']).to contain_exactly *contacts.as_json(only: %i(id full_name email))
    end

    it "returns success status" do
      get url, headers: auth_header(user)
      expect(response).to have_http_status(:ok)
    end
  end
end
