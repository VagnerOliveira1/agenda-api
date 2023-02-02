FactoryBot.define do
  factory :address do
    zip_code { Faker::Address.zip_code }
    street { Faker::Address.street_name }
    number { Faker::Address.building_number }
    district { Faker::Address.district }
    city { Faker::Address.city }
    state { Faker::Address.state }
    contact
  end
end
