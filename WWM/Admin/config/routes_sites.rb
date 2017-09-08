NewKreatioCMS::Application.routes.draw do
match "/resource(/entity_base/:entity_base)(/entity_value/:entity_value)(/page/:page)"=> "wps/forms#resource_page",:as=>'resource'
# Article
  match "/admin/articles/new" =>"admin/articles#new"
  match "/wps/authentication/article_creation" => "wps/authentication#article_creation"
  match "/admin/image_details/popup_image_manager" =>  "admin/image_details#popup_image_manager"
  match ":article_id" => "wps/pages#tiny_url", :article_id => /(\d+)/
  match 'author/:author_action/:author_id/:author_name/page/:page' => "wps/author#show_author_page" ,:as => "author",:page=>/\d+/
  match '((feeds/:format)((/maxcontentwords/:number_of_words/)(/fulltext/app)))/author/:author_action/:author_id/:author_name(/contact/:id)(/page/:page)' =>"wps/author#show_author_page" ,:as => "author", :number_of_words => "all",:full_text=>"true"
  match ":source/:section/:id/:article_title/page/:page" => "wps/pages#show_article", :as => "article_page", :id => /(\d+)/,:page=>/\d+/
  match ":source/:blog/:id/:article_title" => "wps/pages#show_article", :as => "blog_article", :id => /\d+/, :blog => /.*-blog/
  match "/search_filter(/filter_type/:filter_type)(/filter_value/:filter_value)(/page/:page)(/:query/:query_string)"=> "wps/forms#search_page",:as=>'search_filter'
  match "feeds/:format/search" => "wps/search#search" ,:as => "no_query_search_rss"
  match 'feeds/:format/search/:query' => "wps/search#search" ,:as => "search_rss"
  match 'manage_profile/:id'=>'wps/authentication#manage_my_profile',:as=>'manage_my_profile', :id => /(\d+)/
  match 'change_password/:id'=>'wps/authentication#change_password',:as=>'change_password', :id => /(\d+)/
   match 'update_password/:id'=>'wps/authentication#update_password',:as=>'update_password', :id => /(\d+)/
  match "directory/:directory_name/category/:name"=>"wps/directory#show_directory_listings_category_page" ,:as => "directory_listings_category"
  match "preview_directory_listing"=>"wps/directory#preview_directory_listing",:as=> "preview_directory_listing"
  match ":path/:page_name/:character" => "wps/pages#listing",:as=>"dynamic_page_alphabet"
  #author
  match ":source/:section/:id/:article_title" => "wps/pages#show_article", :as => "article", :id => /(\d+)/
match 'print_article/:source/:section/:id/:article_title'=> 'wps/pages#show_article'   , :as=> 'print_article'
  match "static/:page_name" => "wps/pages#show_static", :as => "static"
  match "author/:author_id/:author_name" => "wps/author#manage_profile",:as=>"author_profile"
  match "login/:provider/callback"=>"wps/authentication#login_social_network_callback"
  match "/article/:article_id/additional_data/:additional_data" => "nine_dot_nine_common#article_additional_data_page",:as=>"additional_data"
  #get_featured
  match "/get_featured"=>"business_india_common#featured_new"
  match "/admin/business_india_common/save_featured" => "wps/authentication#article_creation"
