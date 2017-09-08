class Admin::StaticPageController < AdminController
  before_filter :save_format,:only=>["create","save_and_publish","update","update_and_publish",""]
  def index 
     if params[:entity_type]=="static-fragment"
    @page_properties={:selected_menu=>'static_fragment',:menu_title=>'Static Fragment List'}
    @selected_section = Section.find_by_name("static-fragment")
    else
    @page_properties={:selected_menu=>'static_articles',:menu_title=>'Static Page List'}
    @selected_section = Section.find_by_name("static-page")
    end   
    @article_path="static_page"    
    sort_init "updated_at"
    sort_update               
    #pagination_properites(true,"updated_at",30)
    @sections=@site.static_sections.delete_if{|section| section.name=="dynamic-page"} 
    respond_to do |format|      
      format.html do         
        render :action => "index",  :layout => false if  request.xhr?
      end
      format.js do        
        render :update do |page|
          page.replace_html 'article_list', component_table_list(SrComponent.find_component_by_name("static_article_list_new")) 
        end
      end
    end
  end  
  
  def show
    if params[:entity_type]=="static-fragment"
    @page_properties={:selected_menu=>'static_fragment',:menu_title=>'Static Fragment List'}
    else
    @page_properties={:selected_menu=>'static_articles',:menu_title=>'Static Page List'}
    end
          
  end
  
  def select_fragment
    if params[:entity_type]=="static-fragment"
    @page_properties={:selected_menu=>'static_fragment',:menu_title=>'Static Fragment List'}
    else
    @page_properties={:selected_menu=>'static_articles',:menu_title=>'Static Page List'}
    end    
          @article=Article.find(params[:article_id]) if params[:article_id]!="NaN"
          @article_content=ArticleContent.find(:first,:conditions=>["article_id=? and id=?",@article.id,params[:article_content_id] || @article.latest_version_id]) if params[:article_id]!="NaN"
          render :partial=>"/admin/static_page/static_partial"      
  end

  def new_static
    if params[:entity_type]=="static-fragment"
    @page_properties={:selected_menu=>'static_fragment',:menu_title=>'New Static Fragment'}
    else
    @page_properties={:selected_menu=>'static_articles',:menu_title=>'New Static Page'}
    end
       @article=Article.new
       @article_contents=@article.article_contents.new()
       @article_path=(params[:article_path]||params[:entity_type])
       @section_type=params[:section_type]
       @article.section=Section.find_by_name(params[:section_type])
       @media_detail=MediaDetail.find(:first,:conditions=>["id=?",params[:article][:media_detail_id]]) if params[:article] and params[:article][:media_detail_id]      
      #@page_properties={:selected_menu=>'static_article',:menu_title=>'Static Manager'}
        if request.xhr?
        render :layout => false
        end
   end
   def new_static_fragment
    if params[:entity_type]=="static-fragment"
    @page_properties={:selected_menu=>'static_fragment',:menu_title=>'New Static Fragment'}
    else
    @page_properties={:selected_menu=>'static_articles',:menu_title=>'New Static Page'}
    end
       @article=Article.new
       @article_contents=@article.article_contents.new()
       #@article_path=params[:article_path]
       @article_path=(params[:article_path]||params[:entity_type])
       @section_type=params[:section_type] 
       @article.section=Section.find_by_name(params[:section_type])
       @media_detail=MediaDetail.find(:first,:conditions=>["id=?",params[:article][:media_detail_id]]) if params[:article] and params[:article][:media_detail_id]
      #@page_properties={:selected_menu=>'static_article',:menu_title=>'Static Manager'}
        if request.xhr?
        render :layout => false 
        end
   end 


  def new 
    if params[:entity_type]=="static-fragment"
    @page_properties={:selected_menu=>'static_fragment',:menu_title=>'Static Fragment > Create New Static Fragment'}
    else
    @page_properties={:selected_menu=>'static_articles',:menu_title=>'Static Page > Create New Static Page'}
    end
    @article=Article.new
    @article_contents=@article.article_contents.new()
    @article_path=(params[:article_path]||params[:entity_type])
    @section_type=(params[:section_type]||params[:entity_type])      
    @article.section=Section.find_by_name( params[:section_type])
    @media_detail=MediaDetail.find(:first,:conditions=>["id=?",params[:article][:media_detail_id]]) if params[:article] and params[:article][:media_detail_id]      
    #@page_properties={:selected_menu=>'static_articles',:menu_title=> (params[:section_type]== "static-fragment" ? "Create New Static fragment" : "Create New Static Page")}
        if request.xhr?
        render :layout => false
        end
  end
  
  
 def create
      if params[:entity_type]=="static-fragment"
    @page_properties={:selected_menu=>'static_fragment',:menu_title=>'Static Fragment > Create New Static Fragment'}
    else
    @page_properties={:selected_menu=>'static_articles',:menu_title=>'Static Page > Create New Static Page'}
    end
    db_status= sr_transaction_block(Article) {|status|
      status,@article=Article.create_common(params[:article],params[:commit],status)
      status
    }
    @article_content = @article.new_article_content
    @section_type=@article.section.name if @section_type
    @format_value=(@article.format).split("+") if @section_type == "static-fragment"
   
    if db_status
      flash[:notice] = "#{@article.section.name} #{@article.title}"+ ' was successfully created.'
      if  request.xhr?
        redirect_to :action => 'index' ,:entity_type => params[:entity_type]
        #session[:return_static_path]=request.referer
      else
        redirect_to :action => 'index',:entity_type => params[:entity_type]
         session[:return_static_path]=request.referer
      end
    else
      render :action => 'new'
    end
  end

  def save_and_publish
      if params[:entity_type]=="static-fragment"
    @page_properties={:selected_menu=>'static_fragment',:menu_title=>'Static Manager'}
    else
    @page_properties={:selected_menu=>'static_articles',:menu_title=>'Static Manager'}
    end  
      
    db_status= sr_transaction_block(Article) {|status| 
      status,@article=Article.save_common(params[:article],status)
      status 
    }
    @article_content = @article.new_article_content
    @section_type=@article.section.name if @article.section
     @format_value=(@article.format).split("+") if @section_type == "static-fragment"
   
    if db_status    
      flash[:notice] = " #{@article.section.name} #{@article.title}"+ ' was successfully created.'
      if params[:entity_type]=="static-page" or params[:entity_type]=="static-fragment"
        #redirect_to :action => 'static_articles'
        #redirect_to :action => 'edit',:id=>@article.id,:section_type=>params[:section_type]    
        redirect_to :action => 'index', :entity_type => params[:entity_type]
      elsif params[:section_type]=="spotlight"
        redirect_to :action => 'spotlight' ,:section_type=>"spotlight"
      elsif params[:section_type]=="alternate_home_page"
        redirect_to :action => 'alternate_home_page' ,:section_type=>"alternate_home_page"
      end
    else      
      render :action => 'new'
    end
  end
  
  def edit
    if params[:entity_type]=="static-fragment"
    @page_properties={:selected_menu=>'static_fragment',:menu_title=>'Static Fragment > Edit Static Fragment'} 
    else
    @page_properties={:selected_menu=>'static_articles',:menu_title=>'Static Page > Edit Static Page'}
    end 
    @article = Article.find(params[:id]) 
    @article = @article.latest_version   
    @section_type=@article.section.name
    #@page_properties={:selected_menu=>'static_article',:menu_title=>"Edit Static Page"}    
    @article_content=ArticleContent.find(:first,:conditions=>["article_id=? and id=?",@article.id,params[:article_content_id] || @article.latest_version_id])
    #@page_properties={:selected_menu=>'static_articles',:menu_title=>"Edit Static Fragment"} if @section_type == "static-fragment"
    @format_value=(@article.format).split("+") if @section_type == "static-fragment"
    logger.info"=========@fmt====#{@format_value}======================="   
    @flag="edit" if @section_type == "static-fragment"      
  end
  
  
  def update
     if params[:entity_type]=="static-fragment"
    @page_properties={:selected_menu=>'static_fragment',:menu_title=>'Static Manager'}
    else
    @page_properties={:selected_menu=>'static_articles',:menu_title=>'Static Manager'}
    end 
     @article = Article.find(params[:article][:id])     
    db_status= sr_transaction_block(Article) {|status|
      status,@article= Article.update_common(@article,params[:article],params[:commit],status)
      status 
    }
    @section_type=@article.section.name
    @format_value=(@article.format).split("+") if @section_type == "static-fragment"
    @article_content = @article.new_article_content
    flash[:notice] = " #{ @article.section.name} #{@article.title}"+ ' was successfully updated.'
    #flash[:notice] = 'Article '+"#{@article.title}"+ ' was successfully created.'
    if db_status 
      #redirect_to :action => 'edit',:section_type=>params[:section_type],:id=> params[:article][:id]   
      if  request.xhr?
        render :action => 'index',:layout => false
        session[:return_static_path]=request.referer
      else
        redirect_to :action => 'index', :entity_type => params[:entity_type]
      end 
    else
      render :action => 'edit',:entity_type => params[:entity_type]
    end   
    
  end
  
  def update_and_publish
     if params[:entity_type]=="static-fragment"
    @page_properties={:selected_menu=>'static_fragment',:menu_title=>'Static Fragment'}
    else
    @page_properties={:selected_menu=>'static_articles',:menu_title=>'Static Page'}
    end  
     @article = Article.find(params[:article][:id])   
    db_status= sr_transaction_block(Article) {|status|
      status,@article=Article.update_and_publish_common(@article,params[:article],status)
      status
    }      
    @article_content = @article.new_article_content
    @section_type=@article.section.name
    @format_value=(@article.format).split("+") if @section_type == "static-fragment"
    if db_status      
      flash[:notice] = " #{@article.section.name } #{@article.title}"+ ' was successfully updated.'      
      if params[:article_static] and params[:article_static][:path]=="spotlight"
        redirect_to :action => 'spotlight',:section_type=>'spotlight'
      elsif  params[:article_static] and params[:article_static][:path]=="alternate_home_page"
        redirect_to :action => 'alternate_home_page' ,:section_type=>"alternate_home_page"  
      else
        redirect_to :action => 'index', :entity_type => params[:entity_type]
        #redirect_to :action => 'edit',:section_type=>params[:section_type] ,:id=> params[:article][:id]
      end
    else
      render :action => 'edit',:entity_type => params[:entity_type]
    end   
  end
  
  def static_page    
    @page_id=params[:page_type]    
  end
  
  def preview   
    begin
      @article=@site.all_articles.find(params[:id])
    rescue
      @article =nil
    end
    if @article
      @page_properties={:menu_title=>@article.title}
      @selected_menu=@site.menus.get_selected_menu(@article)
      render :template=>@site.get_template(@article),:layout=>@site.get_layout
    else
      redirect_to :action=>'render_404'
    end
  end
  
  def preview_before_save    
    @article=Article.new(params[:article])
    @article.id="10000"  # We need some id to generate  url using named scope, it will throw error if id in nil     
    @article_content = ArticleContent.new(params[:article_content]) 
    @article.title=@article_content.title
    @article.tags=@article_content.tags
    @article.categories=@article_content.categories
    @article.sites=@article_content.sites
    @article.article_contents << @article_content      
    @site=Site.find(session[:site_id])  
    authors=Author.find(params[:article_content][:author_ids]) if params[:article_content][:author_ids]
    @article.authors=authors params[:article_content][:author_ids]
    @article.preview_article_content(@article_content)      
    @page_properties={:menu_title=>@article.title}
    @preview=false
    if @article.section!=nil
      render :template=>@site.get_template(@article),:layout=>@site.get_layout
    else
      @flag="no_section"
      render :action=>"new",:layout=>false ,:flag=>@flag
    end
  end
  
  
  def filter_by_article
    @page_properties={:selected_menu=>'article_menu',:menu_title=>'Articles'}                        
    if params[:active]!=nil
      if params[:active]=="yes"      
        condition="published is true"
      else
        condition="published is false"
      end
      @articles=@site.all_articles.sr_paginate(:all,:conditions=>[condition],:order=>"updated_at desc",:per_page => 30,:page => params[:page])
    end 
    if params[:author_id]!=nil
      author=Author.find(params[:author_id])
      @articles=@site.articles_by_author(author).sr_paginate :per_page => 30,:page => params[:page]
    end     
    respond_to do |format|
      format.html do
        render :action => 'index'
      end
      format.js do        
        render :update do |page|
          page.replace_html 'article_list', :partial => "list_of_articles",:page => params[:page]
        end
      end
    end
  end
  
  #separate the article search for article page , static_page, dynamic_page
  
  
  
  def advance_search 
   if params[:entity_type]=="static-fragment"
    @page_properties={:selected_menu=>'static_fragment',:menu_title=>'Static Fragment List'}
    else
    @page_properties={:selected_menu=>'static_articles',:menu_title=>'Static Page List'}
    end 
    @search=true 
    @search_data=SearchData.new(params[:search_data]) if params[:search_data] 
    @article_path="static_page" 
    @selected_section=@site.static_sections.find(params[:search_data][:section_id]) if params[:search_data] and params[:search_data][:section_id]!=""
    session[:per_page]=params[:per_page] if params[:per_page]!=nil
    sort_init "updated_at"
    sort_update
    respond_to do |format|
      format.html do                
        render :action=>"index" ,:entity_type => params[:entity_type]
      end
      format.js do
        render :update do |page|            
          page.replace_html 'article_list',component_table_list(@site.find_component_by_name("static_article_search"))
        end
      end
    end 
  end
  
  def advance_search_view 
    if params[:entity_type]=="static-fragment"
    @page_properties={:selected_menu=>'static_fragment',:menu_title=>'Static Fragment List'}
    else
    @page_properties={:selected_menu=>'static_articles',:menu_title=>'Static Page List'}
    end 
    @articles_json = Article.new # for advance_search getting the category
    render :layout=>false
  end  
  
  def publish_article
    @article = Article.find(params[:id])
    @article.update_attributes(:active=>true)   
    @article.publish            
    redirect_to :controller=>"admin/login",:action=>"author_index"
  end
  
  
  def show_all_histories
    sort_init "created_at"
    sort_update
    @article=@site.all_articles.find(params[:id])
    @article_contents=@article.article_contents.sr_paginate(:all,:order=>sort_clause,:per_page =>params[:per_page],:page => params[:page]) 
    @page_properties={:selected_menu=>'article_menu',:menu_title=>"History for Article Version #{@article_contents.last.id}"}                    
    render :layout=>false
  end
  
  def show_diff
    @article=@site.all_articles.find(params[:article_id])
    @article_version1=ArticleContent.find(params[:version_1])
    @article_version2=ArticleContent.find(params[:version_2])
    @page_properties={:selected_menu=>'article_menu',:menu_title=>"History for Article Version"}     
    render :layout=>false               
  end
  
  def assign_version
    @article = Article.find(params[:id])
    if params[:article_path]=="static_page" 
      @page_properties={:selected_menu=>'static_articles',:menu_title=>"Static Manager"}      
      @sections=@site.static_sections.delete_if{|section| section.name=="dynamic-page"}
    elsif params[:article_path]=="dynamic_page"
      @page_properties={:selected_menu=>'dynamic_articles',:menu_title=>'Dynamic Manager'}  
      @sections=@site.static_sections.find_all_by_entity_type_and_name("Static","dynamic-page")            
    else
      @page_properties={:selected_menu=>'article_menu',:menu_title=>"Articles > Edit Article",:article_title_id=>"- ID: #{@article.id}"}      
      @sections=@site.sections
    end
    @article_path=params[:article_path]
    @article_content=ArticleContent.find(params[:selected_version])
    @flag="edit"
    render :action=>"edit" 
  end
  #further reading starts
  def further_reading    
    @page_properties={:selected_menu=>'ranked_list_menu',:menu_title=>'New Ranked List'}                                       
    @featured_set = FeaturedSet.new
    @featured_articles = []   
    @further_reading_list =[]   
    @selected_article=params[:assign_id].split(",").collect{|article_id| Article.find(article_id)} if params[:assign_id]
    @article=@site.all_articles.find(params[:article_id]) if params[:article_id] and params[:article_id]!="new" and params[:article_id]!="undefined"
    @further_reading_list = @article.further_readings if @article!=nil         
    @further_reading_list += @selected_article if  @selected_article    
    @latest_articles = @site.paginate_not_expired_latest_articles(10,params[:page])
    @most_rated_articles = @site.paginate_not_expired_most_read_articles(10,params[:page])   
    @sources= @site.sources.find(:all,:select=>"name as text,id as value,'advance_search[source_ids][]' as name").to_json 
    respond_to do |format|
      format.html do
        render :action => 'further_reading_new',:layout=>false
      end
      format.js do        
        render :update do |page|
          if params[:type]=="latest"           
            page.replace_html 'latest_article_container', :partial => '/admin/ranked_list/featured_result',:locals=>{:results=>@latest_articles,:type=>'latest'}
          else
            page.replace_html 'most_rated_container', :partial => '/admin/ranked_list/featured_result',:locals=>{:results=>@most_rated_articles,:type=>'most_rated'}
          end 
        end
      end
    end
  end
  
  def static_fragment_content
      if params[:entity_type]=="static-fragment"
    @page_properties={:selected_menu=>'static_fragment',:menu_title=>'Static Manager'}
    else
    @page_properties={:selected_menu=>'static_articles',:menu_title=>'Static Manager'}
    end  
    params[:article_path]="static_page"
    @sections=@site.static_sections.delete_if{|section| section.name=="dynamic-page"}
    @load_tiny_mce=@site.static_sections.find(params[:article][:section_id])
    @article=Article.new(params[:article])   
    #@article_content = ArticleContent.new(params[:article_content])  
    #@article.article_contents << @article_content   
    @article_further_reading_ids=params[:article][:article_further_reading_ids] if params[:article][:article_further_reading_ids]    
    render :action => 'new'
  end
  
  
  def spotlight
    params[:section_type]="spotlight"
    if @site.config.spotlight.spotlight == "true"
      @article=@site.spotlight_article.first  
      #puts @article.inspect     
      @article_content=ArticleContent.find(:first,:conditions=>["article_id=? and id=?",@article.id,@article.latest_version_id]) if @article        
      if @article==nil       
        @page_properties={:selected_menu=>'spotlight_new',:menu_title=>'Spotlight > Create Spotlight Day Homepage Template'}
        @section_type=params[:section_type] 
        @section_type="spotlight" if params[:section_type]==nil or params[:section_type]==""       
        render :action=>"new"        
      else      
        @page_properties={:selected_menu=>'spotlight_edit',:menu_title=>'Spotlight > Edit Spotlight Day Homepage Template'}
        @section_type=params[:section_type] 
        @section_type="spotlight" if params[:section_type]==nil or params[:section_type]==""        
        render :action=>"edit"
      end  
    else
      @page_properties={:selected_menu=>'spotlight_page',:menu_title=>'Spotlight > Edit Spotlight Day Homepage Template'}
      @section_type=params[:section_type] 
      @section_type="spotlight" if params[:section_type]==nil or params[:section_type]==""        
      render :text=>"<h3>Please assign the spotlight facility in Site Property</h3>",:layout=>true
    end
  end
  
  def alternate_home_page 
    params[:section_type]="alternate_home_page"  
    if @site.config.alternate_home_page.enable == "true"
      @article=@site.alternate_home_page_article.first       
      @article_content=ArticleContent.find(:first,:conditions=>["article_id=? and id=?",@article.id,@article.latest_version_id]) if @article        
      if @article==nil       
        @page_properties={:selected_menu=>'alternate home new page',:menu_title=>'Alternate Home Page > Create Alternate Homepage Template'}
        @section_type=params[:section_type] 
        @section_type="alternate_home_page" if params[:section_type]==nil or params[:section_type]==""       
        render :action=>"new"        
      else      
        @page_properties={:selected_menu=>'alternate home edit page',:menu_title=>'Alternate Home Page > Edit Alternate Homepage Template'}
        @section_type=params[:section_type] 
        @section_type="alternate_home_page" if params[:section_type]==nil or params[:section_type]==""        
        render :action=>"edit"
      end  
    else
      @page_properties={:selected_menu=>'alternate home index page',:menu_title=>'Alternate Home Page > Edit Alternate Homepage Template'}
      @section_type=params[:section_type] 
      @section_type="alternate_home_page" if params[:section_type]==nil or params[:section_type]==""        
      render :text=>"<h3>Please assign the Alternate Home Page facility in Site Property</h3>",:layout=>true
    end
  end
  
  def spellchecker
    headers["Content-Type"] = "text/plain"
    headers["charset"] = "utf-8?"
    suggestions = check_spelling(params[:params][1], params[:method], params[:params][0])
    results = {"id" => nil, "result" => suggestions, "error" => nil}
    render :text => results.to_json
    return
  end 
  
  def update_volumn_and_issue
    @specif_magazine_issues =[]
    @specif_magazine_issues << MagazineIssue.find_all_by_source_id(params[:article][:source_id]) if params[:article] and !params[:article][:source_id].blank?
    render :partial => 'volumn_issue_form'
  end
  
  def preview_article
    redirect_to preview_article_url(:host=>@site.name,:submitted=>Crypto.encrypt((Time.sr_now+300).to_s),:params=>(params[:article] ? params[:article] : params).dup.delete_if{|key,value| ["action","controller"].include?key})
  end
  
  def update_time
    respond_to do |format|      
      format.js do        
        render :update do |page|
          page.replace_html 'preview_article', :partial => "preview_article_form",:locals=>{:submitted=>Crypto.encrypt((Time.sr_now+300).to_s)}
        end
      end   
    end     
  end
  private
  def save_format
    #return create
    params[:article][:format]=params[:article][:format] + "+" + params[:format].values.join("+") if params[:format]
  end
end
