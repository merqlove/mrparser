module MrParser
  module Routes
    class Base < Sinatra::Application
      use Rack::Flash

      not_found do
        "dsggssg"
      end

      configure do
        set :layout, :application
        set :views, App.views
        set :root, App.root
        # set :default_content, :html

        set :erb, escape_html: true,
                  layout: :application,
                  layout_options: {views: "#{App.views}/layouts"}

        set :protect_from_csrf, false
        set :report_csrf_failure, false
        set :allow_disabled_csrf, false

        set :sessions, App.sessions

        disable :protection, :static
        enable :inline_templates, :use_code

        set :show_exceptions, :after_handler
      end

      configure :development, :production do
        disable :method_override
        enable :logging, :dump_errors, :run
      end

      configure :test do
        enable :method_override, :raise_errors
        disable :run, :dump_errors, :logging
      end

      # register Padrino::Rendering
      # register Padrino::Mailer
      register Sinatra::RespondTo

      # register Extensions::Assets
      # register Helpers::Assets
      # helpers Helpers
      # helpers Padrino::Helpers::TranslationHelpers
      # helpers Padrino::Helpers::NumberHelpers
      # helpers Padrino::Helpers::FormHelpers
      # helpers Padrino::Helpers::FormatHelpers
      # helpers Padrino::Helpers::TagHelpers
      # helpers Padrino::Helpers::OutputHelpers
      helpers Padrino::Helpers::AssetTagHelpers
      helpers Sinatra::ContentFor

      error Sequel::ValidationFailed do
        status 406
        json error: {
            type: 'validation_failed',
            messages: env['sinatra.error'].errors
        }
      end

      error Sequel::NoMatchingRow do
        status 404
        content_type :json
        {type: 'unknown_record'}.to_json
      end

      if settings.development?
        register Sinatra::Reloader
      end
    end
  end
end