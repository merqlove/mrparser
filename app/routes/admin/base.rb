module MrParser
  module Routes
    class Admin::Base < Base
      configure do
        set :views, "#{App.views}/admin"
        set :erb, layout: :admin
      end
    end
  end
end
