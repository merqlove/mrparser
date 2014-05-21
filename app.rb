require './boot'

libraries = Dir[File.expand_path('../lib/**/*.rb', __FILE__)]
libraries.each do |path_name|
  require path_name
end

I18n.enforce_available_locales = true
CACHE = Dalli::Client.new ["127.0.0.1:11211"]

# Locales
I18n::Backend::Simple.send(:include, I18n::Backend::Fallbacks)
I18n.load_path = Dir[File.join('./config/locales/*.yml')]
I18n.backend.load_translations
I18n.config.available_locales = ["ru", "en"]
I18n.config.default_locale = 'ru'
I18n.config.locale = 'ru'

require './autoload'

module MrParser

  # Base App
  class App < Sinatra::Application
    # use ActiveRecord::ConnectionAdapters::ConnectionManagement
    # use Rack::Cache, verbose: true, metastore: CACHE, entitystore: CACHE

    configure do
      set :database, lambda {
        ENV['DATABASE_URL'] ||
            "postgres://localhost:5432/mr_parser_#{environment}"
      }
    end

    configure :development, :staging do
      database.loggers << Logger.new(STDOUT)
    end

    configure do
      set :root, File.expand_path('../', __FILE__)
      set :views, 'app/views'

      set :erb, escape_html: true

      set :sessions,
          httponly: true,
          secure: production?,
          expire_after: 5.years,
          secret: ENV["SECRET_TOKEN"]

      disable :method_override, :protection, :static
    end

    use Rack::Deflater
    # use Rack::CSRF
    use Rack::Standards

    if settings.development?
      use Routes::Static
    end

    unless settings.production?
      use Routes::Assets
    end

    use Routes::Posts
    use Routes::Admin
  end
end

include MrParser::Models