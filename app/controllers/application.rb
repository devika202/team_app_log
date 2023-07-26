module TeamManagementApp
    class Application < Rails::Application
      config.middleware.use Milia::Control
    end
  end
  