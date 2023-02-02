FactoryBot.define do
  factory :contact do
    full_name { Faker::Name.name }
    cpf { Faker::CPF.number }
    email { Faker::Internet.email }
    birth_date { "2023-02-02 08:44:37" }
  end
end
