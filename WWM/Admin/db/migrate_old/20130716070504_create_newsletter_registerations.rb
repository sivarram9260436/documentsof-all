class CreateNewsletterRegisterations < ActiveRecord::Migration
  def self.change
    create_table :newsletter_registerations do |t|
      t.integer :newsletter_id
      t.integer :site_id
      t.string :email_id
      t.string :first_name
      t.string :last_name
      t.integer :subscriber_id
      t.string :old_email_id
      t.timestamps
    end
  end
end
