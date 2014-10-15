module Snoopy
  class Railtie < Rails::Railtie
    # config.autoload_paths << File.expand_path("../lib/some/path", __FILE__)

    initializer "snoopy.add_middleware" do |app|
      # app.middleware.use MyEngine::Middleware

      if ( ( basic_auth_enabled  = ENV["BASIC_AUTH_ENABLED"] ) == "true" &&
           ( basic_auth_user     = ENV["BASIC_AUTH_USER"] ).present? &&
           ( basic_auth_password = ENV["BASIC_AUTH_PASSWORD"] ).present? )

        app.middleware.use "::Rack::Auth::Basic", "#{Rails.application.class.parent_name} #{Rails.env}" do |u, p|
          [u, p] == [ basic_auth_user, basic_auth_password ]
        end

      end
    end
  end
end
