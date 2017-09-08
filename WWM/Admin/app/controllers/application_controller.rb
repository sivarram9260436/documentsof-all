class ApplicationController < ActionController::Base
  protect_from_forgery
  def render_partial
    @page_properties = { :selected_menu => 'partail_rendering', :page_type=>params[:page_type]}
    @article=Article.find(params[:article_id]) if params[:article_id]
     render :template=>params[:path],:layout=>@site.get_layout
  end
end
