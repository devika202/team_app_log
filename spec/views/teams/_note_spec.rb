require 'rails_helper'

RSpec.describe 'teams/_note', type: :view do
    let(:team) { FactoryBot.create(:team, manager: user) }
    let(:user) { FactoryBot.create(:user) }
    let(:admin) { FactoryBot.create(:user, role: 'admin') }

  before do
    assign(:team, team)
  end

  context 'when the team has notes' do
    before do
      assign(:team, team)
    end

    context 'when the user is signed in' do
      before do
        render
      end

      it 'displays notes with access level ACCESS_MEMBERS' do
        team.notes.each do |note|
          note.update(access_level: Note::ACCESS_MEMBERS)
        end

      end

      it 'does not display notes with access level ACCESS_ADMIN_MANAGER' do
        team.notes.each do |note|
          note.update(access_level: Note::ACCESS_ADMIN_MANAGER)
        end

        expect(rendered).not_to have_selector('.card')
      end
    end

    context 'when the user is an admin or manager' do
      before do
        team.update(manager: admin) # Assuming the admin is the team manager
        render
      end

      it 'displays notes with access level ACCESS_MEMBERS' do
        team.notes.each do |note|
          note.update(access_level: Note::ACCESS_MEMBERS)
        end

      end

      it 'displays notes with access level ACCESS_ADMIN_MANAGER' do
        team.notes.each do |note|
          note.update(access_level: Note::ACCESS_ADMIN_MANAGER)
        end

      end
    end
  end

  context 'when the team has no notes' do
    before do
      render
    end

    it 'displays a message indicating no notes available' do
      expect(rendered).to have_text('No notes available.')
    end
  end
end
