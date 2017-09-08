class Admin::NewsletterController < AdminController
 def send_test_mail
     Newsletter.transaction  do
     @page_properties={:selected_menu=>'newsletter_creation',:menu_title=>'New Profile'}
     @newsletter = @site.newsletters.find(params[:newsletter][:newsletter_id])
     @subject = @newsletter.subject(@site)
     status,content = @newsletter.html_body(@site,'test')
     if status
       debugger
       f=Feralchimp.new(TEST_NEWSLETTER_MAPPING[@site.short_name.to_sym][@newsletter.id][:api])
       campaign_id = f.campaignCreate(content:{'html'=>content},type:"regular",options:{'list_id'=>TEST_NEWSLETTER_MAPPING[@site.short_name.to_sym][@newsletter.id][:list_id],'subject'=> @subject,'from_email'=>@site.config.mail_chimp.from_email,'from_name'=>@site.config.mail_chimp.from_name,'auto_footer'=>"#{@site.short_name}"})
       if (campaign_id.class.name == "FeralchimpErrorHash" and !campaign_id.errors.blank?) 
            (render :json => {:text=>"Test Newsletter Was Not Delivered Successfully Please try Again" ,:status=>false}) 
        else
          (params[:test_subscriber] and params[:test_subscriber][:id]) ? f.campaignSendTest(cid:  campaign_id,test_emails:params[:test_subscriber][:id]) :  f.campaignSendTest(cid:  campaign_id,test_emails:TEST_USER_EMAIL_ID)
         (render :json => {:text=>"Thank You For Sending Newsletter" ,:status=>true})
        end
     else
         render :json => {:text=>"Please provide valid request" ,:status=>true}
     end
    end
  end

  def create_newsletter
       Newsletter.transaction  do
       @page_properties={:selected_menu=>'newsletter_creation',:menu_title=>'New Profile'}
       @newsletter = @site.newsletters.find(params[:newsletter][:newsletter_id])
       @subject = @newsletter.subject(@site)
       status,content = @newsletter.html_body(@site,'main')
       if status
         f=Feralchimp.new(MAIN_NEWSLETTER_MAPPING[@site.short_name.to_sym][@newsletter.id][:api])
         campaign_id = f.campaignCreate(content:{'html'=>content},type:"regular",options:{'list_id'=>MAIN_NEWSLETTER_MAPPING[@site.short_name.to_sym][@newsletter.id][:list_id],'subject'=> @subject,'from_email'=>@site.config.mail_chimp.from_email,'from_name'=>@site.config.mail_chimp.from_name,'auto_footer'=>"#{@site.short_name}"})
          if (campaign_id.class.name == "FeralchimpErrorHash" and !campaign_id.errors.blank?) 
            render :json => {:text=>"Test Newsletter Was Not Delivered Successfully Please try Again" ,:status=>false}
           else 
            f.campaignSendNow(cid:(campaign_id)) 
            render :json => {:text=>"Thank You For Sending Newsletter" ,:status=>true}
          end
       else
           render :json => {:text=>"Please provide valid request" ,:status=>true}
       end
     end
  end
  
  def show_newsletter
    @page_properties={:selected_menu=>'newsletter_menu',:menu_title=>'New Profile'}
    @newsletter=@site.newsletters.find(params[:id]) if params[:id]
    render :template=>"/admin/newsletter/new",:layout=>false
  end
 
 
   def create_subscriber
     @page_properties={:selected_menu=>'newsletter_menu',:menu_title=>'New Profile'}
     f=Feralchimp.new(MAIN_NEWSLETTER_MAPPING[@site.short_name.to_sym][params[:newsletter][:newsletter_id]][:api])
     @subscribers = f.list_members(id:MAIN_NEWSLETTER_MAPPING[@site.short_name.to_sym][params[:newsletter][:newsletter_id]][:list_id],email_address:['arunnitt@yahoo.com','others'])
     f.list_subscribe({:id => MAIN_NEWSLETTER_MAPPING[@site.short_name.to_sym][@newsletter.id][:list_id], :email_address =>params[:subscriber][:email_id], :merge_vars => {:FNAME => "Test", :LNAME => "User"},:double_optin =>false})
     @newsletter_id=params[:newsletter][:newsletter_id]
     render :template=>"/admin/newsletter/show_subscriber"
  end
  
