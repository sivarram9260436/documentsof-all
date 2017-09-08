RULES_FOR_SEARCH_ENGINE = {
                           :solr_1 => SearchEngine::SearchEngineConfiguration.solr_1({
                                                          :host=>"127.0.0.1",
                                                          :secondary_host=>"127.0.0.1",
                                                          :aci_port=>"8982",
                                                          :index_port=>"8080",
                                                          :defaultprint_fields=>"DREREFERENCE,DRETITLE,DREDBNAME,DRECONTENT,URL,AUTHOR,PRIMARYCATEGORY,CATEGORY,TAG,METAKEYWORD,METADISCRIPTION,SITE_SHORT_NAME",
                                                          :database_name=>"nation_news"
                                                           })
}


APPLICATIONNAME="CmsTest"
DIRECTORY_APPLICATIONNAME="DIRECTORY"
CATEGORY_APPLICATIONNAME="CATEGORY"
TAG_APPLICATIONNAME="TAG"
OTHER_ENTITY_APPLICATIONNAME="CMS_OTHER_ENTITY"
INCLUDE_GRAPESHOT = false
RELEVANCE="90"
SETTINGS_FOR_AUTONOMY_JOB={:database=>"Jobs"}
SORT_FILTER_MAPPING = {:relevance => "Relevance", :relevance1 => "Relevance+Date", :relevance2 => "Date+Relevance",:recent => "Date" ,:title_alphapatical=>"DRETITLE:alphabetical+Relevance",:company_name_alphapatical=>"COMPANY_NAME:alphabetical+Relevance" }

FILTER_MAPPING_SOLR={:data_proxy => :site_proxy_ids,:type=>:section_name,:category=>:categories_names,:site_short_name=>:site_short_names,:source=>:source_alais_name,:video=>:video_flag,:author=>:display_author_name,:full_category=>:full_categories_names,:tag=>:tags_name,:primary_medium=>:primary_medium,:month_based=>:month_based}
SEARCH_DATE_OPTIONS_SOLR = {:today => "", :yesterday => 1.days, :this_year => 1.years, :this_week => 7.days, :this_month => 1.months}


FILTER_MAPPING={:tag=>:tag,:type=>:section,:category=>:category,:site_short_name=>:site_short_name,:from_date=>:from_date,:to_date=>:to_date,:source=>:source,:date=>:date,:video=>:video,:author=>:author,:full_category=>:full_category,:data_proxy=>:data_proxy,:blog_name=>:blog_name,:blog_search=>:blog_search,:video_or_audio=>:video_or_audio,:video_or_audio=>:video_or_audio,:entity=>:entity,:primary_medium=>:primary_medium,:month_based=>:month_based}
DIRECTORY_FILTER_MAPPING={:category=>:dir_category_name,:site_short_name=>:site_short_name,:directory_name=>:directory_name,:dir_site_short_name=>:dir_site_short_name,:full_category=>:dir_category_full_alias_name}

STRING_FILTER = ["author","DREREFERENCE"]
