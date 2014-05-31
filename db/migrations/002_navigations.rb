Sequel.migration do
  up do
    create_table(:navigations) do
      primary_key :id
      column :title, "text"
      column :slug, "text"
      column :parent_id, "integer"
      column :enabled, "boolean"
      column :position, "integer"
      column :created_at, "timestamp without time zone"
      column :updated_at, "timestamp without time zone"

      index [:parent_id]
    end

  end

  down do
    drop_table :navigations, cascade: true
  end
end