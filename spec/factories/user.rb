FactoryBot.define do
  factory :user do
    name { 'Devika' }
    sequence(:email) { |n| "user#{n}@example.com" }
    password { 'administrator' }
    password_confirmation { 'administrator' }
    role { 'member' } 
    confirmed_at { Time.now } 
       
    factory :admin_user, parent: :user do
      role { 'admin' }
    end

    factory :manager_user, parent: :user do
      role { 'manager' }
    end
  end
end