class Wps::AuthenticationController < WpsController
  include Wps::WpsAuthenticationHelper
  before_filter :check_user_handle
 
  def subscriber_create
    @page_properties={:menu_title=>"Thanks",  :page_type => "listing_page"}
    @subscriber_new=Subscriber.find(:first,:conditions=>["UPPER(email_id)=UPPER(?)",params[:subscriber][:email_id].strip]) unless params[:subscriber].blank?
    if @subscriber_new.blank?
      @subscriber_new= Subscriber.create(params[:subscriber])
      @subscriber_new.update_attribute("registered_from_site_id",@site.id)
    elsif @subscriber_new.provider_type.blank?
      @subscriber_new.errors[:base] << "This email id already exists. Please login or register with a different email id."
    else
      @subscriber_new.update_attributes(params[:subscriber])
    end
    if @subscriber_new.errors.blank?
      @subscriber_new.update_attribute("password","#{Digest::MD5.hexdigest(@subscriber_new.password)}")
      @subscriber_property = SubscriberProperty.new(params[:subscriber_property])
      @subscriber.subscriptions.create(:name=>"demo_subscription",:subscription_type=>"paid",:start_date=>Time.now,:end_date=>Time.now + 1.year,:product_id => 1,:status=>"success" ) 
    if @subscriber_property.save(:validate=>false)
        @subscriber_property.update_attribute("subscriber_id",@subscriber_new.id)
        set_login_cookies
        change_login_count
        redirect_to params[:redirect_url] || "/"
      else
       render :template => "authentication/signup_page" ,:layout=>@site.get_layout
     end
    else
      render :template => "authentication/signup_page" ,:layout=>@site.get_layout
   end
  end
  
  def logout
   reset_session()
   [ :remember_me_key, :subscriber, :remember_me, :logged_in,:email ].each{|key| cookies.delete( key ) }
    cookies.delete(:logged_in) unless cookies[:logged_in].blank?
    flash[:notice] = 'Sucessfully Logged out'
   if params[:redirect_url]
      redirect_to params[:redirect_url]
    else
      redirect_to "/"
    end
  end

  def registration
   @page_properties={:menu_title=>"Registration",  :page_type => "listing_page"}
   render :template => "authentication/signup_page" ,:layout=>@site.get_layout
 end

  def login_without_subscriptions
    if params[:login_type] == "google"
      google_login
    elsif params[:login_type] == "facebook"
      facebook_login
    elsif params[:login_type] == "linkedin"
      linkedin_login
    elsif params[:login_type] == "twitter"
      twitter_login
    elsif params[:normal_login]
      hash_pass = Digest::MD5.hexdigest(params[:subscriber][:password])
      @subscriber_new = Subscriber.where("UPPER(email_id) = UPPER(?) and password = ?", params[:subscriber][:email_id], hash_pass).first
      if @subscriber_new
        set_login_cookies
        change_login_count
        session[:subscriber_individual_id] = @subscriber_new.id
      @user_handle = UserHandle.new(@subscriber_new.id, @site.id)
      else
        cookies[:login_error_message] = "Incorrect username or password"
      end
      unless cookies[:login_error_message].blank?
        render :text => "Incorrect username or password",:layout => false
      else
        if request.xhr?
          render :text => "sucess"
        else
          redirect_to params[:redirect_url] || "/"
        end
      end
    end
  end

   def forgot_password  
    @page_properties={:menu_title=>"Forgot password "}   
    render :template=>"/authentication/forgot_password_authorisation",:layout=>@site.get_layout 
  end

   def reset    
    @page_properties={:menu_title=>"Reset password "} 
    sub_mail = params[:subscriber][:email_id] unless params[:subscriber].blank?
    if params[:subscriber]  and not sub_mail.blank?
       subscriber = Subscriber.where("UPPER(email_id)=UPPER(?)",params[:subscriber][:email_id]).first
      if subscriber  
        @user_handle=UserHandle.new(subscriber.id,@site.id)   
          subscriber.reset_password_code_until = 2.days.from_now
          subscriber.reset_password_code =  Digest::MD5.hexdigest( "#{subscriber.email_id}#{Time.sr_now.to_s.split(//).sort_by {rand(10)}.join}" )
          subscriber.save(:validate=>false)
          link=(url_for :controller=>'wps/authentication',:action=>'activate_user',:id=>subscriber.reset_password_code,:only_path=>false)
          WebMailer.reset_password(subscriber,link,@site,@user_handle).deliver
          flash[:password_status]= "Please check your email. The link to change your password has been sent to #{subscriber.email_id}. If the email has not arrived in your inbox within the hour, please check your junk mail folder."
       redirect_to  :action=>"forgot_password"
        else
        flash[:email_error] = "A user with this email couldn't be found."
        render :template=>"/authentication/forgot_password_authorisation", :layout=>@site.get_layout
      end    
    else
      flash[:email_error] = "Please enter email"
      redirect_to :action=>"forgot_password"
    end
  end

  def activate_user  
    @page_properties={:menu_title=>"Activate User "} 
    subscriber_new=Subscriber.find_by_reset_password_code(params[:id])    
    if subscriber_new!=nil and subscriber_new.reset_password_code_until > Time.sr_now 
       @user_handle=UserHandle.new(subscriber_new.id,@site)     
       render :partial=>"/authentication/capture_password"
    else      
       WebMailer.deliver_activate_user_link_expired(subscriber_new,@site,params[:id]) if subscriber_new
       render :partial=>"/authentication/reset_expired_link"
    end
  end

  def save_subscriber_password  
    @page_properties={:menu_title=>"Activate User "}
    @subscriber_new=Subscriber.find(params[:id])
    begin
    @subscriber,status=@subscriber_new.reset_password(params[:subscriber][:password],params[:subscriber][:confirm_password])   
    rescue
    status=false
    end
     @user_handle=UserHandle.new(@subscriber_new.id,@site.id)
    if status       
      @subscriber_new.update_attributes(:reset_password_code_until=>Time.sr_now.to_s(:db))
        set_login_cookies # Used to check in ajax action to populate the user specific infor via ajax request
        session[:subscriber_individual_id] = @subscriber_new.id
        session[:session_unique_secret_key] = Util.generate_unique_secret_key
        @subscriber_new.update_attributes(:last_login=>Time.sr_now,:remember_me_key=>nil,:remember_me_time=>nil)
      flash[:password_status]= "We confirm your password has been set successfully. You will also receive a confirmation email."
      if params[:redirect_url].blank?
        redirect_to :action=>"confirm_password"
      else 
         redirect_to params[:redirect_url]
      end
    else         
      render :partial=> "/authentication/capture_password" 
    end
  end 

  def confirm_password
      @page_properties={:menu_title=>"Confirm Password"}
      render :partial=> "/authentication/confirm_password"
  end

  def test_subscribtion
    @page_properties={:menu_title=>"Confirm Password"}
    render :template => "/listing_pages/test",:layout=>@site.get_layout
  end 
  
    def change_login_count
    SubscriberAudit.create(:subscriber_id=>@subscriber_new.id,:site_id=>@site.id,:provider_type=>params[:provider])
  end
  
  def manage_my_profile
 @page_properties={:menu_title=>"Manage Account"} 
  if (session[:subscriber_individual_id] or session[:subscriber_institution_id]) 
    @subscriber_new = Subscriber.find((session[:subscriber_individual_id] or session[:subscriber_institution_id]))
     render :template=>"/authentication/manage_profile",:layout=>@site.get_layout
    else
      flash[:notice]="Please Login"
      redirect_to  "/"
  end
