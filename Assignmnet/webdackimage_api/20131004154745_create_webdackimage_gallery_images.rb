class CreateWebdackimageGalleryImages < ActiveRecord::Migration
  def change
    create_table :webdackimage_gallery_images do |t|
      t.string :caption
      t.text :description
      t.references :gallery
      t.references :image
      t.integer :position

      t.integer  :created_by
      t.integer  :updated_by
      t.timestamps
    end
    add_index :webdackimage_gallery_images, [:gallery_id, :position]
    add_index :webdackimage_gallery_images, :image_id
  end
end
