require 'rails_helper'

RSpec.describe 'notes/show', type: :view do
    include Devise::Test::ControllerHelpers
    include FactoryBot::Syntax::Methods
  let(:note) { FactoryBot.create(:note, title: 'Test Note', content: 'Sample content', access_level: 'public') }
  let(:current_user) { FactoryBot.create(:user) }
  let(:team) { FactoryBot.create(:team, manager: current_user) }

  before do
    assign(:note, note)
    assign(:team, team)
  end
  
  before(:each) do
    sign_in current_user
  end
  
  it 'displays the "Update Access" button' do
    render
    expect(rendered).to have_button('Update Access')
  end
  

  context 'when current user is an admin or the manager of the team' do
    before do
      allow(current_user).to receive(:admin?).and_return(true)
      render
    end

    it 'displays the note title' do
      expect(rendered).to have_selector('h1', text: 'Test Note')
    end

    it 'displays the note content' do
      expect(rendered).to have_content('Sample content')
    end

    it 'displays the note access level' do
      expect(rendered)
    end

    it 'displays the "Delete Note" button' do
      expect(rendered).to have_link('Delete Note', href: delete_note_path(note))
    end

    it 'displays the "Change Access Level" section' do
      expect(rendered).to have_selector('h4', text: 'Change Access Level:')
      expect(rendered)
    end

    it 'displays the access level select dropdown' do
      expect(rendered)
    end

    it 'displays the "Update Access" button' do
      expect(rendered).to have_button('Update Access')
    end
  end

  context 'when current user is neither an admin nor the manager of the team' do
    before do
      allow(current_user).to receive(:admin?).and_return(false)
      render
    end

    it 'displays the note title' do
      expect(rendered).to have_selector('h1', text: 'Test Note')
    end

    it 'displays the note content' do
      expect(rendered).to have_content('Sample content')
    end

    it 'displays the note access level' do
      expect(rendered)
    end

    it 'does not display the "Delete Note" button' do
      expect(rendered)
    end

    it 'does not display the "Change Access Level" section' do
      expect(rendered)
    end
  end
end
