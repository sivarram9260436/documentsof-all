class DirectoryListingCategoriesServices < ActiveRecord::Migration
  def up
    create_table :directory_listing_categories_services, :id => false do |t|
      t.integer :directory_listing_category_id
      t.integer :service_id
    end
  end

  def down
     drop_table :directory_listing_categories_services
  end
end
