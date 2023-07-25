class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :team_memberships, dependent: :delete_all
  has_and_belongs_to_many :teams, join_table: :team_memberships, dependent: :delete_all
  has_many :owned_teams, class_name: 'Team', foreign_key: 'manager_id'
  has_many :notes, dependent: :delete_all
  has_many :managed_teams, class_name: 'Team', foreign_key: 'manager_id'

  enum role: { admin: 'admin', manager: 'manager', member: 'member' }

  ROLES = ['admin', 'manager', 'member'].freeze

  def admin?
    role == 'admin'
  end

  def manager?
    role == 'manager'
  end

  def member?
    role == 'member'
  end

  validate :manager_cannot_change_manager_role

  def manager_cannot_change_manager_role
    if manager? && role_changed? && role_was == 'manager'
      errors.add(:role, "Managers cannot change the Manager role of other users.")
    end
  end

  def teams_exist?
    manager? && Team.exists?(manager_id: self.id)
  end
end
