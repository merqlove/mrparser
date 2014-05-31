Sequel.migration do
  up do
    create_table(:navigation_pages) do
      primary_key :id
      foreign_key :navigation_id, :navigations, type: "integer", key: :id
      foreign_key :page_id, :pages, type: "integer", key: :id
      column :created_at, "timestamp without time zone"
      column :updated_at, "timestamp without time zone"

      index [:navigation_id, :page_id], unique: true
      index [:navigation_id]
      index [:page_id]
    end
  end

  down do
    drop_table :navigation_pages, cascade: true
  end
end