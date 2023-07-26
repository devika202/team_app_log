require 'rails_helper'

RSpec.describe NotesController, type: :controller do
    include FactoryBot::Syntax::Methods
    include Devise::Test::ControllerHelpers
  let(:user) { FactoryBot.create(:user) }
  let(:team) { FactoryBot.create(:team) }
  let(:note) { FactoryBot.create(:note, team: team) }

  describe 'GET #show' do
    context 'when the user is authenticated' do
      before do
        sign_in user
        get :show, params: { id: note.id }
      end

      it 'returns a 200 OK status' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when the user is not authenticated' do
      before { get :show, params: { id: note.id } }

      it 'redirects to the sign-in page' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'PATCH #update_note_access' do
    let(:new_access_level) { 'restricted' }

    context 'when the user is authenticated' do
      before do
        sign_in user
        note.reload
      end

      it 'updates the access_level attribute of the note' do
        expect(note.access_level)
      end

      it 'redirects to the note show page' do
        expect(response)
      end

      it 'sets the flash notice' do
        expect(flash[:notice])
      end

      it 'returns a 302 Found status' do
        expect(response)
      end
    end

    context 'when the user is not authenticated' do

      it 'redirects to the sign-in page' do
        expect(response)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when the user is authenticated' do
      before do
        sign_in user
        delete :destroy, params: { id: note.id }
      end

      it 'destroys the note' do
        expect { note.reload }.to raise_error(ActiveRecord::RecordNotFound)
      end

      it 'redirects to the dashboard' do
        expect(response).to redirect_to(dashboard_path)
      end

      it 'sets the flash notice' do
        expect(flash[:notice]).to eq('Note was successfully deleted.')
      end

      it 'returns a 302 Found status' do
        expect(response).to have_http_status(:found)
      end
    end

    context 'when the user is not authenticated' do
      before { delete :destroy, params: { id: note.id } }

      it 'redirects to the sign-in page' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
