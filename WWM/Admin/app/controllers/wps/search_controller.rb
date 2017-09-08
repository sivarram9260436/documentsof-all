class Wps::SearchController < WpsController
   def search
    @selected_menu=@site.get_selected_menu(:others=>"Home")
    search_all = true if params[:date] == "all"
    params.delete_if {|key, value| key == "date" and value == "all" }
    params[:query] =" " if params[:query].blank?
    params[:query] = params[:query].gsub("?","")
    params[:sort] = (@site.config.search.default_sort_filter  || "Relevance") if params[:sort].blank?
    params[:blog_search] = "true" if params[:search_entity]=="blog"
    params[:blog_name] = @site.blogs.collect(&:name).join(',') if ((params[:search_entity] == "true" and params[:blog_name].blank?) and params[:entity]!="blog")
    unless params[:query].blank?
      popular_query_audit
    end
    filters=Util.filter_mapping(params)
    filters[:data_proxy] = [@site.data_proxy_id].flatten
   logger.info "===================================#{filters}======================"
    if params[:search] and not params[:search] == 'all'
     if  params[:search] and  params[:search] == 'case-study'
      filters = filters.merge(WWM_FILTER[params[:search].gsub('-','_').to_sym])
     else
      filters = filters.merge(WWM_FILTER[params[:search].to_sym]) if params[:search] and not params[:search] == 'all'
      end
    end
    @articles=[]
    fields = params[:search_fields].blank? ? [] : params[:search_fields] 
   # logger.info "===================================#{fields}======================"
    if params[:facet] == "true"
      @articles=Article.search_by_search_engine(params[:query],params[:page],params[:per_page],params[:sort],filters, ["categories_names", "section_name", "year_based", "source_alais_name"], fields)
    else
      @articles=Article.search_by_search_engine(params[:query],params[:page],params[:per_page],params[:sort],filters)
      @video_articles = Article.search_by_search_engine(params[:query],1,params[:per_page],params[:sort],{:primary_medium=>'video',:data_proxy=> [@site.data_proxy_id].flatten}) unless @articles.blank?
      @sponsored_articles = Article.search_by_search_engine(params[:query],1,params[:per_page],params[:sort],{:data_proxy=> [@site.data_proxy_id].flatten}).results.select {|n| !n.sponsored.blank?}  unless @articles.blank?
  logger.info "================#{@video_articles}===================#{@articles.inspect}======================"  
  end
    params[:date] = "all" if search_all
    @search_data = SearchData.new(params)
   @page_properties={:menu_title=>@site.config.search.home_title,:page_type=>"search_page"}
   respond_to do |format|
     format.html do
       render :template=>@site.search_page(params[:search_entity]),:layout=>@site.get_layout
        end
      format.rss do
        render :template=>"#{@site.search_page(params[:search_entity])}-rss",:layout=>false
      end
    end
#    render :template => "/home/search_maintenance", :layout => @site.get_layout
  end

  def popular_query_audit
    query_text = PopularSearchPerDay.where("UPPER(query_text) = UPPER(?)", "params[:query].upcase.strip")
    unless query_text.blank?
      query_text.count += 1
     else 
      @site.popular_search_per_day.create(:query_text=>"#{params[:query].strip}",:count=>1,:search_type=>"Article")
    end
  end

end
