class NewsletterParse < ActiveRecord::Base
  belongs_to :newsletter
  scope :by_date, lambda {|date| { :conditions => ['date >= ? and date < ?',date.to_date,date.to_date + 1.day]}}
  scope :latest,:order => 'newsletter_parses.created_at desc'
  scope :by_value , lambda {|value| { :conditions => ['folder_name =?',value]}}
 end
