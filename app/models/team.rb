class Team < ApplicationRecord
    has_many :team_memberships, dependent: :delete_all
    has_many :members, through: :team_memberships, source: :user
    has_many :notes, dependent: :delete_all

    belongs_to :manager, class_name: 'User'
end
