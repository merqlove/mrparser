module MrParser
  module Models
    class PageBlock < Sequel::Model
      many_to_one :page
    end
  end
end
