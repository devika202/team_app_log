require 'rails_helper'

RSpec.describe 'teams/index', type: :view do
    include FactoryBot::Syntax::Methods
  let(:user) { create(:user) } 

  before do
    assign(:teams, teams) 
    allow(view).to receive(:current_user).and_return(user)
  end

  context 'when user is a manager' do
    let(:user) { create(:user, role: 'manager') }
    let(:teams) { create_list(:team, 3, manager: user) }

    it 'displays teams with remove links for members' do
      render

      expect(rendered).to have_selector('h1', text: 'TEAMS')
      expect(rendered).to have_selector('table.table')
      expect(rendered).to have_selector('tbody tr', count: 3)

      teams.each do |team|
        expect(rendered).to have_content(team.name)
        expect(rendered).to have_content(team.description)
        expect(rendered).to have_content(team.manager.name)

        team.members.each do |member|
          next if team.manager == member

          expect(rendered).to have_link('Remove', href: remove_member_team_path(team, user_id: member.id))
        end
      end
    end
  end

  context 'when user is not a manager' do
    let(:user) { create(:user, role: 'member') }
    let(:teams) { create_list(:team, 3) }

    it 'displays teams without remove links' do
      render

      expect(rendered).to have_selector('h1', text: 'TEAMS')
      expect(rendered).to have_selector('table.table')
      expect(rendered).to have_selector('tbody tr', count: 3)

      teams.each do |team|
        expect(rendered).to have_content(team.name)
        expect(rendered).to have_content(team.description)
        expect(rendered).to have_content(team.manager.name)
        expect(rendered).not_to have_link('Remove')
      end
    end
  end
end