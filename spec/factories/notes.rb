FactoryBot.define do
    factory :note do
      title { 'Sample Note' }
      content { 'Note content' }
      association :user
      association :team
      access_level { 'public' }
      trait :public_access do
        access_level { Note::ACCESS_PUBLIC }
      end
  
      trait :private_access do
        access_level { Note::ACCESS_PRIVATE }
      end
    end
  end
  