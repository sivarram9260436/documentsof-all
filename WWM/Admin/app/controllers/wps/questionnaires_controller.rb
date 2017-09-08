class Wps::QuestionnairesController < WpsController
  include Wps::WpsLinkHelper
  def save_questionnaire_form
    @asset=@site.digital_assets.find(params[:asset_id]) if params[:asset_id]
    if save_questionnaire_answers
      @page_properties = {:selected_menu => 'article_menu', :menu_title => 'Questionnaire Submitted'}
      @asset=@site.digital_assets.find(params[:asset_id]) if params[:asset_id]
      @questionnaire = Questionnaire.find(params[:id])
      create_image_property(params[:image_id],"QuestionnaireSubmission",@questionnaire_submission.id) if params[:image_id]
      if params[:digital_asset]
        @digital_asset = DigitalAsset.save_asset(@site, params[:digital_asset],get_doc=true)
        @questionnaire_submission.digital_assets <<  Array(@digital_asset)
      end
      subscriber_email = @user_handle.subscriber.email_id  if @user_handle
      WebMailer.email_to_individual(@site.config.mailer.email_to_an_individual,@questionnaire_submission,@site).deliver unless (@site.config.mailer.email_to_an_individual and params[:email_to_an_individual]).blank?
      eval( "WebMailer.#{params[:value].gsub('-','_')}_mail(@site.config.mailer.#{params[:value].gsub('-','_')},@questionnaire_submission,@site,subscriber_email).deliver") if params[:value] and @user_handle
      eval( "WebMailer.#{params[:email_to_subscriber]}_mail(@site.config.mailer.#{params[:email_to_subscriber]},@questionnaire_submission,@site,subscriber_email).deliver") if params[:email_to_subscriber] and @user_handle
      session[:questionnaire_product_id] = params[:product_id].to_i
      session[:questionnaire_submission_id] = @questionnaire_submission.id
      session[:new_questionnaire_submission] = "true"
      session[:answer] = @questionnaire_submission.questionnaire_id unless @questionnaire_submission.questionnaire.products.blank?
      session[:ansewered_questionnaire_ids] = @questionnaire_submission.questionnaire_id unless @questionnaire_submission.questionnaire.products.blank?
      flash[:notice] = @questionnaire.thankyou_acknowledge.blank? ? "Thankyou for your Registeration" : @questionnaire.thankyou_acknowledge
      if !!request.xhr?
        render :json => {:status => "true" , :message => flash[:notice]}
      elsif params[:http_redirect]
        redirect_to params[:http_redirect]
      else
        if params[:pay_online] == "true"
          create_pay_online_record
          render :template => '/authentication/questionnaire_paymment_page', :layout => false
        else
          render :template => '/questionnaire/questionnaire_thanks', :layout => @site.get_layout
        end
      end
    else
      if !!request.xhr?
        render :json => {:status=>"false" ,:message=> @questionnaire_submission.errors.full_messages.map{|emsg|  emsg.split('_')[1]} }
      else
        @article = @site.articles.where(:id=>params[:article_id]).first unless params[:article_id].blank?
        @page_properties = {:selected_menu => 'article_menu', :menu_title => 'Questionnaire Submitted'}
        render :template => '/questionnaire/_questionnaire_form', :layout => @site.get_layout
      end
    end
  end

end
