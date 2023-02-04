require 'rails_helper'

RSpec.describe Contact, type: :model do
  it { is_expected.to validate_presence_of(:full_name)}
  it { is_expected.to validate_presence_of(:email)}
  it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  it { is_expected.to validate_presence_of(:cpf)}
  it { is_expected.to validate_uniqueness_of(:cpf)}
  it { is_expected.to validate_presence_of(:birth_date)}
  it { is_expected.to have_many(:addresses)}
  it { is_expected.to have_many(:phones)}

  it_behaves_like "name searchable concern", :contact
end
