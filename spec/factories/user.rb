FactoryBot.define do
    factory :user do
        email { 'example@hotmail.com' }
        password { 'password123' }
        role { :organization }
    end


end
