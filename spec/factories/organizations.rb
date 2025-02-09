FactoryBot.define do
  factory :organization do
    name { "test_organization" }
    email  { "testemail@hotmail.com" }
    phone { "+1-555-555-5555" }
    primary_name { "test_primary_name" }
    secondary_name { "test_secondary_name" }
    secondary_phone { "+1-666-666-6666" }
  end
end
