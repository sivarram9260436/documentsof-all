class WebMailer < ActionMailer::Base
  include Wps::WpsLinkHelper
  include Rails.application.routes.url_helpers

   def email_for_newsletter_subscription(subscriber,site)
    @subscriber = subscriber
    @subject = site.config.mail.newsletter_mail
    @from = site.config.mail.senders_display_name
    @site_name=site.name
   attachments.inline['Masthead-TheMachinist.jpg'] = File.read("#{Rails.root}/../Sites/#{site.short_name}/public/images/Masthead-TheMachinist.jpg")  if FileTest.exists?("#{Rails.root}/../Sites/#{site.short_name}/public/images/Masthead-TheMachinist.jpg")
    mail(:to => subscriber.email_id , :subject => @subject , :from => @from)do |format|
         format.html { render "#{Rails.root}/../Sites/#{site.short_name}/views/web_mailer/email_for_newsletter_subscription" }
   end
  end

  def reset_password(subscriber,link,site,user_handle)
    @subject= site.name.gsub("www.","") +" Password reset"
    @recipients = subscriber.email_id
    @from = "support@#{site.name.gsub("www.","")}"
    @date = 2.days.from_now
    @sent_on = Time.sr_now
    @subscriber = subscriber
    @link = link
    @site=site
    mail(:to => @recipients, :subject =>@subject, :from => @from) do |format|
      format.html { render "#{Rails.root}/../Sites/#{site.short_name}/views/web_mailer/reset_password" }
    end
  end

#   def email_for_newsletter_subscription(subscriber_email,subject,site,subscriber)
#    @subject = "NewsLetter Verification Mail"
#    @from = "support@techonlineindia.com"
#    @subscriber = subscriber
#    @site_name=site.name
#    logger.info "==============subject===#{@subject}==site_name==#{@site_name}=="
#    mail(:to => subscriber_email, :subject => @subject , :from => @from)
#   end
 
   def email_for_resend_verification_link(subscriber,site,url)
    @site=site
    @subject   = "Activate your account with Techonline India"
    @recipients = subscriber.email_id
    @from       = "support@#{@site.name.gsub("www.","")}"
    @link=url
    @subscriber = subscriber
    attachments.inline['logo.jpg'] = File.read("#{Rails.root}/../Sites/#{@site.short_name}/public/images/logo.png") if FileTest.exists?("#{Rails.root}/../Sites/#{@site.short_name}/public/images/logo.png")
     mail(:to => subscriber.email_id.blank? ? subscriber.email : subscriber.email_id,:subject => @subject , :from => "support@#{@site.name.gsub("www.","")}" ) do |format|
         format.html { render "#{Rails.root}/../Sites/#{@site.short_name}/views/web_mailer/resend_verification_link" }
   end
  end
  def user_registration(user, user_status, host,link)
    @user=user
    @host=host
    @user_status=user_status
    @link=link
    mail(:to => user.delivery_email.blank? ? user.email : user.delivery_email,:subject => user_status.eql?('new') ? "New Login to http://#{host}" : "Login change to http://#{host}", :from => "no-reply@themachinist.kreatio.com")
  end

  def send_approval_request_article(recipient_email,article,options={} )
    @subject    = "Article in CMS requiring approval"
    @recipients = recipient_email
    @from       = options[:from].blank? ? "no-reply@themachinist.kreatio.com" : options[:from]
    @sent_on    = Time.sr_now
    @article    = article
    @thank_you_text = options[:thank_you_text].blank? ? "CMS Team" : options[:thank_you_text]
    mail(:to => @recipients,:subject => @subject, :from =>  @from)
  end

end
