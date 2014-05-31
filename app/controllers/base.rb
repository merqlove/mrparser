module MrParser
  module Controllers
    class Base < Sinatra::Base
      use Rack::Flash

      register Sinatra::CustomRender

      not_found do
        status 404
        erb :"404"
      end

      before do
        # case env["SERVER_NAME"]
        #   when /test\./
        #     App.db.search_path = [:test, :public]
        #   when /test2\./
        #     App.db.search_path = [:test2, :public]
        #   else
        #     App.db.search_path = [:public]
        # end
      end

      configure do
        set :views, App.views
        set :root, App.root
        set :threaded, true
        set :threads, []

        set :captcha_ajax_template, "captcha/captcha_ajax"
        set :captcha_template, "captcha/captcha"
        set :captcha_url, "/get_captcha"

        set :erb, engine_class: Erubis::HtmlSafe::EscapedEruby,
                  layout: :application,
                  layout_options: {views: "#{App.views}/layouts"}

        set :slim, # generator: Temple::Generators::RailsOutputBuffer,
                   # buffer: "@_out_buf",
                   # disable_capture: true,
                   # format: :html5,
                   use_html_safe: true,
                   layout: :application,
                   layout_options: {views: "#{App.views}/layouts"}

        # Tilt.register Tilt::HtmlSafe::SafeErubisTemplate, :erb
        Tilt.register Tilt[:erb], "html.erb"
        Tilt.register Tilt[:erb], "js.erb"
        Tilt.register Tilt[:erb], "css.erb"

        # Tilt.register Slim::HtmlSafe::SlimTemplate, :slim
        Tilt.register Tilt[:slim], "html.slim"

        set :sessions, App.sessions

        disable :static
        enable :inline_templates, :use_code, :protection

        set :show_exceptions, :after_handler
      end

      configure :development, :production do
        Mail.defaults do
          delivery_method :smtp, {
              address:              ENV["SMTP_PATH"],
              port:                 ENV["SMTP_PORT"].to_i,
              user_name:            ENV["SMTP_USER"],
              password:             ENV["SMTP_PASSWORD"],
              authentication:       (ENV["SMTP_AUTH"].to_sym if ENV["SMTP_AUTH"].present?),
              enable_starttls_auto: ENV["SMTP_TLS"] == "true"
          }
        end
        set :protect_from_csrf, true

        disable :method_override
        enable :logging, :dump_errors, :run
      end

      configure :test do
        Mail.defaults { delivery_method :test }

        enable :method_override, :raise_errors
        disable :run, :dump_errors, :logging
      end

      use Rack::Csrf, raise: true, field: 'csrf', key: ENV["SESSION_KEY"]

      # register Mustermann

      register YandexCaptcha::Sinatra

      YandexCaptcha.configure do |config|
        config.api_key  = 'cw.1.1.20140304T123614Z.401fc35d3a97920b.5be1f73045dfacddf65b79cc82156c4552284211'
        config.captcha_type  = 'elite'
      end

      # register Extensions::Assets
      # register Helpers::Assets
      # helpers Helpers
      # helpers Padrino::Helpers::NumberHelpers
      # helpers Padrino::Helpers::OutputHelpers
      helpers Padrino::Helpers::TranslationHelpers
      helpers Padrino::Helpers::TagHelpers
      helpers Padrino::Helpers::FormatHelpers
      helpers Padrino::Helpers::AssetTagHelpers
      helpers Padrino::Helpers::FormHelpers
      helpers Sinatra::Capture
      helpers Sinatra::ContentFor
      # helpers Sinatra::FormHelpers

      helpers MrParser::Helpers::Security
      helpers MrParser::Helpers::Output

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