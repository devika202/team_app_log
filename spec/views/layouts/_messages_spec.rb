require 'rails_helper'

RSpec.describe 'layouts/_messages.html.erb', type: :view do
  context 'when flash messages are present' do
    it 'displays success flash message' do
      flash[:notice] = 'Success message'
      render

      expect(rendered).to have_selector('.alert.alert-success', text: 'Success message')
    end

    it 'displays danger flash message' do
      flash[:alert] = 'Danger message'
      render

      expect(rendered).to have_selector('.alert.alert-danger', text: 'Danger message')
    end
  end

  context 'when flash messages are not present' do
    it 'does not display any flash message' do
      render

      expect(rendered).not_to have_selector('.alert')
    end
  end
end
