FactoryGirl.define do
  factory :event do
    zone_code { Faker::Number.number(2) }
    zone_description { Faker::HowIMetYourMother.quote }
    event_type { Faker::Number.hexadecimal(4) }
    address_id nil
  end
end
