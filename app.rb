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
  class App < Sinatra::Base
    # use ActiveRecord::ConnectionAdapters::ConnectionManagement
    # use Rack::Cache, verbose: true, metastore: CACHE, entitystore: CACHE

    configure do
      register Sinatra::SequelConnect
      set :db, db_connect(DB_CONFIG)
      db.loggers << Logger.new(STDOUT) if development? or test?
      db.extension(:pagination)
    end

    configure do
      set :root, File.expand_path('../', __FILE__)
      set :views, 'app/views'

      set :erb, engine_class: Erubis::HtmlSafe::EscapedEruby

      use Rack::Session::EncryptedCookie,
          key: ENV["SESSION_KEY"],
          httponly: true,
          secure: production?,
          expire_after: 5.years,
          secret: ENV["SECRET_TOKEN"],
          old_secret: ENV["OLD_SECRET_TOKEN"],
          header: 'X-CSRF-TOKEN'

      disable :method_override, :protection, :static
    end

    configure :production do
      Airbrake.configure do |config|
        config.api_key = ENV["AIRBRAKE_KEY"]
        config.host    = ENV["AIRBRAKE_HOST"]
        config.port    = ENV["AIRBRAKE_PORT"]
        config.secure  = config.port == 443
      end
      use Airbrake::Sinatra
    end

    use Rack::Deflater
    use Rack::Standards

    register Sinatra::Mount

    if settings.development?
      use Controllers::Static
    end

    unless settings.production?
      use Controllers::Assets
    end

    use Controllers::Pages

    mount Controllers::Admin::Pages, '/admin'
  end
end

include MrParser::Models
include MrParser::Mailers
