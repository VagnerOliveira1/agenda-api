require "rails_helper"
describe Admin::ModelLoadingService do
  context "when #call" do
    let!(:contacts) { create_list(:contact, 15) }

    context "when params are present" do
      let!(:search_contacts) do
        contacts = []
        15.times { |n| contacts << create(:contact, full_name: "Search #{n + 1}") }
        contacts
      end
    
      let(:params) do
        { search: { full_name: "Search" }, order: { full_name: :desc }, page: 2, length: 4 }
      end

      it "returns right :length following pagination" do
        service = described_class.new(Contact.all, params)
        result_contacts = service.call
        expect(result_contacts.count).to eq 4
      end
    end

    context "when params are not present" do
      it "returns default :length pagination" do
        service = described_class.new(Contact.all, nil)
        result_contacts = service.call
        expect(result_contacts.count).to eq 10
      end

      it "returns first 10 records" do
        service = described_class.new(Contact.all, nil)
        result_contacts = service.call
        expected_contacts = contacts[0..9]
        expect(result_contacts).to contain_exactly *expected_contacts
      end
    end
  end
end
