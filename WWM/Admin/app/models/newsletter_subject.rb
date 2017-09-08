 class NewsletterSubject < ActiveRecord::Base
 belongs_to :newsletter
 scope :by_date, lambda {|date| { :conditions => ['date >= ? and date < ?',date.to_date,date.to_date + 1.day]}}
end


