class Wps::PagesController < WpsController

 def article_reports
  all_articles_details = []
  unless @site.blank?
  @site.articles.limit(1000).each do |article|
    all_articles_details << {:id => article.id,:title => article.title,:source => article.source.name,:section => article.section.name,:categories=> article.categories.all.collect{|a| a.name},:authors => article.authors.collect{|a| a.name},:medium=>article.primary_medium,:tags => article.tags.collect{|a| a.name},:image=>"#{"#{article.image.id},#{article.image.image_path}" if article.image }",:vedio=>"#{"#{article.media_detail.id},#{article.media_detail.video_path}" if article.media_detail }",:audio=>"#{"#{article.audio.id},#{article.audio.audio_path}" if article.audio }",:publish_date=>article.publish_date,:display_date=>article.display_date}
  end
 end
  render :json =>  all_articles_details.to_json
end

  def vote
    @selected_menu = @site.get_listing_selected_menu("/polls")
    @poll = @site.polls.active.find(params[:poll_id])
    @poll_options = @poll.poll_options
    @page_properties = {:menu_title => @poll.title}
    if params[:poll_options_id]
      # checking cookie for previous vote
      allow_vote = check_cookie_while_vote
      # polling vote
      if allow_vote
        @poll.vote(params[:poll_options_id], request.remote_ip)
        flash[:notice] = "<span class='activation_link_success'>Thanks for your vote.</span>"
      else
        flash[:error] = "<span class='activation_link'>Sorry, you have already voted so any further votes will not be counted.</span>"
      end
      # page redirection according to site property
      if @site.config.poll.redirects== "home_page"
        cookies[:poll_ajax_call] = {:value => 'true', :domain => request.host.gsub(/^[^.]*/, '')}
        cookies[:poll_message] = {:value => flash[:notice], :domain => request.host.gsub(/^[^.]*/, '')} || {:value => flash[:error], :domain => request.host.gsub(/^[^.]*/, '')}
        redirect_to '/#poll'
      elsif @site.config.poll.redirects== "same_page"
        cookies[:poll_ajax_call] = {:value => 'true', :domain => request.host.gsub(/^[^.]*/, '')}
        cookies[:poll_message] = {:value => flash[:notice], :domain => request.host.gsub(/^[^.]*/, '')} || {:value => flash[:error], :domain => request.host.gsub(/^[^.]*/, '')}
        redirect_to "#{request.referer}#poll"
      else
      #  respond_to do |format|
      #    format.json do
      #      render :json => @poll.get_all_gragh_values(@site)
      #    end
      #    format.html do
      #      render :template => "polls/vote", :layout => (params["data_ciol"] == 'true' ? false : @site.get_layout)
      #    end
      #  end
       if request.xhr?
        render :partial => 'polls/poll_results', :layout=>false
       else
        render :template => 'polls/poll_results', :layout=>@site.get_layout
       end
      end
    else
      flash[:notice] = "Please select one option to vote."
      render :template => @site.show_poll_page, :layout => @site.get_layout
    end
  end

  def save_comment
    if request.post?
      # Adding new comment
      if params[:poll] == "true"
        @poll = @site.polls.active.find(params[:id])
        @comment = @poll.comments.new(params[:comment])
      elsif params[:service]
        @service=@site.services.find(params[:id])
        @comment = @service.comments.new(params[:comment])
      elsif params[:author]
        @author=@site.authors.find(params[:id])
        @comment = @author.comments.create(params[:comment])
      else
        @article = @site.get_article(params[:id])
        @comment = @article.comments.new(params[:comment])
      end

      # authorisation status changing based on site property
      @comment.status = "submitted" if @site.config.comment.moderation == "true"

      # finding client ip and ip proxy
      client_ip = ( params[:comment] and params[:comment][:ip_address] )
      ip_proxy = ( @site.config.poll.ip_proxy.blank? ? IP_PROXY : @site.config.poll.ip_proxy.split(',') )

      # finding spam comment status
      unless @site.config.poll.akismet == "true"
      # ( @comment.status = 'spam' ) if @comment.spam?
      end

      need_captcha_validation =@site.config.comment.captcha == "false" ? false : true
      need_captcha_validation = false if@site.config.comment.captcha == nil
      if CAPTCHA_BACKDOOR_STRING and params[:recaptcha_response_field] == CAPTCHA_BACKDOOR_STRING
      need_captcha_validation = false
      end
      # allow validating captcha based on ip proxy

      # if ip_proxy.include?(client_ip) and not need_captcha_validation
      unless @site.config.captcha.recaptch.blank? || @site.config.captcha.recaptch == "recaptcha"
      status =@comment.save
      end
      if not need_captcha_validation

        if request.xhr?
          if status
            render :text => "Thanks", :layout => false
          else
            error_message = "Errors-<ul class=''><li>" + @comment.errors.full_messages.join('</li><li>') + '</li></ul>'
            render :text => error_message, :layout => false,:status =>201
          end

        else
          redirect_to thanks_comment_url_path(params[:poll] == "true" ? @poll : @article)
        end
      else
      # captcha validation we have written on controller because it is not supporting for model validation
        if  verify_recaptcha(:model => @comment, :private_key => RECAPTCHA_PRIVATE_KEY, :message => '<b>CAPTCHA Image</b> text does not match - please re-enter.') and @comment.save
          @comment.save
          if not @site.config.comment_notification.email.blank?
          @comment.send_mail_about_new_comment(@site.config.comment_notification.email,@site, @article)
          end

          if request.xhr?
            cookies[:thanks_comment] = {:value => params[:thanks_comment], :domain => request.host.gsub(/^[^.]*/, '')}
            render :text => "Thanks", :layout => false
          else
            redirect_to thanks_comment_url_path(params[:poll] == "true" ? @poll : @article)
          end
        else
          @comment.comment_validate
          if request.xhr?
            error_message = "Errors-<ul class=''><li>" + @comment.errors.full_messages.join('</li><li>') + '</li></ul>'
            render :text => error_message, :layout => false,:status =>201
          else
            render :template => @site.get_add_comment_page, :layout => @site.get_layout
          end
        end
      end
    else
      render_404
    end
  end

  def news_sitemap
    @page_properties={:page_type=>"other_pages"}
    @articles=@site.articles_by_days(7,100)
    respond_to do |format|
      format.xml{render :layout => false ,:template => @site.google_new_sitemap_page}
    end
  end

  def sitemap_index
    @page_properties={:page_type=>"other_pages"}
    @article_count = @site.articles.count
    @page_count = @article_count / 100
    @page_count = @page_count + 1 if (@article_count % 100 != 0)
    respond_to do |format|
      format.xml{render :layout => false ,:template => @site.google_sitemap_index_page}
    end
  end

  def videositemap
    @page_properties={:page_type=>"other_pages"}
    @articles=@site.articles.video_articles.latest.limit(30)
    respond_to do |format|
      format.xml{render :layout => false ,:template => @site.google_videositemap_page}
    end
  end

  def show_article
    Ambient.render_print_page=params[:print]
    if @article
      @previous_articles,@next_articles = @article.previous_next_articles(@site)
      context = {}
      context[:article] = @article
      if params[:blog]
        @page_properties = {:menu_title => @article.title, :page_type => "blog_article", :entities => @article,:context =>context }
      else
        @page_properties = {:menu_title => @article.title, :page_type => "article_page", :entities => @article,:context =>context }
      end
      @selected_menu = @site.get_article_selected_menu(@article.id)
      # @selected_menu = @site.get_selected_menu(:article_page => @article)
      if  @article.get_product(@site) and session[:questionnaire_product_id] == @article.get_product(@site).id
        biuld_answers_with_old_submission  if not session[:ansewered_questionnaire_ids].blank? and session[:new_questionnaire_submission].blank?
        session[:new_questionnaire_submission] = nil
        render :template => @site.get_template(@article), :layout => @site.get_article_layout(@article) ? @site.get_article_layout(@article) : @site.get_layout
      else
        if @paid_article and @access_denied
          if request.xhr?
            if params[:comment_page]
              render :partial=>'/article_pages/comment', :layout => false
            else
              render :template => @site.get_article_teaser_template(@article), :layout => false
            end
          else
            render :template => @site.get_article_teaser_template(@article), :layout => @site.get_layout
          end
        else
          if request.xhr?
            if params[:comment_page]
              render :partial=>'/article_pages/comment', :layout => false
            else
              render :template => @site.get_template(@article), :layout => false
            end
          else
            render :template => @site.get_template(@article), :layout => @site.get_article_layout(@article) ? @site.get_article_layout(@article) : @site.get_layout
          end
        end
      end
    #render :template => "/article_pages/show_article", :layout => @site.get_layout
    else
      render_404
    end
  end

  def biuld_answers_with_old_submission
    if session[:questionnaire_submission_id] and session[:ansewered_questionnaire_ids]
      @questionnaire = Questionnaire.find_by_id(session[:ansewered_questionnaire_ids])
      @questionnaire_submission = QuestionnaireSubmission.new(:questionnaire_id => @questionnaire.id, :product_id => session[:questionnaire_product_id])
      @questionnaire_submission.questionnaire = @questionnaire
      @questionnaire_submission.http_referrer = request.referrer
      @questionnaire_submission.ip_address = request.remote_ip
      @questionnaire_submission.save(:validate=>false)
      old_submission = QuestionnaireSubmission.find(session[:questionnaire_submission_id])
      old_submission.answers.collect{|answer|
        attr={}
        attr=answer.attributes
        attr= attr.delete_if{|key,value| key.to_s=="id"}
        attr=attr.delete_if{|key,value| key.to_s=="created_by"}
        attr=attr.delete_if{|key,value| key.to_s=="updated_by"}
        attr=attr.delete_if{|key,value| key.to_s=="created_at"}
        attr=attr.delete_if{|key,value| key.to_s=="updated_at"}
        attr=attr.delete_if{|key,value| key.to_s=="questionnaire_submission_id"}
        newanswers=attr["type"].constantize.new(attr)
        newanswers.questionnaire_submission_id=@questionnaire_submission.id
        newanswers.save
      }
    end
  end

  def sitemap
    @page_properties = {:page_type => "other_pages"}
    @categories = @site.categories
    @sections = @site.sections
    @tags = @site.tags
    section = Section.where("name = ?", "static-page").first
    @menus = @site.static_articles.published.by_section(section.id).collect{|article|@site.menus.find_by_static_page_name(article.title)}
    if params[:page]
      @articles = @site.articles.latest.paginate(:page => params[:page], :per_page => 100)
    else
    @articles=@site.articles_by_days(5, 100)
    end
    respond_to do |format|
      format.xml{render :layout => false ,:template => @site.get_sitemap_page}
    end
  end

 #def article_report
  #all_articles_details = []
  #unless @site.blank?
  #@site.articles.published.limit(500).each do |article|
   # all_articles_details << {:id => article.id,:title => article.title,:source => article.source.name,:section => article.section.name,:categories=> article.categories.all.collect{|a| a.name},:authors => article.authors.collect{|a| a.name},:medium=>article.primary_medium,:tags => article.tags.collect{|a| a.name},:vedio=>"#{article.media_detail.collect{|a| [a.id,a.name]} if article.media_detail }",:audio=>"#{article.audio.collect{|a| [a.id,a.name]} if article.audio }",:publish_date=>article.publish_date,:display_date=>article.display_date}
  #end
 #end
  #render :json =>  all_articles_details.to_json
#end


end
