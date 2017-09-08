require 'ruby-debug'
require 'csv'
require 'date'
class SubscriberExportCsvGeneration

    def self.rae_export(site,subscribers,options={})
    Rails.logger.info "Diff time==========================site_download========"
    start_time = Time.now
    fields  =  ["\"User Id\"","\"First Name\"","\"Last Name\"","\"Email \"","\"Job Title \"","\"Company \""]
     File.open("#{Rails.root}/public/rae_export/rae_export.csv", "w+" ) do |the_file|
           the_file.puts fields.join(',')+"\n"
     end
     subscribers.each do |a|
     subscriber_property = a.subscriber_property
        columns = ["#{a.id}","#{a.first_name}","#{a.last_name}","#{a.email_id}","#{a.subscriber_property.Job_title unless subscriber_property.blank?}","#{a.subscriber_property.end_user_company_name unless subscriber_property.blank?}"].to_csv
       File.open("#{Rails.root}/public/rae_export/rae_export.csv", "a+" ) do |the_file|
         the_file.puts columns
       end
     end
    end_time = Time.now
    Rails.logger.info "Diff time===========================#{end_time - start_time}========="
    puts "Diff time===========================#{end_time - start_time}========="
    end

    def self.rae_newsletter_export(site,subscribers,options={})
     Rails.logger.info "Diff time==========================site_download========"
     start_time = Time.now
    fields  =  ["\"UserName\"","\"NewsEmailId \""]
     File.open("#{Rails.root}/public/rae_export/rae_newsletter_export.csv", "w+" ) do |the_file|
       the_file.puts fields.join(',')+"\n"
    end
   subscribers.each do |a|
     columns = ["#{a.user_name}","#{a.news_email_id}"].to_csv
     File.open("#{Rails.root}/public/rae_export/rae_newsletter_export.csv", "a+" ) do |the_file|
      the_file.puts columns
     end
   end
    end_time = Time.now
    Rails.logger.info "Diff time===========================#{end_time - start_time}========="
    puts "Diff time===========================#{end_time - start_time}========="
  end

end
