module MrParser
  module Routes
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
