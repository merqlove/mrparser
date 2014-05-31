module MrParser
  module Models
    class Navigation < Sequel::Model
      plugin :tree, key: :parent_id, order: :position

      one_to_one :navigation_pages, on_delete: :cascade
      one_through_one :page,
                      join_table: :navigation_pages,
                      class: "MrParser::Models::Page",
                      left_key: :navigation_id,
                      right_key: :page_id
    end
  end
end
