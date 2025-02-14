FactoryBot.define do
  factory :ticket do
    name { "test_ticket" }
    id { rand(1..999) }
    phone { "+1-555-555-5555" }
    # TODO is there a way to do this without creating new
    # entries to the DB? i.e using `create` when could
    # use `new`, etc.
    region_id { create(:region).id }
    resource_category_id { create(:resource_category).id }
  end
end