end

   def update_subscriber_profile
     @page_properties={:menu_title=>"Update Manage Account"}
      @subscriber=Subscriber.find(params[:subscriber][:id])
      @subscriber.update_attributes(params[:subscriber])
      if @subscriber
        @subscriber.subscriber_property.update_attributes(params[:subscriber_property])
        render :template=>"/authentication/manage_profile_thanks", :layout=>@site.get_layout
      else
        render :template=>"/authentication/manage_profile", :layout=>@site.get_layout
      end
   end  
   
   def change_password
      @subscriber=Subscriber.find(params[:id])
      if @subscriber
          render :template=>"/authentication/change_password",:layout=>@site.get_layout
       else
        render_404  
      end
   end
   
   def update_password
     @subscriber_new=Subscriber.where("email_id=? and password=?",params[:subscriber][:email],"#{Digest::MD5.hexdigest(params[:subscriber][:old_password])}").first
     if @subscriber_new
        @subscriber =  @subscriber_new 
        @subscriber_new,status=@subscriber_new.reset_password(params[:subscriber][:password],params[:subscriber][:confirm_password])
       if status
        @subscriber_new.update_attributes(:reset_password_code_until=>Time.sr_now.to_s(:db))
        set_login_cookies # Used to check in ajax action to populate the user specific infor via ajax request
        session[:subscriber_individual_id] = @subscriber_new.id
        session[:session_unique_secret_key] = Util.generate_unique_secret_key
        @subscriber_new.update_attributes(:last_login=>Time.sr_now,:remember_me_key=>nil,:remember_me_time=>nil)
        flash[:password_status]= "We confirm your password has been set successfully. You will also receive a confirmation email."
        @user_handle=UserHandle.new(@subscriber_new.id,@site.id)
       end
       if !!request.xhr?
          render :json=>{:status=>status,:message=>@subscriber_new.errors}
        else 
          if status
            redirect_to params[:redirect_url] || "/"
          else
             render :template=>"/authentication/change_password",:layout=>@site.get_layout
          end
       end
     else 
        flash[:message] = "Please Enter the correct password"
        render :template=>"/authentication/change_password",:layout=>@site.get_layout
     end 
   end
end
