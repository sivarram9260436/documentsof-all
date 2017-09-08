require 'uuid_migration_helper'

class UuidMigration < ActiveRecord::Migration
  def change
    reversible do |dir|
      dir.up do
        enable_extension 'uuid-ossp'

        primary_key_to_uuid :webdackimage_root_images
        Dir.glob("#{Webdackimage.base_path}*/*").select{|d| File.basename(d) =~ /^\d+$/}.each do |d|
          File.rename d, File.dirname(d) + '/' + int_to_uuid(File.basename(d))
        end

        primary_key_to_uuid :webdackimage_images
        columns_to_uuid :webdackimage_images, :root_image_id, :used_by_id

        primary_key_to_uuid :webdackimage_gallery_images
        columns_to_uuid :webdackimage_gallery_images, :gallery_id, :image_id

        primary_key_to_uuid :webdackimage_galleries
        columns_to_uuid :webdackimage_galleries, :_title_image_id
      end

      dir.down do
#        raise ActiveRecord::IrreversibleMigration
      end
    end
  end
end
