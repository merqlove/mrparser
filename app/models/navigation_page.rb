module MrParser
  module Models
    class NavigationPage < Sequel::Model
      one_to_one :navigation
      one_to_one :page
    end
  end
end
