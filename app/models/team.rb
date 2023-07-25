class Team < ApplicationRecord
    has_many :team_memberships, dependent: :delete_all
    has_and_belongs_to_many :members, class_name: 'User', join_table: :team_memberships, dependent: :delete_all
    has_many :notes, dependent: :delete_all

    belongs_to :manager, class_name: 'User'
end
