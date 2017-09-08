class CreateWebdackimageImages < ActiveRecord::Migration
  def change
    create_table :webdackimage_images do |t|
      t.references :root_image

      t.boolean :has_roi, :default => false
      t.integer :roi_x
      t.integer :roi_y
      t.integer :roi_w
      t.integer :roi_h

      t.string :crop_mode
      t.string :fill_color

      t.integer :used_by_id
      t.string :used_by_type
      t.string :purpose
      t.integer :site_id

      t.integer :version, :default => 0

      t.string :title
      t.string :alt_text
      t.string :display_preference

      t.boolean :status


      t.integer  :created_by
      t.integer  :updated_by
      t.timestamps
    end

    add_index :webdackimage_images, :root_image_id
    add_index :webdackimage_images, :used_by_id
  end
end
