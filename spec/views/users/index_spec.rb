require 'rails_helper'

RSpec.describe 'users/index', type: :view do
  let(:admin_user) { FactoryBot.create(:user, role: :admin) }
  let(:regular_user) { FactoryBot.create(:user, role: :member) }
  let(:manager_user) { FactoryBot.create(:user, role: :manager) }

  before do
    assign(:users, [admin_user, regular_user, manager_user])
    allow(view).to receive(:current_user).and_return(admin_user)
    render
  end

  context 'when the current user is an admin' do
    it 'renders the users list table' do
      expect(rendered).to have_selector('table.table')
      expect(rendered).to have_selector('thead')
      expect(rendered).to have_selector('tbody')
    end

    it 'displays user details' do
      expect(rendered).to have_content(admin_user.name)
      expect(rendered).to have_content(admin_user.email)
      expect(rendered).to have_content(admin_user.role.capitalize)
    end

    it 'displays the update role form' do
      expect(rendered).to have_selector('form.form-inline')
      expect(rendered).to have_selector('select.form-control')
      expect(rendered).to have_button('Update')
    end

    it 'displays "View Teams" button for all users' do
      expect(rendered).to have_link('View Teams', count: 3)
    end

    it 'displays "Delete" button for manager users without teams' do
      expect(rendered)
    end

    it 'displays a message for manager users with teams that role update is disabled' do
      expect(rendered)
    end

    it 'displays a message for manager users with teams that delete action is disabled' do
      expect(rendered)
    end
  end

  context 'when the current user is not an admin' do
    before do
      allow(view).to receive(:current_user).and_return(regular_user)
      render
    end

    it 'does not display the delete button for any user' do
      expect(rendered)
    end

    it 'does not display the message for manager users with teams' do
      expect(rendered).not_to have_content("User is a manager of a team. Delete action is disabled.")
    end
  end
end
