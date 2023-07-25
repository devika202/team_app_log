class Team < ApplicationRecord
    has_many :team_memberships, dependent: :delete_all
    has_and_belongs_to_many :members, class_name: 'User', join_table: :team_memberships, dependent: :delete_all
    has_many :notes, dependent: :delete_all
    belongs_to :manager, class_name: 'User'
    validates :name, presence: true, length: { minimum: 3, maximum: 100 }
    validates :description, presence: true, length: { minimum: 10, maximum: 1000 }
    validates :manager_id, presence: true
    def note_access_level
        notes_access_levels = notes.pluck(:access_level).uniq
        if notes_access_levels.size == 1
          notes_access_levels.first
        else
          Note::ACCESS_PUBLIC
        end
      end
end
