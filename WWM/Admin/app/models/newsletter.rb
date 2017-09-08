class Newsletter < ActiveRecord::Base
 has_many :newsletter_subjects 
 has_many :newsletter_parses
has_many :newsletter_registerations
has_and_belongs_to_many :subscribers

   scope :by_site,lambda {|site_id| 
     data_proxy_id =   Site.find(site_id).data_proxy_id
     {:conditions => "data_proxy_id=#{data_proxy_id}" }}
  # scope :by_active,:conditions=>["status =1"]

 def can_we_send_automation_mail?
   self.newsletter_schedules.by_date(Time.now).by_cancel_type.blank?
 end

 def verify_today_suject_presence?
   !self.newsletter_subjects.by_date(Time.now).blank?
 end

 def get_today_newsletter_subject
  self.newsletter_subjects.by_date(Time.now).last.subject if self.newsletter_subjects and !self.newsletter_subjects.by_date(Time.now).blank?
 end

 def newsletter_preview_template(value,site,type='path')
    newsletter_parse = self.newsletter_parses.by_value(value).first if value and self.newsletter_parses.by_value(value)
    if not newsletter_parse.blank?
      path = "#{Rails.root}/public/NEWSLETTER/#{newsletter_parse.created_at.strftime('%d%m%Y')}/#{newsletter_parse.id}"
      if File.exists?("#{path}/newsletter.html")
         type=='url' ? (return "http://#{site.name}/NEWSLETTER/#{newsletter_parse.folder_name}/#{newsletter_parse.id}/newsletter.html") : (return true,"#{path}/newsletter.html")
      else
         return false,nil
      end    
    else
       return false,nil
    end
  end

   def subject(site)
    self.verify_today_suject_presence? ? (self.get_today_newsletter_subject) : (site.generate_newsletter_subject(self,""))
  end

def save_newsletter_html(site,body)
      newsletter_parse = self.newsletter_parses.new()
      if newsletter_parse.save
        path = "#{Rails.root}/public/NEWSLETTER/#{newsletter_parse.created_at.strftime('%d%m%Y')}/#{newsletter_parse.id}"
        FileUtils.mkdir_p path,:mode => 0777
        if File.directory?("#{Rails.root}/public/NEWSLETTER/#{newsletter_parse.created_at.strftime('%d%m%Y')}/#{newsletter_parse.id}")
           newsletter_parse.update_attributes(:path=>"/NEWSLETTER/#{newsletter_parse.created_at.strftime('%d%m%Y')}/#{newsletter_parse.id}/newsletter.html",:date=>(Time.zone.now.to_date),:folder_name=>newsletter_parse.created_at.strftime('%d%m%Y'))
           File.open("#{path}/newsletter.html", "wb") { |file|
           file.write(body)
           }
         # `wget -O "#{path}/newsletter.html" --convert-links -erobots=off  http://#{site.name}/newsletter/#{self.name}`
          @@file_path = "#{path}/newsletter.html"
        end
        FileUtils.chmod 0777, @@file_path
      end
end

def html_body(site,type)
    if type == 'test'
    uri = URI("http://localhost/newsletter/#{self.name}")
    else
    uri = URI("http://localhost/newsletter/#{self.name}?mailchimp=true")
    end
    http=Net::HTTP.start(uri.host, uri.port)
    request = Net::HTTP::Get.new uri.request_uri
    request['Host']=site.name
    response = http.request request
    save_newsletter_html(site,response.body)
    return (response.kind_of? Net::HTTPSuccess),response.body
end

def generate_report(from_date, to_date)
   debugger
    from_date_errored=''
    to_date_errored=''
    begin from_date.to_time rescue from_date_errored='error' end
    begin to_date.to_time rescue to_date_errored='error' end
    name = self.name.gsub(/<\/?[^>]*>|&nbsp;|\r|\n/," ")  if self.name
    news_registrations=[]
    registers=self.newsletter_registerations.where("created_at >= '#{from_date}' and created_at <= '#{to_date}'").order("created_at DESC")
    news_registrations += get_newsletter_reports(registers)
    
    from_date = from_date.blank? ? '""' : (from_date_errored.eql?('error') ? 'Invalid date formate' : from_date.to_date.strftime('%b %d, %Y'))
    to_date = to_date.blank? ? '""' : (to_date_errored.eql?('error') ? 'Invalid date formate' : to_date.to_date.strftime('%b %d, %Y'))
    @csv_string = CSV.generate{ |csv|  csv  <<  ['', name] << ['', 'From = ' + from_date] << ['', 'To = ' + to_date] }
   # @question_header = [' Registration ID ']+ ['Name','Company Name','Job Designation','Email Id', 'Date and Time']
     @question_header = ['Name','Company Name','Job Designation','Email Id', 'Date and Time']
    @csv_string << CSV.generate{|csv|  csv <<  @question_header}
    news_registrations.each{ |prop| @csv_string << CSV.generate{ |csv| csv << prop } }
    @csv_string
  end
  
 def get_newsletter_reports(news_registers)
    @news_registrations=[]
    news_registers.each do |reg|
    @dup=[]
    @dup << reg.first_name
    @dup << reg.company_name
    @dup << reg.job_title
    @dup << reg.email_id
    @dup << reg.created_at.strftime("%d-%b-%Y %r") if !reg.created_at.blank?
    @news_registrations<<@dup
    end
    return @news_registrations
  end

end
