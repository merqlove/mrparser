module MrParser
  module Controllers
    class Admin::Pages < Admin::Base
      # before {}
      #
      # get '/admin/?' do
      #   erb :index
      # end
      #
      # get '/admin/pages/?' do
      #   @pages = Page.dataset.paginate(1,2).eager(:blocks).all
      #   raise Sequel::NoMatchingRow if @pages.nil?
      #   erb :"pages/index"
      # end
      #
      #
      # get '/admin/pages/:id/edit' do
      #   @page = Page.find! params[:id]
      #   erb :"pages/edit"
      # end
      get '/' do
        erb :index
      end

      get '/test_form' do
        erb :"test_form"
      end

      post '/test_respond' do
        erb YandexCaptcha::Verify.valid_captcha?(params[:captcha_response_id], params[:captcha_response_field]).to_s
      end

      get '/pages/?' do
        @pages = Page.dataset.paginate(1,2).eager(:blocks).all
        raise Sequel::NoMatchingRow if @pages.nil?
        erb :"pages/index"
      end


      get '/pages/:id/edit' do
        @page = Page.find! params[:id]
        erb :"pages/edit"
      end

    end
  end
end
