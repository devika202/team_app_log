require 'rails_helper'

RSpec.describe 'teams/joined_teams', type: :view do
  let(:current_user) { FactoryBot.create(:user) } 
  
  before do
    assign(:teams, teams)
    allow(view).to receive(:current_user).and_return(current_user)
    render
  end

  context 'when there are teams' do
    let(:teams) { [FactoryBot.create(:team, name: 'Team 1', description: 'Description 1', manager: current_user)] }

    it 'displays the joined teams correctly' do
      expect(rendered).to have_content('JOINED TEAMS')
      expect(rendered).to have_content('Team Name')
      expect(rendered).to have_content('Description')
      expect(rendered).to have_content('Manager')
      expect(rendered).to have_content('Actions')
      expect(rendered).to have_content('Team 1')
      expect(rendered).to have_content('Description 1')
      expect(rendered).to have_content(current_user.name)
      expect(rendered).to have_link('View More', href: team_path(teams.first))
    end
  end

  context 'when there are no teams' do
    let(:teams) { [] }

    it 'displays a message when there are no joined teams' do
      expect(rendered).to have_content('JOINED TEAMS')
    end
  end
end
