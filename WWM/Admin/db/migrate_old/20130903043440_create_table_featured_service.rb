class CreateTableFeaturedService < ActiveRecord::Migration
  def self.up
    create_table :featured_services do |t|
      t.column :entity_id,       :integer
      t.column :sequence_number,    :integer  
      t.column :created_by,                :integer
      t.column :updated_by,                :integer           
      t.column :created_at,                :timestamp
      t.column :updated_at,                :timestamp
      t.column :featured_set_id,  :integer
       t.column :entity_type,       :string
    end
    add_index :featured_services, :entity_id
    add_index :featured_services, :sequence_number
  end
  
  def self.down
     remove_index :featured_services, :entity_id
     remove_index :featured_services, :sequence_number
    drop_table :featured_services
  end
end
