module MrParser
  module Routes
    class Posts < Base
      get '/' do
        # erb :index
        render :index, layout_engine: :erb, layout: "layout"
      end
    end
  end
end