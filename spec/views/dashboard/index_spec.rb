require 'rails_helper'

RSpec.describe 'dashboard/index', type: :view do
  let(:current_user) { FactoryBot.create(:user) } 
  let(:team) { FactoryBot.create(:team) } 

  context 'when user is logged in' do
    before do
      allow(view).to receive(:current_user).and_return(current_user)
    end

    it 'displays a list of user teams' do
      assign(:teams, [team])
      allow(team).to receive_message_chain(:manager, :name).and_return('Manager Name')
      allow(team).to receive(:members).and_return([current_user])
      allow(view).to receive(:team_path).and_return('/teams/1')
      allow(view).to receive(:leave_team_team_path).and_return('/teams/1/leave_team')
      render
      expect(rendered).to have_content('YOUR TEAMS')
      expect(rendered).to have_content('Team Name')
      expect(rendered).to have_content('Description')
      expect(rendered).to have_content('Team Manager')
      expect(rendered).to have_content('Actions')
      expect(rendered).to have_content('Manager Name')
      expect(rendered).to have_link('View More', href: '/teams/1')
    end

    it 'does not display "Join Team" button for user\'s own team' do
      assign(:teams, [team])
      allow(team).to receive_message_chain(:manager, :name).and_return(current_user.name)
      allow(team).to receive(:members).and_return([current_user])
      allow(view).to receive(:team_path).and_return('/teams/1')
      allow(view).to receive(:leave_team_team_path).and_return('/teams/1/leave_team')
      render
      expect(rendered).to have_content('YOUR TEAMS')
      expect(rendered).not_to have_link('Join Team')
    end
  end

  context 'when user is logged in and not a team manager' do
    before do
      allow(view).to receive(:current_user).and_return(current_user)
    end

    it 'displays a list of all teams' do
      assign(:teams, [team])
      allow(team).to receive_message_chain(:manager, :name).and_return('Manager Name')
      allow(team).to receive(:members).and_return([])
      allow(view).to receive(:team_path).and_return('/teams/1')
      allow(view).to receive(:join_team_path).and_return('/teams/1/join_team')
      render
      expect(rendered).to have_content('ALL TEAMS')
      expect(rendered).to have_content('Team Name')
      expect(rendered).to have_content('Description')
      expect(rendered).to have_content('Team Manager')
      expect(rendered).to have_content('Actions')
      expect(rendered).to have_content('Manager Name')
      expect(rendered).to have_link('View More', href: '/teams/1')
      expect(rendered).to have_link('Join Team', href: '/teams/1/join_team')
    end

    it 'does not display "Join Team" button for user who is already a member' do
      assign(:teams, [team])
      allow(team).to receive_message_chain(:manager, :name).and_return('Manager Name')
      allow(team).to receive(:members).and_return([current_user])
      allow(view).to receive(:team_path).and_return('/teams/1')
      allow(view).to receive(:join_team_path).and_return('/teams/1/join_team')
      render
      expect(rendered).to have_content('ALL TEAMS')
      expect(rendered).not_to have_link('Join Team')
    end
  end
end
