class AddColumnToSite < ActiveRecord::Migration
  def change
    add_column :sites,:display_name,:string
  end
end
