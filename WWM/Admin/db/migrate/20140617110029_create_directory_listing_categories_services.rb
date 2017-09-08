class CreateDirectoryListingCategoriesServices < ActiveRecord::Migration
  def self.change
    create_table :directory_listing_categories_services,:id => false, :force => true do |t|
      t.integer :directory_listing_category_id
      t.integer :service_id
    end
  end
 def self.down
         drop_table :directory_listing_categories_services
       end
end
