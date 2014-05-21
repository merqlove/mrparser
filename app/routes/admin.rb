module MrParser
  module Routes
    class Admin < Base
      configure do
        set :views, "#{App.views}/admin"
        set :erb, layout: :admin
      end
      get '/admin/?' do
        @pages = Page[2]#.eager(:blocks).all
        raise Sequel::NoMatchingRow if @pages.nil?
        erb :index
      end
    end
  end
end
