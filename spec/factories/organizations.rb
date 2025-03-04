FactoryBot.define do
  factory :organization do
    sequence :name do |n| "organization #{n}" end
    sequence :email do |n| "testemail#{n}@hotmail.com" end
    phone { "+1-555-555-5555" }
    primary_name { "test_primary_name" }
    secondary_name { "test_secondary_name" }
    secondary_phone { "+1-666-666-6666" }
    trait :admin do
      role { :admin }
    end
  end
end
