class AddPageIdToMenu < ActiveRecord::Migration
  def change
    add_column :menus, :page_id, :integer
  end
end
