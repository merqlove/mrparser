module MrParser
  module Routes
    class Posts < Base
      get '/' do
        erb :index
      end
    end
  end
end
