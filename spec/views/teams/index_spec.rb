require 'rails_helper'

RSpec.describe 'teams/index.html.erb', type: :view do
  let(:user) { FactoryBot.create(:user) }
  let(:admin) { FactoryBot.create(:user, admin: true) }
  let(:manager) { FactoryBot.create(:user) }
  let(:team) { FactoryBot.create(:team, manager: manager) }

  before do
    assign(:teams, [team])
    assign(:managers, [manager])
    allow(view).to receive(:current_user).and_return(user)
  end

  context 'when the user is an admin' do
    before do
      allow(user).to receive(:admin?).and_return(true)
      render
    end

    it 'displays the "Update" button' do
      expect(rendered).to have_button('Update')
    end

    it 'displays the "Delete Team" button' do
      expect(rendered).to have_link('Delete Team')
    end

    it 'displays the manager selection dropdown' do
      expect(rendered).to have_select('manager_id')
    end
  end

  context 'when the user is a team member' do
    before do
      allow(team.members).to receive(:include?).with(user).and_return(true)
      render
    end

    it 'displays the "View More" button' do
      expect(rendered).to have_link('View More')
    end

    it 'displays the "Leave Team" button' do
      expect(rendered).to have_link('Leave Team')
    end

    it 'does not display the "Join Team" button' do
      expect(rendered).not_to have_link('Join Team')
    end
  end

  context 'when the user is not an admin or a team member' do
    before do
      render
    end

    it 'displays the "View More" button' do
      expect(rendered).to have_link('View More')
    end

    it 'does not display the "Delete Team" button' do
      expect(rendered).not_to have_link('Delete Team')
    end

    it 'does not display the "Leave Team" button' do
      expect(rendered).not_to have_link('Leave Team')
    end

    it 'displays the "Join Team" button' do
      expect(rendered).to have_link('Join Team')
    end
  end
end
