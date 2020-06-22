FactoryBot.define do
  factory :user do
    address {Faker::Address.full_address}
    email {Faker::Internet.email}
    full_name {Faker::Name.unique.name}
    phone_number {Faker::PhoneNumber.phone_number}
  end
end
