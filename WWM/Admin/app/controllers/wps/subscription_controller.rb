require 'open-uri'
class Wps::SubscriptionController < WpsController


def newsletter_subscriber
    @page_properties={:menu_title=>"Thanks",  :page_type => "newsletter_subscriber"}
    @captcha_value = (@site.config.captcha.newsletter_captcha == "true" ? verify_recaptcha : true)
    @newsletter_registeration = @site.newsletter_registerations.new()
    if @captcha_value
    n=@site.newsletters.find(params[:newsletter_id]) if  params[:newsletter_id]
      if !n.blank?
       # @subscriber = Subscriber.find_by_email_id(params[:subscriber][:news_email_id])
        @subscriber = @site.newsletter_registerations.where("UPPER(email_id) = UPPER(?) and status = ?", params[:subscriber][:news_email_id], "Active").first
        logger.info "=================@subscriber==========#{@subscriber.inspect}======="
       if @subscriber.blank?
        @newsletter_subscriber = @newsletter_registeration = @site.newsletter_registerations.new(:email_id=>params[:subscriber][:news_email_id],:first_name=>params[:subscriber][:user_name],:company_name=>params[:subscriber_property][:end_user_company_name],:job_title=>params[:subscriber_property][:Job_title],:last_name=>params[:subscriber][:last_name],:subscriber_id=>(@subscriber.blank? ? nil : @subscriber.id),:newsletter_id=>n.id,:status => "Active",:data_proxy_id => @site.id)
         @newsletter_registeration.save
        #if @newsletter_registeration.save
        f=Feralchimp.new(MAIN_NEWSLETTER_MAPPING[@site.short_name.to_sym][n.id.to_i][:api])
        status = f.list_subscribe({:id =>MAIN_NEWSLETTER_MAPPING[@site.short_name.to_sym][n.id.to_i][:list_id] , :email_address =>params[:subscriber][:news_email_id], :merge_vars => {:FNAME =>params[:subscriber][:user_name] , :LNAME =>params[:subscriber][:last_name] },:double_optin =>false})
        WebMailer.email_for_newsletter_subscription(@newsletter_registeration,@site).deliver if !@newsletter_registeration.blank?
        logger.info "========================assdfsd#{status}====#{status == true}==="
        if !!request.xhr?
#        (status == true ? (render :text => true) : (render :template=>"/listing_pages/newsletter",:layout=>false))
       render :text => true
        else
         if params[:redirect_url]
           redirect_to (params[:redirect_url] || '/')
         else
           render :template=>"/listing_pages/newsletter",:layout=>@site.get_layout
         end
        end
      else
        if !!request.xhr?
          logger.info "=====================iffffffffffff=============="
          render :json => {success: false, :message=> "Email id already exists"}
          #render :template=>"/listing_pages/newsletter",:layout=>@site.get_layout
    #     render :json => {:text=>"failure",:status=>false}
        else
        logger.info "=======================elseeeeeeeeee=============="
         render :template=>"/listing_pages/newsletter",:layout=>@site.get_layout 
         #render :text=>"Email id already exists",:layout=>@site.get_layout
        end
      end
      else
       render_404
      end
     else
     @newsletter_registeration.errors[:base] << (params[:recaptcha_response_field].blank? ? "Please Enter The Text Shown In Captcha" :"Captcha image Didn't Match,Please enter again")
    if !!request.xhr?
      render :partial=>"/listing_pages/partials/newsletter_popup"
    else
       render :template=>"/special_pages/subscribe_newsletter" ,:layout=>@site.get_layout  
       end
     
     end
   end


  def resend_verification_link
   @page_properties={:menu_title=>"Thanks",  :page_type => "listing_page"}
   if params[:newletter_subscription]=="true"
     @subscriber = SubscriberIndividual.find(params[:id]) if !params[:id].blank?
     WebMailer.email_for_newsletter_subscription(params[:news_email_id],@subject,@site,@subscriber).deliver unless params[:news_email_id].blank?
     render :text=>'success'  if !params[:id].blank?
   else
     @subscriber = SubscriberIndividual.find(params[:id]) if !params[:id].blank?
     url = "http://#{@site.name}/subscriber/activation_link/#{@subscriber.id}"
     WebMailer.email_for_resend_verification_link(@subscriber,@site,url).deliver
     render :text=>'success'  if !params[:id].blank?
   end
  end

 def unsubscribe_newsletter
  @page_properties={:menu_title => "Unsubscibe", :page_type => "newsletter_subscriber"}
  if params[:subscriber] and params[:subscriber][:news_email_id]
    @subscriber = @site.newsletter_registerations.where("UPPER(email_id) = UPPER(?) and status = ?", params[:subscriber][:news_email_id], "Active").first
  end
  if @subscriber
     @subscriber.update_attributes(:unsubscribe_date => Time.sr_now, :unsubscribe_reasion => params[:subscriber][:unsubscribe_reasion], :status => "InActive")
     logger.info "=====subbbbbbbbbbbb================#{@subscriber.inspect}============"
    #WebMailer.email_for_unsubscibe_newsletter(@newsletter_registeration,@site).deliver if !@newsletter_registeration.blank?
      if !!request.xhr?
        render :json => {success: true, :message=> "Thanks for unsubcribe newsletter."}
      else
        render :template=>"/special_pages/unsubscribe-newsletter-thanks",:layout=>false
     end
  else
    if !!request.xhr?
       render :json => {success: false, :message=> "Invalid email id."}
     else
       render :partial=>"/listing_pages/partials/unsubscribe_newsletter_popup"
    end  
  end
end


end