#  def update_subject
#    @page_properties={:selected_menu=>'newsletter_menu',:menu_title=>'New Profile'}
#    @newsletter = @site.newsletters.find(params[:newsletter][:newsletter_id])
#    @newsletter.newsletter_subjects.create(:subject=>(params[:subject] || @site.short_name),:date=>Time.zone.now)
#    render :json => {:text=>'Subject Has Been Saved Successfully' ,:status=>true}
#  end

  def update_subject
    @page_properties={:selected_menu=>'newsletter_creation',:menu_title=>'New Profile'}
    @newsletter = @site.newsletters.find(params[:newsletter][:newsletter_id])
    subject = @newsletter.get_today_newsletter_subject
    @newsletter.newsletter_subjects.create(:subject=>(subject || @site.short_name),:date=>Time.zone.now)
    render :json => {:text=>'Subject has been saved successfully' ,:status=>true}
  end

  def new_test_subscriber
      @page_properties={:selected_menu=>'newsletter_menu',:menu_title=>'Profiles'}
      @test_subscriber = TestSubscriber.new
      @newsletter = @site.newsletters.find(params[:id])
      render :template=>"/admin/newsletter/new_test_subscriber"
  end
   
   def create_test_subscriber
     @page_properties={:selected_menu=>'newsletter_menu',:menu_title=>'Profiles'}
     @newsletter = @site.newsletters.find(params[:test_subscriber][:newsletter_id])
     @test_subscriber = TestSubscriber.new(params[:test_subscriber])
     if @test_subscriber.save
       flash[:notice] = "Thanks for creating test subscriber"
       render :template=>"/admin/articles/newsletter"
     else
       render :template=>"/admin/newsletter/new_test_subscriber"
     end
   end

   def newsletter_repository
     @page_properties={:selected_menu=>'newsletter_menu',:menu_title=>'Newsletter Repository'}
     @newsletter = @site.newsletters.find(params[:id])
     if @newsletter
       @newsletter_parses = @newsletter.newsletter_parses.order('created_at')
     end
     render :template=>"/admin/newsletter/newsletter_repository"
   end

   def export_newsletter_report
     @newsletter=Newsletter.find(params[:news_reg_id])
     from_date=params[:image_detail_search][:from].blank?  ? Time.now-30.days : params[:image_detail_search][:from]
     to_date=params[:image_detail_search][:to].blank? ?  Time.now : params[:image_detail_search][:to]
     @csv_string=@newsletter.generate_report(from_date, to_date)
     name=@newsletter.name.blank? ? '' : @newsletter.name.to_s.titleize.strip.gsub(' ', '')
     file_name = [Time.sr_now.strftime('%Y%m%d').to_s, 'FMSReport#' + @newsletter.id.to_s, name].join('-') + '.csv'
     send_data @csv_string, :type => 'text/csv', :header => 'present', :disposition => "attachment", :filename => "#{file_name}"
   end

  def import_subscriber
   @page_properties={:selected_menu=>'subscriber_menu',:menu_title=>'Import Subscriber'}
   render :template=>"/admin/newsletter/import_subscriber"
  end

  def export_subscriber
 @page_properties={:selected_menu=>'subscriber_menu',:menu_title=>'Export Subscriber'}
  if params[:commit] == "Generate Report"
     status = params[:search_data][:status] if params[:search_data][:status]
     @csv_report = NewsletterRegisteration.generate_report(params[:search_data])
     file_name = [Time.sr_now.strftime('%Y%m%d').to_s, 'Subscriber' + status + 'Report'].join('-') + '.csv'
     send_data @csv_report, :type => 'text/csv', :header => 'present', :disposition => "attachment", :filename => "#{file_name}"
  else
    render :template=>"/admin/newsletter/export_subscriber"
  end
 end

def newsletter_change_status
   @page_properties={:selected_menu=>'subscriber_menu',:menu_title=>'Export Subscriber'}
    sub_ids = params[:ids].split(",") if params[:ids]
   if params[:status] == "Active"
      @site.newsletter_registerations.where(:id=>sub_ids).update_all(:status=>"InActive",unsubscribe_date: Time.now)
   else
      @site.newsletter_registerations.where(:id=>sub_ids).update_all(:status=>"Active", unsubscribe_reasion: nil, unsubscribe_date: nil, created_at: Time.now)
    end
    redirect_to :back
 end

 def old_export_subscriber
logger.info "ccccccccccccccccccc" 
 @page_properties={:selected_menu=>'subscriber_menu',:menu_title=>'Export Subscriber'}
  if params[:commit] == "Generate Report"
     start_date = params[:search_data][:start_date] if params[:search_data][:start_date]
     end_date = params[:search_data][:end_date] if params[:search_data][:end_date]
     status = params[:search_data][:status] if params[:search_data][:status]
     email_id = params[:search_data][:email_id] if params[:search_data][:email_id]
     company_name = params[:search_data][:end_user_company_name] if params[:search_data][:end_user_company_name]
     job_title = params[:search_data][:Job_title] if params[:search_data][:Job_title]     
     logger.debug @csv_report = NewsletterRegisteration.generate_report(start_date, end_date,status,company_name,email_id,job_title)
     file_name = [Time.sr_now.strftime('%Y%m%d').to_s, 'Subscriber' + status + 'Report'].join('-') + '.csv'
     send_data @csv_report, :type => 'text/csv', :header => 'present', :disposition => "attachment", :filename => "#{file_name}"
  else
    render :template=>"/admin/newsletter/export_subscriber" 
  end
 end

