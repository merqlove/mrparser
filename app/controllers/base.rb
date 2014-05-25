module MrParser
  module Controllers
    class Base < Sinatra::Base
      use Rack::Flash

      register Padrino::Mailer

      mailer :base do
        email :feedback do |name, email|
          subject 'Hello Man!'
          to      "#{name}<#{email}>"
          from    ENV["MAIL_FROM"]
          locals  :name => name, :mail => email
          # body "This is test!"
          body erb :"test.html"
          content_type :html
        end
      end

      not_found do
        status 404
        erb :"404"
      end

      configure do
        # set :layout, :application
        set :views, App.views
        set :root, App.root
        set :default_content, :html

        set :captcha_ajax_template, "captcha/captcha_ajax"
        set :captcha_template, "captcha/captcha"
        set :captcha_url, "/get_captcha"

        set :erb, escape_html: true,
                  layout: :application,
                  layout_options: {views: "#{App.views}/layouts"}

        set :sessions, App.sessions

        disable :static
        enable :inline_templates, :use_code, :protection

        set :show_exceptions, :after_handler
      end

      configure :development, :production do
        set :delivery_method, :smtp => {
            :address              => ENV["SMTP_PATH"],
            :port                 => ENV["SMTP_PORT"].to_i,
            :user_name            => ENV["SMTP_USER"],
            :password             => ENV["SMTP_PASSWORD"],
            :authentication       => (ENV["SMTP_AUTH"].to_sym if ENV["SMTP_AUTH"].present?),
            :enable_starttls_auto => ENV["SMTP_TLS"] == "true"
        }

        disable :method_override
        enable :logging, :dump_errors, :run
      end

      configure :test do
        set :delivery_method, :test

        enable :method_override, :raise_errors
        disable :run, :dump_errors, :logging
      end

      use Rack::Csrf, raise: true, field: 'meta_csrf', key: ENV["SESSION_KEY"]
      helpers MrParser::Helpers::Security

      # register Padrino::Rendering
      register Sinatra::RespondTo
      register Mustermann

      register YandexCaptcha::Sinatra

      YandexCaptcha.configure do |config|
        config.api_key  = 'cw.1.1.20140304T123614Z.401fc35d3a97920b.5be1f73045dfacddf65b79cc82156c4552284211'
        config.captcha_type  = 'elite'
      end

      # register Extensions::Assets
      # register Helpers::Assets
      # helpers Helpers
      # helpers Padrino::Helpers::TranslationHelpers
      # helpers Padrino::Helpers::NumberHelpers
      helpers Padrino::Helpers::FormHelpers
      # helpers Padrino::Helpers::FormatHelpers
      # helpers Padrino::Helpers::OutputHelpers
      helpers Padrino::Helpers::AssetTagHelpers
      # helpers Sinatra::NamedRoutes::Helpers
      helpers Sinatra::ContentFor

      error Sequel::ValidationFailed do
        # env['sinatra.error'].errors
        status 406
        erb :"500"
      end

      error Sequel::Plugins::RaiseNotFound::ModelNotFound do
        status 404
        erb :"404"
      end

      error Sequel::NoMatchingRow do
        status 404
        erb :"404"
      end

      if settings.development?
        register Sinatra::Reloader
      end
    end
  end
end