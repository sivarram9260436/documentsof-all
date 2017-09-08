class Article

def self.send_approval_email(article)
    current_site = Ambient.current_site   
   # if !current_site.config.article.email.blank? #and eval(current_site.config.article.email)
      if !current_site.config.article.approval_email.blank?
      WebMailer.send_approval_request_article(current_site.config.article.approval_email, article,{from: "no-reply@themachinist.kreatio.com"}).deliver if current_site.config.article.approval_email
    elsif  EVENTIVE_TEMPLATE_PATH and !article.for_approval_email.blank?
      WebMailer.send_approval_request_article_eventive(User.find(article.for_approval_email).email, article).deliver if User.find(article.for_approval_email).email
    end
  end

 def tag_ids_new_with_existing=(tag_new_with_existing)
    self.tag_ids = if not tag_new_with_existing["existing"].blank? and tag_new_with_existing["auto_existing"].blank?
                     tag_new_with_existing["existing"]
                   elsif not tag_new_with_existing["auto_existing"].blank? and tag_new_with_existing["existing"].blank?
                     tag_new_with_existing["auto_existing"]
                   elsif not tag_new_with_existing["existing"].blank?
                     tag_new_with_existing["existing"] << tag_new_with_existing["auto_existing"]
                   end
    new_tags=tag_new_with_existing["new"].collect { |new_tag| self.tags.build(:name => new_tag, :tag_type => "ManualTag", :sites => self.sites) } unless tag_new_with_existing["new"].blank?
  end

  def tag_ids_new_with_existing
    self.tags
  end


end

