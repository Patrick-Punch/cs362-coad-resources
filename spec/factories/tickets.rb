FactoryBot.define do
  factory :ticket do
    sequence :name do |n| "ticket #{n}" end
    phone { "+1-555-555-5555" }
    # TODO is there a way to do this without creating new
    # entries to the DB? i.e using `create` when could
    # use `new`, etc.
    region_id { create(:region).id }
    resource_category_id { create(:resource_category).id }

    trait :open do
      closed { false }
    end

    trait :closed do
      closed { true }
    end

    trait :captured do
      closed { false }
      transient do
        org_id { create(:organization).id }
      end

      organization_id { org_id }
    end
  end
end
