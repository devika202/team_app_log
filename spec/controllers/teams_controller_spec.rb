require 'rails_helper'

RSpec.describe TeamsController, type: :controller do
    include FactoryBot::Syntax::Methods
    include Devise::Test::ControllerHelpers
  let(:admin) { create(:user, role: 'admin') }
  let(:manager) { create(:user, role: 'manager') }
  let(:user) { create(:user) }
  let(:team) { create(:team, manager: manager) }

  describe 'GET #index' do
    context 'when user is authenticated as admin' do
      before { sign_in admin }

      it 'assigns all teams to @teams' do
        teams = create_list(:team, 3)
        get :index
      end
    end

    context 'when user is authenticated as manager' do
      before { sign_in manager }

      it 'assigns the manager-owned teams to @teams' do
        teams = create_list(:team, 2, manager: manager)
        get :index
      end
    end

    context 'when user is authenticated as a regular user' do
      before { sign_in user }

      it 'assigns the users joined teams to @teams' do
        team1 = create(:team)
        team2 = create(:team)
        team1.members << user
        get :index
      end
    end

    context 'when user is not authenticated' do
      it 'redirects to the sign-in page' do
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'GET #your_teams' do
    context 'when user is authenticated' do
      before { sign_in user }

      it 'assigns the teams owned by the current user to @teams' do
        teams = create_list(:team, 2, manager: user)
        get :your_teams
      end

      it 'redirects to the dashboard' do
        get :your_teams
        expect(response).to redirect_to(dashboard_path)
      end
    end

    context 'when user is not authenticated' do
      it 'redirects to the sign-in page' do
        get :your_teams
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'GET #joined_teams' do
    context 'when user is authenticated' do
      before { sign_in user }

      it 'assigns the teams that the current user has joined to @teams' do
        team1 = create(:team)
        team2 = create(:team)
        team1.members << user
        get :joined_teams
      end
    end

    context 'when user is not authenticated' do
      it 'redirects to the sign-in page' do
        get :joined_teams
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'DELETE #remove_member' do
    let(:other_user) { create(:user) }

    context 'when user is authenticated as admin or team manager' do
      before { sign_in manager }

      it 'removes the specified user from the team members' do
        team.members << other_user
        expect {
          delete :remove_member, params: { id: team.id, user_id: other_user.id }
        }.to change(team.members, :count).by(-1)
      end

      it 'redirects to the team show page' do
        delete :remove_member, params: { id: team.id, user_id: other_user.id }
        expect(response)
      end

      it 'sets a flash notice' do
        delete :remove_member, params: { id: team.id, user_id: other_user.id }
        expect(flash[:notice]).to eq('Member removed from the team.')
      end
    end

    context 'when user is authenticated as a regular user' do
      before { sign_in user }

      it 'does not remove the specified user from the team members' do
        team.members << other_user
        expect {
          delete :remove_member, params: { id: team.id, user_id: other_user.id }
        }.not_to change(team.members, :count)
      end

      it 'redirects to the team show page' do
        delete :remove_member, params: { id: team.id, user_id: other_user.id }
        expect(response)
      end

      it 'sets a flash alert' do
        delete :remove_member, params: { id: team.id, user_id: other_user.id }
        expect(flash[:alert]).to eq('Access denied. You are not authorized to remove members from this team.')
      end
    end

    context 'when user is not authenticated' do
      it 'redirects to the sign-in page' do
        delete :remove_member, params: { id: team.id, user_id: other_user.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'DELETE #delete_team' do
    context 'when user is authenticated as admin' do
      before { sign_in admin }

      it 'deletes the team' do
        team 
        expect {
          delete :delete_team, params: { id: team.id }
        }.to change(Team, :count).by(-1)
      end

      it 'redirects to the dashboard' do
        delete :delete_team, params: { id: team.id }
        expect(response).to redirect_to(dashboard_path)
      end

      it 'sets a flash notice' do
        delete :delete_team, params: { id: team.id }
        expect(flash[:notice]).to eq('Team successfully deleted.')
      end
    end

    context 'when user is authenticated as manager' do
      before { sign_in manager }

      it 'does not delete the team' do
        team 
        expect {
          delete :delete_team, params: { id: team.id }
        }.not_to change(Team, :count)
      end

      it 'redirects to the dashboard' do
        delete :delete_team, params: { id: team.id }
        expect(response).to redirect_to(dashboard_path)
      end

      it 'sets a flash alert' do
        delete :delete_team, params: { id: team.id }
        expect(flash[:alert]).to eq('You are not authorized to delete this team.')
      end
    end

    context 'when user is not authenticated' do
      it 'redirects to the sign-in page' do
        delete :delete_team, params: { id: team.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

end
