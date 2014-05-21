Sequel.migration do
  change do
    create_table(:pages, :ignore_index_errors=>true) do
      primary_key :id
      String :title, :text=>true
      String :slug, :text=>true
      String :html_title, :text=>true
      DateTime :created_at
      DateTime :updated_at
      String :body, :text=>true
      String :summary, :text=>true
      DateTime :published_at
      
      index [:published_at]
      index [:slug], :unique=>true
    end
    
    create_table(:schema_info) do
      Integer :version, :default=>0, :null=>false
    end
    
    create_table(:page_blocks, :ignore_index_errors=>true) do
      primary_key :id
      foreign_key :page_id, :pages, :key=>[:id]
      String :body, :text=>true
      DateTime :created_at
      DateTime :updated_at
      
      index [:page_id]
    end
  end
end
