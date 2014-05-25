module MrParser
  module Routes
    class Pages < Base
      get '/' do
        # Base.deliver(:base, :feedback, "Bob", "bob@bobby.com")
        erb :index
      end
      post '/form' do
        erb YandexCaptcha::Verify.valid_captcha?(params[:captcha_response_id], params[:captcha_response_field]).to_s
      end
    end
  end
end
