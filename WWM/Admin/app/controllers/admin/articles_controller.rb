class Admin::ArticlesController < AdminController
def new
  @page_properties={:selected_menu=>'article_menu',:menu_title=>'Article > Create New Article'}
  @article=Article.new
  @article_contents=@article.new_article_content
  @user=@site.users.find(session[:user_id])
  @article_content_edit_counter=0
  @flag="new"
  if params[:type]=="site"
     render :template => 'admin/articles/new',:layout => false unless IS_ADMIN
  else
    respond_with(@article)
  end
 end 
  
def edit
  @page_properties={:selected_menu=>'article_menu',:menu_title=>'Article > Edit Article'}
    sort_init "created_at"
    sort_update
    article = Article.find(params[:id]) 
    @user=@site.users.find(session[:user_id])
    @article = params[:article_content_id] ? article.view_version(article.article_contents.find(params[:article_content_id])) : article.latest_version 
    @site=@article.sites.first
    @page_properties={:selected_menu=>'article_menu',:menu_title=>"Article > Edit Article",:article_title_id=>"- ID: #{@article.id}"}
    @article_content=ArticleContent.find(:first,:conditions=>["article_id=? and id=?",@article.id,params[:article_content_id] || @article.latest_version_id])
    @article_contents=article.article_contents.paginate(:order=>sort_clause,:per_page =>params[:per_page],:page => params[:page])  
    @article_content_edit_counter=@article_contents.count
    @flag="edit" 
end

def newsletter
     @page_properties={:selected_menu=>'newsletter_menu',:menu_title=>'Newsletter List'}
    respond_to do |format|      
      format.html do         
        render :template => "admin/articles/newsletter"
      end
      format.js do        
        render :update do |page|
          page.replace_html 'news',component_table_list(SrComponent.find_component_by_name('NewsletterListNew')),:page => params[:page]
        end
      end
    end    
  end

def tag_creation
    @tag = Tag.where("UPPER(name)=UPPER(?)", params[:name].strip).first
    if @tag.blank?
      tag = ActiveRecord::Base.connection.execute "INSERT INTO tags (name,alias_name) VALUES (#{Tag.sanitize(params[:name])},#{Tag.sanitize(Util.convert_to_url_string(params[:name]))}) RETURNING id"
      site_tag = ActiveRecord::Base.connection.execute "INSERT INTO sites_tags (data_proxy_id,tag_id) VALUES ('#{@site.data_proxy.id}','#{tag.first["id"]}')"
      @tag = Tag.find(tag.first["id"])
    else
      site_tag = ActiveRecord::Base.connection.execute "INSERT INTO sites_tags (data_proxy_id,tag_id) VALUES ('#{@site.data_proxy.id}','#{@tag.id}')" unless @tag.data_proxy_ids.include?(@site.data_proxy.id)
    end
    render :json => { :id => @tag.id }
  end


end

