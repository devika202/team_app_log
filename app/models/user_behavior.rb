class UserBehavior < ApplicationRecord
    belongs_to :user

    validates :user_id, :page_name, :timestamp, presence: true
  end
