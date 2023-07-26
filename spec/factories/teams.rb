FactoryBot.define do
    factory :team do
        name { 'KTU' }
        description {'abcdefghijklmnopqrstuvwxyz'}
      manager { association :user, :manager }
  
    end
  end
  