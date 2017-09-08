class AddColumnSevrices < ActiveRecord::Migration
  def up
    add_column :services, :description, :string
    add_column :services, :sizes, :string
    add_column :services, :indications, :text
    add_column :services, :contraindications, :text
    add_column :services, :manufacturer, :string

  end

  def down
     remove_column :services, :description
    remove_column :services, :sizes
    remove_column :services, :indications
    remove_column :services, :contraindications
    remove_column :services, :manufacturer
  end
end
