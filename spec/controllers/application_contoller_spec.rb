require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
    include Devise::Test::ControllerHelpers

  controller do
    def index
      render plain: 'Hello, world!'
    end
  end

  describe 'filters' do
    it 'calls protect_from_forgery with :exception' do
      expect(controller)
      process :index, method: :get
    end

    it 'includes MultiTenantConcern' do
      expect(ApplicationController.ancestors).to include(MultiTenantConcern)
    end

    context 'when a devise controller is involved' do
      before do
        @request.env['devise.mapping'] = Devise.mappings[:user]
      end

      it 'calls configure_permitted_parameters for sign_up' do
        expect(controller)
        process :index, method: :get
      end

      it 'calls configure_permitted_parameters for account_update' do
        expect(controller)
        put :index, params: { user: { name: 'John Doe' } }
      end

      it 'permits :name for sign_up' do
        process :index, method: :get
      end

      it 'permits :name for account_update' do
        put :index, params: { user: { name: 'John Doe' } }
      end
    end
  end
end
