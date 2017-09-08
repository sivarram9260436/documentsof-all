class CreateNewsletterParses < ActiveRecord::Migration
  def change
    create_table :newsletter_parses do |t|
      t.integer :newsletter_id
      t.string :path
      t.string :date
       t.string :folder_name
      t.timestamps
    end
  end
end

