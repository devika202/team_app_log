class Note < ApplicationRecord
    belongs_to :team
    belongs_to :user
  
    enum access_level: { all_members: 0, admins_and_managers: 1 }
  end
  