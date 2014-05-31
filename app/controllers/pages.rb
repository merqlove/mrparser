module MrParser
  module Controllers
    class Pages < Base
      get '/' do
        BaseMailer.feedback!("<p>Text</p>", "bob@bobby.com", "Bob")
        erb :index
      end
      get '/threads' do
        erb :threads
      end
      get '/slim' do
        # settings.threads << Thread.new do
        #   Sequel::Model.db.run "select pg_sleep(10);"
        #   # ActiveRecord::Base.connection_pool.with_connection 'select pg_sleep(1)'
        # end
        @pages = Page.all
        slim :index
      end
      post '/form' do
        erb YandexCaptcha::Verify.valid_captcha?(params[:captcha_response_id], params[:captcha_response_field]).to_s
      end
    end
  end
end
