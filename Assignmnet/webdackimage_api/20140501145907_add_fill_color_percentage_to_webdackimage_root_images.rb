class AddFillColorPercentageToWebdackimageRootImages < ActiveRecord::Migration
  def change
    add_column :webdackimage_root_images, :fill_color_percentage, :integer
  end
end
