require 'rails_helper'

RSpec.describe Note, type: :model do
  let(:team) { create(:team) }
  let(:user) { create(:user) }

  describe 'associations' do
    it { should belong_to(:team) }
    it { should belong_to(:user) }
  end

  describe 'validations' do
    it { should validate_presence_of(:content) }
    it { should validate_presence_of(:title) }
    it { should validate_length_of(:title).is_at_most(100) }
    it { should validate_presence_of(:access_level) }
    it { should validate_presence_of(:team_id) }
    it { should validate_presence_of(:user_id) }
  end

  
  describe '.access_levels_options' do
    it 'returns a hash with access level options' do
      expect(Note.access_levels_options).to eq({
        "Members Only" => Note::ACCESS_MEMBERS,
        "Admin/Manager Only" => Note::ACCESS_ADMIN_MANAGER
      })
    end
  end
end