match "send-to/subscriber/:subscriber_id" => "wps/business_india_common#sent_my_mail", :as => "sent_my_mail", :subscriber_id => /(\d+)/
  match "test_subscribtion"=>"wps/authentication#test_subscribtion" 
  #images
  match "/admin/image_details/site_popup_image_manager"=>"image_details#site_popup_image_manager"
  match "/admin/image_details/site_popup_image_manager_step1"=>"image_details#site_popup_image_manager_step1"
  match "/admin/image_details/gallery_image_path"=>"image_details#gallery_image_path"
  match '/wps/application/render_partial' =>'application#render_partial'
  #Gallery
  match 'gallery(/:gallery_id)(/page/:g_page)' => "wps/gallery#show_gallery_page",:as => :gallery_page
  # Poll
  match "wps/pages/vote/:poll_id/:article_title/:source" => "wps/pages#vote", :as => "poll", :poll_id => /(\d+)/
  #author
  match 'author/:author_action/:author_id/:author_name(/page/:page)' =>"wps/author#show_author_page" ,:as => "author"
  # forums
  match "/forums" => "admin/forum#index"
  match "/forum_topics/:forum_name/:forum_id" => "admin/forum#show_forum_topics" , :as=> "show_forum_topics" ,:forum_id => /(\d+)/
  match "/forum_threads/:forum_topic_name/:forum_topic_id" => "admin/forum#show_forum_thread" ,:as => "show_forum_threads" , :forum_topic_id => /(\d+)/
  match "/forum_replies/:forum_post_name/:forum_post_id" => "admin/forum#show_post_list" ,:as =>  "show_forum_replies" ,:forum_thread_id => /(\d+)/
  match "/admin/forum/show_forum_topics" => "admin/forum#show_forum_topics"
  match "/admin/forum/create_topic" => "admin/forum#create_topic"
  match "/admin/forum/create_post" => "admin/forum#create_post" 
  match "admin/forum/new_forum_topic" => "admin/forum#new_forum_topic",:to => redirect("/forum/new_forum_topic")
  match "/admin/forum/show_forum_thread" => "admin/forum#show_forum_thread"
  match "/admin/forum/show_post_list" => "admin/forum#show_post_list"
  #search
  match '(feeds/:format/)(/:search_entity)/search(/:query)' => "wps/search#search",:search_entity=>/jargonbuster|blog|glossary/ 
  #product
   match "/product/:product_id/:product_name" => "wps/authentication#show_product", :product_id => /\d+/,:as => "show_product"
   #filter
   match "/:type/filter/:filter"=> "business_india_common#filter",:as => "filter",:type =>/blog|article/
   match "/filter" => "business_india_common#filter",:as => "filter"
