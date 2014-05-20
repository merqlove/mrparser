module MrParser
  module Routes
    class Base < Sinatra::Application
      use Rack::Session::Cookie, :secret => "zvdL#PFeamVaLFWZ4cWAoDAtT.J9iD"
      use Rack::Flash

      configure do
        set :views, App.views
        set :root, App.root

        set :erb, escape_html: true
                  # layout_options: {views: "#{App.views}/layouts"}

        set :protect_from_csrf, false
        set :report_csrf_failure, false
        set :allow_disabled_csrf, false

        set :sessions, App.sessions

        disable :method_override, :protection, :static
        enable :sessions, :inline_templates, :use_code
      end

      configure :development, :production do
        enable :logging, :dump_errors, :run
      end

      configure :test do
        enable :method_override, :raise_errors
        disable :run, :dump_errors, :logging
      end

      register Padrino::Helpers
      register Padrino::Rendering
      # register Padrino::Mailer
      # register Sinatra::RespondTo

      register Extensions::Assets
      helpers Helpers
      helpers Sinatra::ContentFor

      register Sinatra::Reloader if settings.development?
    end
  end
end