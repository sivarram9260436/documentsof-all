class Admin::RankedListController < AdminController
  #  before_filter :session_expire_author,:select_site,:site_admin
  # before_filter :site_admin
  # layout 'sites'

  def index
     sort_init "updated_at"
    sort_update
    session[:return_ranklist_path]=request.referer if params[:type]== "datalist"
   @page_properties={:selected_menu=>(params[:entity_type].blank? ? 'ranked_list_menu' : "ranked_list_#{params[:entity_type]}_menu"),:menu_title=>(params[:entity_type].blank? ? "Ranked List" :  "#{params[:entity_type].gsub('_',' ')} Ranked List" )}
    respond_to do |format|
      format.html do
        render :action => "index",  :layout => true
      end
      format.js do
        render :update do |page|
          page.replace_html 'article_list', component_table_list(SrComponent.find_component_by_name("new_ranked_list"))
        end
      end
    end
  end

  def create 
      @page_properties={:selected_menu=>'ranked_list_menu',:menu_title=>'New Ranked List'} 
      @featured_set = FeaturedSet.new
      @featured_set.name=params[:featured][:name]
      @featured_set.expire_status=params[:featured][:expire_status]
      @featured_set.expire_date=params[:featured][:expire_date]
      @featured_set.entity_type="DataProxy"
      @featured_set.entity_id=@site.data_proxy_id
      @featured_set.model_name = params[:entity_type].blank? ? "Article" : params[:entity_type].capitalize
      if @featured_set.save(:validate=>false)
       unless params[:entity_type].blank?
         @featured_set.digital_asset_ids=(params[:listTaken])
       else
         @featured_set.article_ids=(params[:listTaken])
       end
        if !!request.xhr?
         render :json=>{:path => "/admin/ranked_list/edit/#{@featured_set.id}?flag=true" ,:message => "Ranked List Saved Successfully"}
        elsif params[:flag] == "save"                
        flash[:notice] = 'Ranked list was successfully saved.'     
        if params[:path] != "list"
          session[:return_ranklist_path].nil? ? (redirect_to :action=>"edit",:id=>@featured_set.id,:entity_type=>params[:entity_type]):(redirect_to session[:return_ranklist_path],:entity_type=>params[:entity_type])
        else
          redirect_to :action=>"index",:entity_type=>params[:entity_type]
        end          
       else
          session[:return_ranklist_path].nil? ? (redirect_to :action=>"index",:entity_type=>params[:entity_type]):(redirect_to session[:return_ranklist_path],:entity_type=>params[:entity_type])
       end
      else
        render :action=>"new"    
      end    
  end
  
    def new
    @page_properties={:selected_menu=>'ranked_list_menu',:menu_title=>'New Ranked List'}                                       
    @featured_set =  @site.featured_sets.new
    @featured_articles = []
        if !!request.xhr?
      if params[:type]=="latest" 
           render :partial => '/admin/ajax_partials/pagination_list' ,:locals =>{:results=>@latest_articles,:type =>'latest',:component_hash => SrComponent.find_component_by_name("latest_article_tab")}                     
          elsif params[:type]=="asset_group_article" 
            render :partial => '/admin/ajax_partials/pagination_list' ,:locals =>{:results=>@asset_group_articles,:type =>'asset_group_article',:component_hash => SrComponent.find_component_by_name("asset_group_tab")}      
          elsif params[:entity_type]=="digital_asset"
            render :partial => '/admin/ajax_partials/pagination_list' ,:locals =>{:results=>@digital_assets,:type =>'asset_group_article',:component_hash => SrComponent.find_component_by_name("latest_asset_tab")}      
          else
            render :partial => '/admin/ajax_partials/pagination_list' ,:locals =>{:results=>@most_rated_articles,:type =>'most_rated',:component_hash => SrComponent.find_component_by_name("most_rated_article_tab")}            
          end
        else
      render :action => 'new'      
    end
  end
  
    def edit   
    @page_properties={:selected_menu=>'ranked_list_menu',:menu_title=>'Edit Ranked List'}   
    @featured_set = FeaturedSet.find(params[:id])   
    @featured_articles= @featured_set.featured_articles   
    @latest_articles = @site.paginate_not_expired_latest_articles(10,params[:page])
    @most_rated_articles = @site.paginate_not_expired_most_read_articles(10,params[:page])
    @asset_group_articles = @featured_set.asset_group.all_articles.paginate(:page => params[:page],:per_page =>10).order('display_date desc') if @featured_set.asset_group
    if !!request.xhr?
      if params[:type]=="latest" 
           render :partial => '/admin/ajax_partials/pagination_list' ,:locals =>{:results=>@latest_articles,:type =>'latest',:component_hash => SrComponent.find_component_by_name("latest_article_tab")}                     
          elsif params[:type]=="asset_group_article" 
            render :partial => '/admin/ajax_partials/pagination_list' ,:locals =>{:results=>@asset_group_articles,:type =>'asset_group_article',:component_hash => SrComponent.find_component_by_name("asset_group_tab")}      
          elsif params[:entity_type]=="digital_asset"
            render :partial => '/admin/ajax_partials/pagination_list' ,:locals =>{:results=>@digital_assets,:type =>'asset_group_article',:component_hash => SrComponent.find_component_by_name("latest_asset_tab")}           
          else
            render :partial => '/admin/ajax_partials/pagination_list' ,:locals =>{:results=>@most_rated_articles,:type =>'most_rated',:component_hash => SrComponent.find_component_by_name("most_rated_article_tab")}            
          end
        else
       if params[:flag] == "true"
          flash[:notice] = 'Ranked list was successfully saved.'
       end   
      render :action => 'edit'      
    end
 end
  
  def update
      @featured_set = FeaturedSet.find(params[:featured_set]) 
      @featured_set.entity_type="DataProxy"
      @featured_set.entity_id=@site.data_proxy_id   
      @featured_set.name=params[:featured][:name]
      @featured_set.model_name = params[:entity_type].blank? ? "Article" : params[:entity_type].capitalize
      @featured_set.expire_status=params[:featured][:expire_status]
      @featured_set.expire_date=params[:featured][:expire_date]
      @featured_set.article_ids=(params[:listTaken].uniq)
      @featured_set.save(:validate=>false)
      unless params[:entity_type].blank?
         @featured_set.digital_asset_ids=(params[:listTaken])
      else
         @featured_set.article_ids=(params[:listTaken])
      end
       if !!request.xhr?
         render :json=>{:path => "/admin/ranked_list/edit/#{@featured_set.id}?flag=true" ,:message => "Ranked List Saved Successfully"}
      elsif params[:flag] == "save"
        flash[:notice] = 'Ranked list was successfully saved.'
        if params[:path] != "list"
            session[:return_ranklist_path].nil? ? (redirect_to :action=>"edit" , :id=>@featured_set.id,:entity_type=>params[:entity_type]):(redirect_to session[:return_ranklist_path],:entity_type=>params[:entity_type])
        else
        redirect_to :action=>"index",:entity_type=>params[:entity_type]
        end
      else
        session[:return_ranklist_path].nil? ? (redirect_to :action=>"index",:entity_type=>params[:entity_type]):(redirect_to session[:return_ranklist_path],:entity_type=>params[:entity_type])
      end
  end
end
