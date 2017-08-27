FactoryGirl.define do
  factory :address do
    street { Faker::Address.street_address }
    zip_code { Faker::Address.zip_code }
    state { Faker::Address.state }
    country { Faker::Address.country }
    city { Faker::Address.city }
    user_id nil
  end
end
