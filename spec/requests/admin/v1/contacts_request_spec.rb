require 'rails_helper'

RSpec.describe "Admin::V1::Contacts", type: :request do
  let(:user) { create(:user) }

  context "GET /contacts" do
    let(:url) { "/admin/v1/contacts" }
    let!(:contacts) { create_list(:contact, 20) }
    
    context "without any params" do
      it "returns 20 Contatcs" do
        get url, headers: auth_header(user)
        expect(body_json['contacts'].count).to eq 20
      end
      
      it "returns 20 first Contatcs" do
        get url, headers: auth_header(user)
        expected_contacts = contacts[0..19].as_json(only: %i(id full_name email))
        expect(body_json['contacts']).to match_array expected_contacts
      end

      it "returns success status" do
        get url, headers: auth_header(user)
        expect(response).to have_http_status(:ok)
      end
    end

    context "with search[full_name] param" do
      let!(:search_name_contacts) do
        contacts = [] 
        15.times { |n| contacts << create(:contact, full_name: "Search #{n + 1}") }
        contacts 
      end

      let(:search_params) { { search: { full_name: "Search" } } }

      it "returns only seached contacts limited by default pagination" do   #{}// Voltar para resolver esse teste
        get url, headers: auth_header(user), params: search_params          
        expected_contacts = search_name_contacts[0..19].map do |contact|
          contact.as_json(only: %i(id full_name email))
        end
        expect(body_json['contacts']).to contain_exactly *expected_contacts
      end

      it "returns success status" do
        get url, headers: auth_header(user), params: search_params
        expect(response).to have_http_status(:ok)
      end
    end

    context "with pagination params" do
      let(:page) { 2 }
      let(:length) { 10 }

      let(:pagination_params) { { page: page, length: length } }

      it "returns records sized by :length" do
        get url, headers: auth_header(user), params: pagination_params
        expect(body_json['contacts'].count).to eq length
      end
      
      it "returns contacts limited by pagination" do
        get url, headers: auth_header(user), params: pagination_params
        expected_contacts = contacts[10..19].as_json(only: %i(id full_name email))
        expect(body_json['contacts']).to contain_exactly *expected_contacts
      end

      it "returns success status" do
        get url, headers: auth_header(user), params: pagination_params
        expect(response).to have_http_status(:ok)
      end
    end

    context "with order params" do
      let(:order_params) { { order: { full_name: 'desc' } } }

      it "returns ordered contacts limited by default pagination" do
        get url, headers: auth_header(user), params: order_params
        contacts.sort! { |a, b| b[:full_name] <=> a[:full_name]}
        expected_contacts = contacts[0..19].as_json(only: %i(id full_name email))
        expect(body_json['contacts']).to match_array expected_contacts
      end
 
      it "returns success status" do
        get url, headers: auth_header(user), params: order_params
        expect(response).to have_http_status(:ok)
      end
    end
  end 

  context "GET /contats/:id" do
    let(:contact) { create(:contact) }
    let(:url) { "/admin/v1/contacts/#{contact.id}" }

    it "returns requested Contact" do
      get url, headers: auth_header(user)
      expected_contact = contact.as_json(only: %i(id full_name email))
      expect(body_json['contact']).to eq expected_contact
    end

    it "returns success status" do
      get url, headers: auth_header(user)
      expect(response).to have_http_status(:ok)
    end
  end

  # context "POST /contacts" do
  #   let(:url) { "/admin/v1/contacts" }
  
  #   context "with valid params" do
  #     let(:contact_params) { { contact: attributes_for(:contact) }.to_json }
  #     it 'adds a new Contact' do
  #       expect do
  #         post url, headers: auth_header(user), params: contact_params
  #       end.to change(Contact, :count).by(1)
  #     end

  #     it 'returns last added Contact' do
  #       post url, headers: auth_header(user), params: contact_params
  #       expected_contact = Contact.last.as_json(only: %i(id full_name email))
  #       expect(body_json['contact']).to eq expected_contact
  #     end

  #     it 'returns success status' do
  #       post url, headers: auth_header(user), params: contact_params
  #       expect(response).to have_http_status(:ok)
  #     end
  #   end
  
  #   context "with invalid params" do
  #     let(:contact_invalid_params) do 
  #       { contact: attributes_for(:contact, full_name: nil) }.to_json
  #     end

  #     it 'does not add a new Contact' do
  #       expect do
  #         post url, headers: auth_header(user), params: contact_invalid_params
  #       end.to_not change(Contact, :count)
  #     end

  #     it 'returns error message' do
  #       post url, headers: auth_header(user), params: contact_invalid_params
  #       expect(body_json['errors']['fields']).to have_key('full_name')
  #     end

  #     it 'returns unprocessable_entity status' do
  #       post url, headers: auth_header(user), params: contact_invalid_params
  #       expect(response).to have_http_status(:unprocessable_entity)
  #     end
  #   end
  # end

  context "PATCH /contacts/:id" do
    let(:contact) { create(:contact) }
    let(:url) { "/admin/v1/contacts/#{contact.id}" }

    context "with valid params" do
      let(:new_name) { 'My new Contact' }
      let(:contact_params) { { contact: { full_name: new_name } }.to_json }

      it 'updates Contact' do
        patch url, headers: auth_header(user), params: contact_params
        contact.reload
        expect(contact.full_name).to eq new_name
      end

      it 'returns updated Contact' do
        patch url, headers: auth_header(user), params: contact_params
        contact.reload
        expected_contact = contact.as_json(only: %i(id full_name email))
        expect(body_json['contact']).to eq expected_contact
      end

      it 'returns success status' do
        patch url, headers: auth_header(user), params: contact_params
        expect(response).to have_http_status(:ok)
      end
    end
  
    # context "with invalid params" do
    #   let(:contact_invalid_params) do 
    #     { contact: attributes_for(:contact, full_name: nil) }.to_json
    #   end

    #   it 'does not update Contact' do
    #     old_name = contact.full_name
    #     patch url, headers: auth_header(user), params: contact_invalid_params
    #     contact.reload
    #     expect(contact.full_name).to eq old_name
    #   end

    #   it 'returns error message' do
    #     patch url, headers: auth_header(user), params: contact_invalid_params
    #     expect(body_json['errors']['fields']).to have_key('full_name')
    #   end

    #   it 'returns unprocessable_entity status' do
    #     patch url, headers: auth_header(user), params: contact_invalid_params
    #     expect(response).to have_http_status(:unprocessable_entity)
    #   end
    # end

  end

  context "DELETE /contacts/:id" do
    let!(:contact) { create(:contact) }
    let(:url) { "/admin/v1/contacts/#{contact.id}" }

    it 'removes Contact' do
      expect do  
        delete url, headers: auth_header(user)
      end.to change(Contact, :count).by(-1)
    end
  
    it 'returns success status' do
      delete url, headers: auth_header(user)
      expect(response).to have_http_status(:no_content)
    end
  
    it 'does not return any body content' do
      delete url, headers: auth_header(user)
      expect(body_json).to_not be_present
    end
  end
end
