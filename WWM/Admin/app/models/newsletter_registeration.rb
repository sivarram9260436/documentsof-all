class NewsletterRegisteration < ActiveRecord::Base
  belongs_to :newsletter
  belongs_to :site
  
  scope :by_site,lambda { |site_id|
   data_proxy_id =   Site.find(site_id).data_proxy_id
   {:conditions => "data_proxy_id=#{data_proxy_id}" }}

  scope :order_by,lambda {|by| {:order=>by}}

 # validate :newsletter_validation
    def newsletter_validation
     errors[:base] << ("Email should not be blank") if self.email_id.blank?
     errors[:base] << ("Email has already been taken") if not NewsletterRegisteration.where("UPPER(email_id) = UPPER(?)", self.email_id.upcase.strip).blank? and  not self.email_id.blank?
     errors[:base] << ("Email is invalid") if /^([a-zA-Z0-9_.'-])+@(([a-zA-Z0-9-])+.)+([a-zA-Z0-9]{2,4})+$/.match(self.email_id.strip.to_s).blank? and not self.email_id.blank?
  end

  


  def self.search(search_datas={})
    method_mappings={
        :order_by => :order_by
    }
    results = NewsletterRegisteration.by_site(search_datas[:site_id])
    search_datas.each do |key, value|
      if !value.blank? and key.to_s!="site_id"
        if ["company_name", "job_title"].include? key.to_s
          results = results.keyword_search("#{key}" => "%%"+value+"%%")
        elsif ["start_date", "end_date"].include? key.to_s
          results = results.where("created_at >= ?", value.to_datetime.to_s ) if key.to_s == "start_date" rescue nil
          results = results.where("created_at <= ?", value.to_datetime.to_s ) if key.to_s == "end_date" rescue nil
        elsif ["email_id", "status"].include? key.to_s
          results = results.where("#{key} = ?", value) if key == "status"
          results = results.keyword_search("#{key}" => "%%"+value+"%%") if key == "email_id" rescue nil
        else
          method_name= method_mappings[key.to_sym]
          results= results.send(method_name, value)
        end
      end
    end
    return results
  end
  

  def old_search(status,start_date,end_date,email_id,company_name,job_title)
     start_date = start_date.to_datetime
     end_date = end_date.to_datetime
     if !start_date.blank? and !end_date.blank?
        if status == "Active"
          @registers = NewsletterRegisteration.where("created_at >= '#{start_date}' and created_at <= '#{end_date}' and status = 'Active'").order("created_at DESC")
        elsif status == "InActive"
          @registers = NewsletterRegisteration.where("created_at >= '#{start_date}' and created_at <= '#{end_date}' and status = 'InActive'").order("created_at DESC")
        else
           @registers = NewsletterRegisteration.where("created_at >= '#{start_date}' and created_at <= '#{end_date}'").order("created_at DESC")       
        end
     end
         
       if company_name.present? 
         @registers = NewsletterRegisteration.where(:company_name=>company_name)
       end

       @registers =  NewsletterRegisteration.where(:email_id=>email_id) if email_id.present?
       @registers = NewsletterRegisteration.where(:job_title=>job_title) if job_title.present?

     return @registers     
  end

 def old_generate_report(start_date, end_date,status,company_name,email_id,job_title)
     start_date = start_date.to_datetime 
     end_date = end_date.to_datetime
     news_registrations=[]
       if status == "Active"
         @subscriber_header = ['Name','Company Name','Job Designation','Email Id','Status' ,'Date and Time']
         registers = self.where("created_at >= '#{start_date}' and created_at <= '#{end_date}' and status = 'Active'").order("created_at DESC")
        elsif status == "InActive"
         @subscriber_header = ['Name','Company Name','Job Designation','Email Id','Status','Unsubscribe Reasion','Unsubscribe date','Date and Time']
         registers = self.where("created_at >= '#{start_date}' and created_at <= '#{end_date}' and status = 'InActive'").order("created_at DESC")
        else
         @subscriber_header = ['Name','Company Name','Job Designation','Email Id','Status','Date and Time']
         registers = self.where("created_at >= '#{start_date}' and created_at <= '#{end_date}'").order("created_at DESC")
        end

       if company_name.present?
          registers = registers.where(:end_user_company_name=>company_name)
       end

       registers = registers.where(:email_id => email_id) if email_id.present?
       registers = registers.where(:job_title => job_title) if job_title.present?

    news_registrations += get_subscriber_reports(registers,status)
    @csv_report = CSV.generate{|csv|  csv <<  @subscriber_header}
    news_registrations.each{ |prop| @csv_report << CSV.generate{ |csv| csv << prop } }
    @csv_report

 end

  def self.generate_report(search_datas={})
   news_registrations=[]
   if search_datas[:status] == "InActive"
      @subscriber_header = ['Name','Company Name','Job Designation','Email Id','Status','Unsubscribe Reasion','Unsubscribe date','Date and Time']
   else
     @subscriber_header = ['Name','Company Name','Job Designation','Email Id','Status' ,'Date and Time']
   end
   method_mappings={
        :order_by => :order_by
    }
    results = NewsletterRegisteration.by_site(search_datas[:site_id])
    search_datas.each do |key, value|
      if !value.blank? and key.to_s!="site_id"
        if ["company_name", "job_title"].include? key.to_s
          results = results.keyword_search("#{key}" => "%%"+value+"%%")
        elsif ["start_date", "end_date"].include? key.to_s
          results = results.where("created_at >= ?", value.to_datetime.to_s ) if key.to_s == "start_date" rescue nil
          results = results.where("created_at <= ?", value.to_datetime.to_s ) if key.to_s == "end_date" rescue nil
        elsif ["email_id", "status"].include? key.to_s
          results = results.where("#{key} = ?", value) if key == "status"
          results = results.keyword_search("#{key}" => "%%"+value+"%%") if key == "email_id" rescue nil
        else
          method_name= method_mappings[key.to_sym]
          results= results.send(method_name, value)
        end
      end 
    end
    news_registrations += get_subscriber_reports(results,search_datas[:status])
    @csv_report = CSV.generate{|csv|  csv <<  @subscriber_header}
    news_registrations.each{ |prop| @csv_report << CSV.generate{ |csv| csv << prop } }
    @csv_report

  end


  def self.get_subscriber_reports(news_registers,status)
    @news_registrations=[]
    news_registers.each do |reg|
    @dup=[]
    if status == "Active" or status == ""
   	 @dup << reg.first_name
    	@dup << reg.company_name
    	@dup << reg.job_title
    	@dup << reg.email_id
    	@dup << reg.status
    	@dup << reg.created_at.strftime("%d-%b-%Y %r") if !reg.created_at.blank?
    	@news_registrations<<@dup
    else
        @dup << reg.first_name
        @dup << reg.company_name
        @dup << reg.job_title
        @dup << reg.email_id
        @dup << reg.status
        @dup << reg.unsubscribe_reasion
        @dup << reg.unsubscribe_date.strftime("%d-%b-%Y %r") if !reg.unsubscribe_date.blank?
        @dup << reg.created_at.strftime("%d-%b-%Y %r") if !reg.created_at.blank?
        @news_registrations<<@dup
     end
    end
    return @news_registrations
  end

end
