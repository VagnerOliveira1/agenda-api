require 'rails_helper'


RSpec.describe Phone, type: :model do
  it { is_expected.to validate_presence_of(:phone_number)}
  it { is_expected.to belong_to(:contact)} 
  it { is_expected.to define_enum_for(:kind).with_values({ home: 0, office: 1, mobile: 2, whatsapp: 3 }) }

end
