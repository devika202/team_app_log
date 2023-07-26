require 'rails_helper'

RSpec.describe TeamMembership, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:team) }
  end

  describe 'validations' do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:team_id) }
  end
end
