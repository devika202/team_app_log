class Note < ApplicationRecord
  belongs_to :team
  belongs_to :user
  validates :content, presence: true
  validates :title, presence: true, length: { maximum: 100 }
  validates :access_level, presence: true
  validates :team_id, presence: true
  validates :user_id, presence: true
  # ACCESS_PUBLIC = 0
  ACCESS_MEMBERS = 1
  ACCESS_ADMIN_MANAGER = 2

  def truncated_description
    content.truncate_words(20)
  end

  def access_level_text
    case access_level
    # when ACCESS_PUBLIC
    #   "Public"
    when ACCESS_MEMBERS
      "Members Only"
    when ACCESS_ADMIN_MANAGER
      "Admin/Manager Only"
    else
      "Unknown"
    end
  end

  def self.access_levels_options
    {
      # "Public" => ACCESS_PUBLIC,
      "Members Only" => ACCESS_MEMBERS,
      "Admin/Manager Only" => ACCESS_ADMIN_MANAGER
    }
  end
end
