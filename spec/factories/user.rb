FactoryBot.define do
    factory :user do
        email { 'example@hotmail.com' }
        password { 'password123' }
        #before( :create) { |user| user.skip_confirmation! }

        #trait :organization_approved do
            role { :organization }
            # organization_id { create (:orgainization, :approved).id}
        #end

        #trait :orgainization_unapproved do 
            #role { :organization}
            #organization_id { create (:organization).id}
        #end

        #trait :admin do
            # role { :admin}
        #end
    end


end
