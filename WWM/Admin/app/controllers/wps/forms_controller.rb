class Wps::FormsController < WpsController
 # def search_page
  #  @page_properties={:page_type=>"search_page"}
   # @query = (params[:query].blank? ? " "  : params[:query])
   # filter={}
   # if params["filter_type"] == 'section'and params["filter_value"] =='case-study'
    #  filter= {params["filter_type"].to_sym=>'Case study',:data_proxy=>@site.id}
   # elsif params["filter_type"] != 'all'and params["filter_value"] !='all'
    #  filter= {params["filter_type"].to_sym=>params["filter_value"],:data_proxy=>@site.id}
  #  elsif params["filter_type"] == 'all'and params["filter_value"] =='all'
   #    filter= {:data_proxy=>@site.id}
   # end
   # @articles = Article.search_by_search_engine(@query,params[:page],8,"Relavance",filter)
   # if params[:type].blank?
   # @video_articles = @articles.results.select {|n| n.primary_medium =='video' || n.primary_medium =='audio'} if not @articles.blank? and  params["filter_type"] == 'all'and params["filter_value"] =='all'
   # @sponsored_articles = @articles.results.select {|n| !n.sponsored.blank?}  if not  @articles.blank? and  params["filter_type"] == 'all'and params["filter_value"] =='all'
   # render :template=>"/search/search_result",:layout=>@site.get_layout
   # else
   # render :action=>request.referer
   # end
 # end

def search_page
    @page_properties={:page_type=>"search_page"}
    @query = (params[:query].blank? ? " "  : params[:query])
    filter={}
    if params["filter_type"] == 'section'and params["filter_value"] == 'white-papers'
      filter= { params["filter_type"].to_sym=>"White Papers",:data_proxy=>@site.id}
    elsif params["filter_type"] != 'all'and params["filter_value"] !='all'
       filter = ((WWM_FILTER[params["filter_value"]]).merge({:data_proxy=>@site.id}))
     #filter = ((WWM_FILTER[params["filter_value"].to_sym]))
    elsif params["filter_type"] == 'all'and params["filter_value"] =='all'
       filter= {:data_proxy=>@site.id}
    end
    per_page = (params[:per_page].to_i == 0 ? 1 : params[:per_page])
    @articles = Article.search_by_search_engine(@query,params[:page],per_page,"Relavance",filter)
    logger.info "======================articles========#{@articles.results.collect(&:section_name).inspect}=============================="
    if params[:type].blank?
    render :template=>"/search/search_result",:layout=>@site.get_layout
    else
    render :action=>request.referer
    end
  end


end
