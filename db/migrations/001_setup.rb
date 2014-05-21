Sequel.migration do
  up do
    create_table(:pages) do
      primary_key :id
      column :title, "text"
      column :slug, "text"
      column :html_title, "text"
      column :created_at, "timestamp without time zone"
      column :updated_at, "timestamp without time zone"
      column :body, "text"
      column :summary, "text"
      column :published_at, "timestamp without time zone"

      index [:published_at]
      index [:slug], :unique=>true
    end

    create_table(:page_blocks) do
      primary_key :id
      foreign_key :page_id, :pages, :type=>"integer", key: :id
      column :body, "text"
      column :created_at, "timestamp without time zone"
      column :updated_at, "timestamp without time zone"

      index [:page_id]
    end
  end

  down do
    drop_table :pages, :page_blocks, :cascade => true
  end
end