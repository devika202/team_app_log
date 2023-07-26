require 'rails_helper'

RSpec.describe DashboardController, type: :controller do
  describe 'GET #index' do
    context 'when user is authenticated' do
      before do
        @user = create(:user)
        sign_in @user
      end

      it 'assigns @teams with all teams' do
        team1 = create(:team, name: 'Team 1')
        team2 = create(:team, name: 'Team 2')

        get :index
        expect(assigns(:teams)).to match_array([team1, team2])
      end

      it 'renders the index template' do
        get :index
        expect(response).to render_template('index')
      end
    end

    context 'when user is not authenticated' do
      it 'redirects to the sign-in page' do
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
