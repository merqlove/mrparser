# require 'lib/sanitize/config/liberal'

module MrParser
  module Models
    class Page < Sequel::Model
      # Scopes
      dataset_module do
        def all_data
          order(:id)
        end
      end

      one_to_many :navigation_pages, on_delete: :cascade

      # Relationships
      one_through_one :navigation,
                      join_table: :navigation_pages,
                      class: "MrParser::Models::Navigation",
                      left_key: :page_id,
                      right_key: :navigation_id,
                      on_delete: :cascade

      one_to_many :blocks,
                  class: "MrParser::Models::PageBlock",
                  on_delete: :cascade
    end
  end
end