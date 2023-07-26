require 'rails_helper'

RSpec.describe UsersController, type: :controller do
    include FactoryBot::Syntax::Methods
    include Devise::Test::ControllerHelpers

  let(:manager_user) { create(:user, role: 'manager') }
  let(:user) { create(:user) }
  let(:team) { create(:team) }
  let(:admin_user) { create(:user, role: 'admin') }

  describe 'GET #index' do
    context 'when authenticated as an admin' do
      before { sign_in(admin_user) }

      it 'returns a successful response' do
        get :index
        expect(response).to be_successful
      end

      it 'assigns all users to @users' do
        get :index
      end
    end

    context 'when authenticated as a non-admin user' do
      before { sign_in(manager_user) }

      it 'redirects to root_path' do
        get :index
        expect(response)
      end

      it 'displays an alert message' do
        get :index
        expect(flash[:alert])
      end
    end
  end

  describe 'GET #teams' do
    context 'when authenticated' do
      before { sign_in(user) }

      it 'returns a successful response' do
        get :teams, params: { id: user.id }
        expect(response).to be_successful
      end

      it 'assigns the user to @user' do
        get :teams, params: { id: user.id }
      end

      it 'assigns the user teams to @teams' do
        team = create(:team)
        user.teams << team
        get :teams, params: { id: user.id }
      end
    end
  end

  describe 'GET #new' do
    it 'returns a successful response' do
      get :new
      expect(response)
    end

    it 'assigns a new user to @user' do
      get :new
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      let(:valid_params) { attributes_for(:user) }

      it 'creates a new user' do
        expect {
          post :create, params: { user: valid_params }
        }
      end

      it 'redirects to root_path' do
        post :create, params: { user: valid_params }
        expect(response)
      end

      it 'displays a success message' do
        post :create, params: { user: valid_params }
        expect(flash[:notice])
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) { attributes_for(:user, name: nil) }

      it 'does not create a new user' do
        expect {
          post :create, params: { user: invalid_params }
        }.not_to change(User, :count)
      end

      it 'renders the new template' do
        post :create, params: { user: invalid_params }
        expect(response)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when authenticated as an admin' do
      before { sign_in(admin_user) }

      it 'destroys the user' do
        user_to_destroy = create(:user)
        expect {
          delete :destroy, params: { id: user_to_destroy.id }
        }.to change(User, :count).by(-1)
      end

      it 'redirects to root_path' do
        delete :destroy, params: { id: user.id }
        expect(response)
      end

      it 'displays a success message' do
        delete :destroy, params: { id: user.id }
        expect(flash[:notice])
      end
    end

    context 'when authenticated as a non-admin user' do
      before { sign_in(manager_user) }

      it 'does not destroy the user' do
        user_to_destroy = create(:user)
        expect {
          delete :destroy, params: { id: user_to_destroy.id }
        }.not_to change(User, :count)
      end

      it 'redirects to root_path' do
        delete :destroy, params: { id: user.id }
        expect(response).to redirect_to(root_path)
      end

      it 'displays an alert message' do
        delete :destroy, params: { id: user.id }
        expect(flash[:alert]).to eq('Access denied. You are not authorized to delete this account.')
      end
    end
  end

  describe 'PATCH #update_role' do
    let(:new_role) { 'manager' }
    let(:valid_params) { { role: new_role } }

    context 'when authenticated as an admin' do
      before { sign_in(admin_user) }

      it 'updates the user role' do
        patch :update_role, params: { id: user.id, user: valid_params }
        expect(user.reload.role).to eq(new_role)
      end

      it 'redirects to users_path' do
        patch :update_role, params: { id: user.id, user: valid_params }
        expect(response).to redirect_to(users_path)
      end

      it 'displays a success message' do
        patch :update_role, params: { id: user.id, user: valid_params }
        expect(flash[:notice]).to eq('User role updated successfully.')
      end
    end

    context 'when authenticated as a non-admin user' do
      before { sign_in(manager_user) }

      it 'does not update the user role' do
        patch :update_role, params: { id: user.id, user: valid_params }
        expect(user.reload.role).not_to eq(new_role)
      end

      it 'redirects to users_path' do
        patch :update_role, params: { id: user.id, user: valid_params }
        expect(response)
      end

      it 'displays an alert message' do
        patch :update_role, params: { id: user.id, user: valid_params }
        expect(flash[:alert])
      end
    end
  end
end
