module MrParser
  module Routes
    class Base < Sinatra::Application
      use Rack::Flash

      configure do
        set :layout, :application
        set :views, App.views
        set :root, App.root
        set :default_content, :html

        set :erb, escape_html: false,
                  layout: :application,
                  layout_options: {views: "#{App.views}/layouts"}

        set :protect_from_csrf, false
        set :report_csrf_failure, false
        set :allow_disabled_csrf, false

        set :sessions, App.sessions

        disable :protection, :static
        enable :inline_templates, :use_code
      end

      configure :development, :production do
        disable :method_override
        enable :logging, :dump_errors, :run
      end

      configure :test do
        enable :method_override, :raise_errors
        disable :run, :dump_errors, :logging
      end

      register Padrino::Helpers::TranslationHelpers
      register Padrino::Helpers::NumberHelpers
      register Padrino::Helpers::FormHelpers
      register Padrino::Helpers::FormatHelpers
      register Padrino::Helpers::TagHelpers
      register Padrino::Helpers::OutputHelpers
      # register Padrino::Helpers::AssetTagHelpers
      # register Padrino::Rendering
      register Padrino::Mailer
      register Sinatra::RespondTo

      register Extensions::Assets
      helpers Helpers
      helpers Sinatra::ContentFor

      if settings.development?
        register Sinatra::Reloader
      end
    end
  end
end