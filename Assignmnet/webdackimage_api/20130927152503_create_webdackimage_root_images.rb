class CreateWebdackimageRootImages < ActiveRecord::Migration
  def change
    create_table :webdackimage_root_images do |t|
      t.string :name
      t.string :folder
      t.integer :width
      t.integer :height
      t.integer :file_size

      t.boolean :license_restricted, :default => true
      t.string :license_remarks
      t.boolean :is_license_cc, :default => false
      t.boolean :license_cc_allow_modifications
      t.boolean :license_cc_allow_modifications_with_share_alike
      t.boolean :license_cc_allow_commercial

      t.boolean :has_computed_roi, :default => false
      t.integer :computed_roi_x
      t.integer :computed_roi_y
      t.integer :computed_roi_w
      t.integer :computed_roi_h

      t.string :fill_color_i

      t.integer :version, :default => 0

      t.string :tag
      t.boolean :status
      t.integer :site_id

      t.integer  :created_by
      t.integer  :updated_by
      t.timestamps
    end
  end
end
