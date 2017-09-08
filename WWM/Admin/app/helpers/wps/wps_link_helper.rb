module Wps::WpsLinkHelper
  def check_rating(entity,subscriber)
    entity.ratings.where(:subscriber_id => subscriber.id).first.blank? ? true : false if subscriber
  end
 
  def check_rating(entity,subscriber)
    entity.ratings.where(:subscriber_id => subscriber.id).first.blank? ? true : false if subscriber
  end

  def link_to_search_page(display_name,filter_type,filter_value,options={}, html_options = nil)
     link_to display_name ,search_filter_path({:filter_type=>filter_type.to_sym,:filter_value=>filter_value}.merge(options)), html_options
  end

  def check_rating(entity,subscriber)
    entity.ratings.where(:subscriber_id => subscriber.id).first.blank? ? true : false if subscriber
  end

  #def result_count_for_search(query="",page="",per_page="",sort="",filter = {},search)
   # query= (query == {} ? "" : query)
   # sort = (@site.config.search.default_sort_filter  || "Relevance")
    #if search == "all"
    # Article.search_by_search_engine(query,"","","",{:data_proxy=>@site.data_proxy_id}).results.total_entries
   # else
    # filters = filter.merge(NINE_DOT_NINE_FILTER[search.gsub("-","_").to_sym])
    # filters[:data_proxy] = [@site.data_proxy_id].flatten
     #Article.search_by_search_engine(query,page,per_page,sort,filters).results.total_entries
   # end
  # end

  def result_count_for_search(query="", page="", per_page="", sort="", filter = {}, search)
    query= (query == {} ? "" : query)
    sort = (@site.config.search.default_sort_filter || "Relevance")
    if search == "all"
      Article.search_by_search_engine(query, "", "", "", {:data_proxy => @site.data_proxy_id}).results.total_entries
    else
      # filters = filter.merge(WWM_FILTER[search.gsub("-","_").to_sym])
      filters = filter.merge(WWM_FILTER[search])
      filters[:data_proxy] = [@site.data_proxy_id].flatten
      Article.search_by_search_engine(query, page, per_page, sort, filters).results.total_entries
    end
  end


  def media_detail_image(article,width,height)
   unless article.media_detail.blank?
    unless article.media_detail.external_image_url.blank?
      article.media_detail.external_image_url
    else
      article.media_detail.image.resized_image(width,height).image_path unless article.media_detail.image.blank?
    end
    end
 end
 
  def media_detail_video(article)
    unless article.media_detail.blank?
       unless article.media_detail.external_video_url.blank?
         article.media_detail.external_video_url
       else
         article.media_detail.video_path
       end
    end
  end
  
    def link_to_directory_listings_category_page(display_name,category,html_options=nil)     
    link_to display_name, url_for_directory_listings_category_page(category),html_options
  end

  def url_for_directory_listings_category_page(category,options={})
    if options[:obsolute_path]
      other_options={:host=>@site.name}
      directory_listings_category_url({:directory_name=>directory_name,:name=>category.full_alias_name}.merge(other_options))
    else
      directory_listings_category_path({:directory_name=>directory_name,:name=>category.full_alias_name}.merge(options))
    end
  end
  
    def url_for_directory_listing_page(directory_listing,options={})
    if options[:obsolute_path]
      other_options={:host=>@site.name}
      directory_listing_url({:directory_name=>directory_name(directory_listing.site),:directory_listing_id=>directory_listing.id,:directory_listing_name=>convert_to_url_string(directory_listing.name)}.merge(other_options))
    else
      directory_listing_path({:directory_name=>directory_name(directory_listing.site),:directory_listing_id=>directory_listing.id,:directory_listing_name=>convert_to_url_string(directory_listing.name)}.merge(options))
    end
  end

 def link_to_manage_my_profile(display_name,subscriber,options={})
    manage_my_profile_url({:id=>subscriber.id}.merge(options))
 end
 
  def link_to_change_password(display_name,subscriber,options={})
    change_password_url({:id=>subscriber.id}.merge(options).merge(options))
 end

 def get_normal_listing_for_will_paginate(link_objects = {})
    dynamicurl,query_string  = request.fullpath.split("?")
    if /page\/(\d)/.match(dynamicurl)
      dynamicurl = dynamicurl.split("/")[0...dynamicurl.split("/").rindex("page")]
      dynamicurl =  dynamicurl.join("/")
    end
    unless link_objects[:page].blank?
      dynamicurl << "/page/#{link_objects[:page]}"
      unless link_objects[:per_page].blank?
        dynamicurl << "/per_page/#{link_objects[:per_page]}"
      end
    end
     url =  query_string.blank? ? dynamicurl : dynamicurl+"?"+query_string
      return url
  end
 
end
