FactoryBot.define do
    factory :resource_category do
        sequence(:name) { |n| "Resource Category #{n}" }
        active { true }
    end

end
