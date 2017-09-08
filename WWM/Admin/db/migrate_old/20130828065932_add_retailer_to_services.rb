class AddRetailerToServices < ActiveRecord::Migration
  def change
    add_column :services, :retailer, :string
    add_column :services, :more_info, :string
    add_column :services, :price, :string
    add_column :services, :made_by, :string
    add_column :services, :active, :boolean
  end
end
