FactoryBot.define do
  factory :phone do
    phone_number { Faker::PhoneNumber.cell_phone }
    kind  {%i[home office mobile whatsapp].sample}
    contact 
  end
end
