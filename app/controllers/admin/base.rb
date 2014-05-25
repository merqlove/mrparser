module MrParser
  module Controllers
    class Admin::Base < Base
      configure do
        set :views, "#{App.views}/admin"
        set :erb, layout: :admin
        set :captcha_ajax_template, "../captcha/captcha_ajax"
        set :captcha_template, "../captcha/captcha"
      end

      # use Rack::Cors do
      #   allow do
      #     origins '*'
      #     resource '*', headers: :any, methods: [:get, :post, :options]
      #   end
      # end
    end
  end
end