# # Comment
  match ":source/poll/:action/:id/:poll_title" => "wps/pages#:action", :action => /comment|comment_thanks|save_comment/, :id => /\d+/ ,:poll => "true", :as => "action_on_poll"
  match ":source/:action/:id/:article_title" => "wps/pages#:action", :action => /flame_author|comment|comment_thanks|save_comment|flame_thanks|external_iframe/ , :id => /\d+/, :as => "action_on_article"
  match "wps/pages_controller/save_comment" => "wps/pages#save_comment"
  #component
  match "preview_article" => "wps/pages#preview_article"
  match "preview_static_page" => "wps/pages#preview_static_page"
  match "edit-component" => "admin/components#edit"
  match "/admin/components/entity_type" => "admin/components#entity_type"
  match "/admin/components/action" => "admin/components#action"
  match "/admin/components/component_update/:id" => "admin/components#component_update"
  match '/remote_component/:component_id' =>"admin/components#remote_component",:as =>"remote_component"
  match "save-component" => "admin/components#save_component"
  match "new-component" => "admin/components#new"
  match "new_create_component" => "admin/components#new_create_component"
  match "component_name" => "admin/components#component_name"
  match "admin/components/preview" => "admin/components#preview"
  match "add_widget" => "admin/components#add_widget"
  match "get-component" => "admin/components#create_site_specific_component"
  match "/admin/autocomplete_json" => "admin#autocomplete_json"
  match "preview" => "admin/components#component_preview",:as =>"preview_component"
  match 'ajax-pagination/component/:id/page/:page(/per_page/:per_page)' => "wps/pages#component_ajax_pagination",:as =>"ajax_component_pagination"
  match 'ajax-pagination/component/:id/*path(/page/:page(/per_page/:per_page))' => "wps/pages#component_ajax_pagination",:as =>"ajax_component_pagination"

  # Send to friend
  match "send-to-friend/article/:article_id" => "wps/pages#send_to_friend", :as => "send_to_friend", :article_id => /(\d+)/
  match "wps/pages_controller/send_to_friend_thanks" => "wps/pages#send_to_friend_thanks"
  match '/complain_abt_comment' => "wps/pages_controller#complain_abt_comment" ,:as => "comment_complaint"
  #competition
  match '/competitions(/:competition_id/:title)' => "wps/competition#competitions",:as => "competition" 
  #Questinnaire
  match "form/:form_id" => "wps/questionnaires#save_questionnaire_form", :as => "questionnaire_form", :form_id => /(\d+)/
  match "wps/questionnaires/save_questionnaire_form/:id" => "wps/questionnaires#save_questionnaire_form", :id => /(\d+)/
  match "home/verify_digital_asset" => "wps/forms#verify_digital_asset"
  match "wps/questionnaires/:id" => "wps/questionnaires#questionnaire_html"
  match "wps/questionnaires/microsite_save_questionnaire_form/:id" => "wps/questionnaires#microsite_save_questionnaire_form", :id => /(\d+)/
  # Sitemap
  #match "sitemap/:page.xml" => "wps/pages#sitemap", :format => "xml", :page => /(\d+)/
  match "sitemap.xml" => "wps/pages#sitemap", :as => "sitemap", :format => "xml", :page => /(\d+)/
  match "news-sitemap.xml" => "wps/pages#news_sitemap", :as => "news_sitemap", :format => "xml", :page => /(\d+)/
  match "sitemap_index.xml" => "wps/pages#sitemap_index", :as => "sitemap_index", :format => "xml", :page => /(\d+)/
  match "videositemap.xml" => "wps/pages#videositemap", :as => "videositemap", :format => "xml", :page => /(\d+)/


  #issue page
   match '(:issue/:source_name(/latest)(/:month_year)(/:issue_name))(/page/:page(/per_page/:per_page))' => "wps/issues#show_issue_page",:page=>/\d+/,:per_page=>/\d+/,:as =>"magazine_issue",:issue =>/issue|latest_issue/
   match 'issue/:issue_id' => "wps/issues#show_issue_page" ,:as=>:issue_article
  #Directory
  match ":directory_name/company/:directory_listing_id/:directory_listing_name" => "wps/directory#directory" ,:as => "directory_listing"
  match '/directory-submit/:directory_name(/:type)(/:id/:name)(/:directory_listing_id)(/:directory_listing_name)(/page/:page(/per_page/:per_page))' => "wps/directory#directory_submission",:page=>/\d+/,:per_page=>/\d+/,:id =>/\d+/,:directory_listing_id =>/\d+/,:type => /submit-review|submit-review-form|submit-review-thanks/
  match '((feeds/:format)(/maxcontentwords/:number_of_words))/directory/search((/:query)(/page/:page(/per_page/:per_page)))' => "wps/directory#directory_search",:page=>/\d+/,:per_page=>/\d+/
  match "/directory/:directory_name/*path(/page/:page(/per_page/:per_page))" => "wps/directory#listing" ,:as => "directory_listing"

  # Dynamic Listing
  #GetFeatured

  
    #forget password
   match "/forgot_password" =>"wps/authentication#forgot_password",:as =>"forget_password"

    #services
  match "/admin/services/create" =>"admin/services#create"
  match "/products/submit" =>"admin/services#new",:as =>"new_service"
  match "/verify-site-login" =>"nine_dot_nine_common#verify_authentication",:as =>"verify_site_login"
  match "/logout" =>"wps/authentication#logout",:as =>"signout"
  match "/rating" =>"common#rating",:as =>"rating"
  match "/registration" =>"wps/authentication#registration" ,:as =>"registration" 
  #newsletter
  match '/newsletter/:name', :controller => 'wps/pages',:action=>'newsletter', :as => :newsletter
  
  
  match '/:controller(/:action(/:id))' , :controller=> /wps\/[^\/]+/ ,:as => :wps

  match "(/feed/:format/)*path(/page/:page(/per_page/:per_page))" => "wps/pages#listing"

  match ':controller(/:action(/:id(.:format)))'  
  root :to => 'wps/pages#listing',:as =>:root
  
  match "(*categories)/:id/:title" => "wps/pages#show_article", :as => "new_article", :id => /(\d+)/

end
