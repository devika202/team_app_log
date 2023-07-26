require 'rails_helper'

RSpec.describe 'teams/your_teams', type: :view do
  let(:current_user) { FactoryBot.create(:user) } 

  before do
    @team = FactoryBot.create(:team, manager: FactoryBot.create(:user))
    assign(:teams, [@team])
    allow(view).to receive(:current_user).and_return(current_user)
    render
  end

  it 'displays team names' do
    expect(rendered).to have_selector('h1', text: 'Your Teams')
    expect(rendered).to have_selector('li', text: @team.name)
  end

  context 'when the current user is not the manager of the team' do
    it 'displays "Join Team" link if the user is not already a member' do
      expect(rendered).not_to have_link('Join Team', href: join_team_path(@team, method: :post))

      @team.members << current_user 
      render

      expect(rendered).not_to have_link('Join Team', href: join_team_path(@team, method: :post))
    end
  end

  context 'when the current user is the manager of the team' do
    before do
      @team.manager = current_user
      render
    end

    it 'does not display "Join Team" link' do
      expect(rendered).not_to have_link('Join Team', href: join_team_path(@team, method: :post))
    end
  end
end
