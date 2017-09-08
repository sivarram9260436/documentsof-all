
module SortHelper

 
  def sort_link(column, caption=nil)
    key, order = session[@sort_name][:key], session[@sort_name][:order]
    if key == column
      if order.downcase == 'asc'
        icon = 'sort_asc.png'
        order = 'desc'
      else
        icon = 'sort_desc.png'
        order = 'asc'
      end
    else
      icon = nil
      order = 'desc' # changed for desc order by default
    end
    caption = titleize(Inflector::humanize(column)) unless caption
 url = {:sort_key => column, :sort_order => order, :site_id=>params[:site_id], :advance_search=>params[:advance_search],:search_data=>params[:search_data],:art=>params[:art],:tag=>params[:tag],:roles_search=>params[:roles_search],:entity_type=>params[:entity_type]}
 #    link_to_remote(caption,{:update => "contentArea", :url => url},{:href => url_for(url)}) +(icon ? nbsp(2) + image_tag(icon) : '')
             link_to(caption,url,:class=>'sorting_links') +(icon ? image_tag(icon) : '')
 
  end
end
