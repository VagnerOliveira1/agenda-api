require 'rails_helper'

RSpec.describe "Admin::V1::Contacts", type: :request do
  let(:user) { create(:user) }

  context "GET /contacts" do
    let(:url) { "/admin/v1/contacts" }
    let!(:contacts) { create_list(:contact, 5 ) }

    it "returns all Contacts" do
      get url, headers: auth_header(user)
      expect(body_json['contacts']).to contain_exactly *contacts.as_json(only: %i(id full_name email))
    end

    it "returns success status" do
      get url, headers: auth_header(user)
      expect(response).to have_http_status(:ok)
    end
  end

  context "POST /contacts" do
    let(:url) { "/admin/v1/contacts" }
  
    context "with valid params" do
      let(:contact_params) { { contact: attributes_for(:contact) }.to_json }
      it 'adds a new Contact' do
        expect do
          post url, headers: auth_header(user), params: contact_params
        end.to change(Contact, :count).by(1)
      end

      it 'returns last added Contact' do
        post url, headers: auth_header(user), params: contact_params
        expected_contact = Contact.last.as_json(only: %i(id full_name))
        expect(body_json['contact']).to eq expected_contact
      end

      it 'returns success status' do
        post url, headers: auth_header(user), params: contact_params
        expect(response).to have_http_status(:ok)
      end
    end
  
    context "with invalid params" do
      let(:contact_invalid_params) do 
        { contact: attributes_for(:contact, full_name: nil) }.to_json
      end

      it 'does not add a new Contact' do
        expect do
          post url, headers: auth_header(user), params: contact_invalid_params
        end.to_not change(Contact, :count)
      end

      it 'returns error message' do
        post url, headers: auth_header(user), params: contact_invalid_params
        expect(body_json['errors']['fields']).to have_key('full_name')
      end

      it 'returns unprocessable_entity status' do
        post url, headers: auth_header(user), params: contact_invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
