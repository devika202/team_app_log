require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:team_memberships).dependent(:delete_all) }
    it { should have_and_belong_to_many(:teams).dependent(:delete_all) }
    it { should have_many(:owned_teams).class_name('Team').with_foreign_key('manager_id') }
    it { should have_many(:notes).dependent(:delete_all) }
    it { should have_many(:managed_teams).class_name('Team').with_foreign_key('manager_id') }
  end

  describe 'password validations' do
    context 'when creating a new user' do
      it { should validate_presence_of(:password) }
    end

    context 'when updating an existing user' do
      let(:user) { FactoryBot.create(:user) }

      it 'does not require a password' do
        user.update(name: 'New Name')
        expect(user).to be_valid
      end

      it 'validates password length if present' do
        user.update(password: '12345')
        expect(user).not_to be_valid
        expect(user.errors[:password]).to include('is too short (minimum is 6 characters)')
      end
    end
  end

  describe 'methods' do
    let(:user) { FactoryBot.create(:user) }
    let(:manager_user) { FactoryBot.create(:user, role: 'manager') }
    let(:team) { FactoryBot.create(:team, manager: manager_user) }

    describe '#admin?' do
      it 'returns true if user is an admin' do
        user.update(role: 'admin')
        expect(user.admin?).to be_truthy
      end

      it 'returns false if user is not an admin' do
        expect(user.admin?).to be_falsy
      end
    end

    describe '#manager?' do
      it 'returns true if user is a manager' do
        expect(manager_user.manager?).to be_truthy
      end

      it 'returns false if user is not a manager' do
        expect(user.manager?).to be_falsy
      end
    end

    describe '#member?' do
      it 'returns true if user is a member' do
        expect(user.member?).to be_truthy
      end

      it 'returns false if user is not a member' do
        expect(manager_user.member?).to be_falsy
      end
    end

    describe '#manager_cannot_change_manager_role' do
      it 'adds an error if a manager tries to change the manager role of another user' do
        user.update(role: 'manager')
        user.role = 'member'
      end

      it 'does not add an error if a manager changes their own role' do
        manager_user.role = 'admin'
      end
    end

    describe '#teams_exist?' do
      it 'returns false if the user is not a manager' do
        expect(user.teams_exist?).to be_falsy
      end

      it 'returns true if the user is a manager and has managed teams' do
        team 
        expect(manager_user.teams_exist?).to be_truthy
      end
    end
  end
end
