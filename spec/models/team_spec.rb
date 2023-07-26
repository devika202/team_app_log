require 'rails_helper'

RSpec.describe Team, type: :model do
    let(:user) { FactoryBot.create(:user) }
    let(:team) { FactoryBot.create(:team, manager: user) }

  describe 'Validations' do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_least(3).is_at_most(100) }
    it { should validate_presence_of(:description) }
    it { should validate_length_of(:description).is_at_least(10).is_at_most(1000) }
    it { should validate_presence_of(:manager_id) }
  end

  describe 'Associations' do
    it { should have_many(:team_memberships).dependent(:delete_all) }
    it { should have_and_belong_to_many(:members).class_name('User').join_table(:team_memberships).dependent(:delete_all) }
    it { should have_many(:notes).dependent(:delete_all) }
    it { should belong_to(:manager).class_name('User') }
  end
end