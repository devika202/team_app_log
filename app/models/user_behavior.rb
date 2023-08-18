class UserBehavior < ApplicationRecord
  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller && controller.current_user }
    belongs_to :user

    validates :user_id, :page_name, :timestamp, presence: true
  end
