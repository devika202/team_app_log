require 'rails_helper'

RSpec.describe 'teams/show', type: :view do
  let(:team_manager) { FactoryBot.create(:user) }
  let(:current_user) { FactoryBot.create(:user) }
  let(:team) { FactoryBot.create(:team, manager: team_manager) }

  before do
    assign(:team, team)
    allow(view).to receive(:current_user).and_return(current_user)
    render
  end

  it 'displays the team name' do
    expect(rendered).to have_selector('h1', text: "Team: #{team.name}")
  end


  it 'displays the team manager' do
    expect(rendered).to have_selector('p strong', text: "Team Manager: #{team.manager.name}")
  end

  context 'when the current user is a member of the team' do
    let(:current_user) { FactoryBot.create(:user) }

    before do
      team.members << current_user
      render
    end

    it 'displays the "Leave Team" button' do
      expect(rendered).to have_selector('a.btn.btn-danger', text: 'Leave Team')
    end
  end

  context 'when the current user is not a member of the team' do
    before do
      render
    end

    it 'does not display the "Leave Team" button' do
      expect(rendered).not_to have_selector('a.btn.btn-danger', text: 'Leave Team')
    end

    it 'displays the "Join Team" button' do
      expect(rendered).to have_selector('a.btn.btn-primary', text: 'Join Team')
    end
  end

  context 'when the current user is the team manager or an admin' do
    let(:current_user) { team_manager }

    before do
      render
    end

    it 'displays the "Remove" button for each member (except the manager)' do
      team.members.each do |member|
        next if member == team.manager

        expect(rendered).to have_selector('a.btn.btn-danger', text: 'Remove')
      end
    end
  end

  context 'when the current user is neither the team manager nor a team member' do
    let(:current_user) { FactoryBot.create(:user) }

    before do
      render
    end

    it 'does not display the "Remove" button for any member' do
      expect(rendered).not_to have_selector('a.btn.btn-danger', text: 'Remove')
    end
  end

  it 'displays the total number of team members' do
    expect(rendered).to have_selector('h3', text: "Members : #{team.members.count}")
  end
end
