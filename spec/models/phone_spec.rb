require 'rails_helper'

RSpec.describe Phone, type: :model do
  it { is_expected.to validate_presence_of(:phone_number)}
  it { is_expected.to belong_to(:contact)} 
end
