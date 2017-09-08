class CreateWebdackimageGalleries < ActiveRecord::Migration
  def change
    create_table :webdackimage_galleries do |t|
      t.string   :name
      t.string   :description
      t.integer  :data_proxy_id
      t.string   :tag
      t.boolean  :toon_gallery

      t.date     :publish_date
      t.boolean  :in_embargo
      t.boolean  :status
      t.boolean  :archive

      t.references :_title_image

      t.integer  :created_by
      t.integer  :updated_by
      t.timestamps
    end
  end
end
