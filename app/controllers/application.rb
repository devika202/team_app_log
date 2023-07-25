module YourAppName
    class Application < Rails::Application
      config.middleware.use Milia::Control
    end
  end
  