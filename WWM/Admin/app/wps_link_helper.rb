module Wps::WpsLinkHelper
include Rails.application.routes.url_helpers

 def result_count_for_search(query="",page="",per_page="",sort="",filter = {},search)
    query= (query == {} ? "" : query)
    sort = (@site.config.search.default_sort_filter  || "Relevance")
    if search == "all"
       Article.search_by_search_engine(query,"","","",{:data_proxy=>@site.data_proxy_id}).results.total_entries
    else
    # filters = filter.merge(WWM_FILTER[search.gsub("-","_").to_sym])
     filters = filter.merge(WWM_FILTER[search])
     filters[:data_proxy] = [@site.data_proxy_id].flatten
     Article.search_by_search_engine(query,page,per_page,sort,filters).results.total_entries
    end
   end

end