def validate_uploaded_file
    @not_valid_file_format = false
    @not_valid_email_format = false
    @duplicate_email = false
    @blank_email_id = false
    email_arr = []
    file_path = params['subscriber_excel_file'].path
    file_name = params['subscriber_excel_file'].original_filename
    @not_valid_file_format = true if file_name.split(".").last.downcase != 'xlsx'
    if  !@not_valid_file_format
      folder_path = "#{Rails.root}/public/subscriber_bulk_data/#{Time.now.strftime("%m-%d-%Y-%I:%M%p")}"
      FileUtils.mkdir_p folder_path, :mode => 0777
      FileUtils.cp(file_path, "#{folder_path}/#{file_name}")
      file = FileUtils.chmod 0777, "#{folder_path}/#{file_name}"
      @spreadsheetx = Roo::Excelx.new(file[0])
      (2..@spreadsheetx.last_row).each do |i|
        row = @spreadsheetx.row(i)
        @blank_email_id = row[0].blank?
        break if @blank_email_id
        email = row[0].to_s.strip
        email_arr << email
       logger.info "========email1111========#{email}======222=====#{email_arr}=="
        @not_valid_email_format = /\A([a-zA-Z0-9_.'-])+@(([a-zA-Z0-9-])+.)+([a-zA-Z]{2,4})+\z/.match(email).blank?
        logger.info "========email22222========#{email}======33333=====#{email_arr}=="
        @invalid_email_format = email if !@not_valid_email_format.blank?
        break if @not_valid_email_format
      end
      @duplicate_email = true if email_arr.count != email_arr.uniq.count
    end

  end


def import_subscriber_newsletter
 @page_properties={:selected_menu=>'subscriber_menu',:menu_title=>'Import Subscriber'}
    validate_uploaded_file
    if @not_valid_file_format
       redirect_to :action => "import_subscriber", alert: "Please upload valid xlsx file."
    elsif @blank_email_id
      redirect_to :action => "import_subscriber", alert: "Email field should not be blank."
    elsif @not_valid_email_format
      redirect_to :action => "import_subscriber", alert: "Email id [#{@invalid_email_format}] in the file is not proper."
    elsif @duplicate_email
     redirect_to :action => "import_subscriber", alert: "The file you have uploaded has duplicate email."
    else
      create_bulk_subscriber
     redirect_to :action => "import_subscriber", alert: "All the email IDs are created."
    end
end

 def create_bulk_subscriber
    (2..@spreadsheetx.last_row).each do |i|
      row = @spreadsheetx.row(i)
      email = row[0].strip.downcase
      subscriber = @site.newsletter_registerations.where(email_id: email).first
      if subscriber and subscriber.status == "InActive"
        subscriber.update_attributes(status: "Active", unsubscribe_reasion: nil, unsubscribe_date: nil, created_at: Time.now)
       logger.info "============1111===============#{subscriber.inspect}"
      elsif subscriber.blank?
        fname = row[1].present? ? row[1].strip : email.split("@").first.capitalize
        lname = row[2].present? ? row[2].strip : ""
        subscriber = @site.newsletter_registerations.new(first_name: fname, last_name: lname, email_id: email, company_name: row[3], job_title: row[4], status: "Active",data_proxy_id: @site.id)
        subscriber.save(:validate => false)
       logger.info "============2222===============#{subscriber.inspect}"
      else
       logger.info "============3333===============#{subscriber.inspect}"
      end
       # WebMailer.subscription_user_without_login(subscriber, @site).deliver
    end
  end


 def import_unsubscriber_newsletter
  @page_properties={:selected_menu=>'subscriber_menu',:menu_title=>'Import UnSubscriber'}
    validate_uploaded_file
    if @not_valid_file_format
       redirect_to :action => "import_subscriber", notice: "Please upload valid xlsx file."
    elsif @blank_email_id
      redirect_to :action => "import_subscriber", notice: "Email field should not be blank."
    elsif @not_valid_email_format
      redirect_to :action => "import_subscriber", notice: "Email id [#{@invalid_email_format}] in the file is not proper."
    elsif @duplicate_email
     redirect_to :action => "import_subscriber", notice: "The file you have uploaded has duplicate email."
    else
      create_bulk_unsubscriber
     redirect_to :action => "import_subscriber", notice: "All the email IDs are created."
    end
 end


   def create_bulk_unsubscriber
    (2..@spreadsheetx.last_row).each do |i|
      row = @spreadsheetx.row(i)
      email = row[0].strip.downcase
      subscriber = @site.newsletter_registerations.where(email_id: email).first
      if  subscriber and subscriber.status == "Active"
          subscriber.update_attributes(status: "InActive", unsubscribe_reasion: row[1], unsubscribe_date: Time.now)
      end
      logger.info "============4444===============#{subscriber.inspect}"
       # WebMailer.subscription_user_without_login(subscriber, @site).deliver
    end
  end 


def subscribers_upload_sample
 @page_properties={:selected_menu=>'subscriber_menu',:menu_title=>'Subscriber'}
 if params[:id] and params[:id] == "sample"
   send_file("#{Rails.root}/public/subscribers_upload_sample.xlsx")
 else
   send_file("#{Rails.root}/public/unsubscribers_upload_sample.xlsx")
 end
end

end

