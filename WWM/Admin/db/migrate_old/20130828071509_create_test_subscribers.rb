class CreateTestSubscribers < ActiveRecord::Migration
  def change
    create_table :test_subscribers do |t|
      t.string  :email_id
      t.integer :newsletter_id

      t.timestamps
    end
  end
end
