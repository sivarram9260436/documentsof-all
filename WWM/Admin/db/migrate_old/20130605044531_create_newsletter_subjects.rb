class CreateNewsletterSubjects < ActiveRecord::Migration
  def change
    create_table :newsletter_subjects do |t|
      t.string :subject
      t.datetime :date
      t.integer :newsletter_id
      t.timestamps
    end
  end
end

