module MrParser
  module Routes
    class Admin < Base
      configure do
        set :views, "#{App.views}/admin"
        set :erb, layout: :admin
      end
      get '/admin/' do
        erb :index
      end
    end
  end
end
