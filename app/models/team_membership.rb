class TeamMembership < ApplicationRecord
  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller && controller.current_user }
  belongs_to :user
  belongs_to :team

  validates_presence_of :user_id
  validates_presence_of :team_id
end
