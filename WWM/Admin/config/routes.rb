NewKreatioCMS::Application.routes.draw do
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Article
  # Place all the backoffice routes inside this namespace
match "/search_filter(/filter_type/:filter_type)(/filter_value/:filter_value)(/page/:page)(/:query/:query_string)"=> "wps/forms#resource_page",:as=>'search_filter'
match 'autocomplete' ,:to => 'admin#autocomplete' , :as => :autocomplete
match "static/:page_name" => "wps/pages#show_static", :as =>'static'
   match ':controller(/:action(/:id))' , :controller=> /admin\/[^\/]+/ ,:as => :admin

match "ngx/admin/digital_assets/create"=>"ngx/admin/digital_asset#create"
get '/admin/newsletter/export_subscriber' => "admin/newsletter#export_subscriber"
post '/admin/newsletter/newsletter_change_status' => "admin/newsletter#newsletter_change_status"
     namespace :admin do
       resources :articles do 
         post 'save_and_publish'
         post 'update_and_publish'
         get 'save_and_request_publish'
         get 'save_as_draft'
         get 'unpublish'
         get  'preview' 
         get  'advance_search',:on => :collection
         get 'copy_article',:on => :collection
         get 'feteched',:on=>:collection
         get  'advance_search_view',:on => :collection
         get 'update_volumn_and_issue',:on => :collection
         get 'further_reading',:on => :collection
         get 'split_article_into_pages',:on => :collection
       end

       resources :menus do
         get 'action_type',:on=> :collection
         get 'menu_site', :on=>:collection
         get 'menu_page', :on => :collection
          get 'entity_type',:on=> :collection
       end
       
       resources :data_list do
         get 'pre_defined_list',:on=> :collection
         get 'new_data_list',:on=> :collection
         get 'create_data_list',:on=> :collection
         get 'ranklist_index',:on=> :collection
         get 'ranklist_new',:on=> :collection
         get 'rankedlist_edit',:on=> :collection
         get 'edit',:on=> :collection
         get 'update_data_list',:on=> :collection
           get 'preview_show',:on=> :collection
            get 'action_type',:on=> :collection
       end
       
       resources :page do
         get 'action_type',:on=> :collection
         get 'listing_page', :on=>:collection
         get 'listing_page_list', :on=>:collection
         get 'listing_page_edit', :on=>:collection
         get 'special_page_edit', :on=>:collection
         get 'static_index', :on=>:collection
         get 'static_edit', :on=>:collection
         get 'static_update', :on=>:collection
         get 'static_new', :on=>:collection
         get 'static_create', :on=>:collection
         get 'update_listing_page', :on=>:collection
         get 'static_save_and_publish', :on=>:collection
         get 'static_update_and_publish', :on=>:collection
         get 'action_type',:on=> :collection
         get 'value_breadcrum',:on=>:collection
         get 'create_breadcrum_value',:on=>:collection
         get 'entity_type',:on=>:collection
       end

       resources :section do
         get 'save_section', :on=>:collection
       end 

     # resources :newsletter do
      # get 'export_subscriber', :on=>:collection
    # end

       resources :source     
      
       resources :blogs
            
            
       resources :related_companies do
         #get 'related_companies_list', :on => :collection
       end
       
       resources :news_wire_feeds

    
       resources :asset_categories

       resources :print_management do
         get 'create_edit', :on => :collection
       end
       
       
       resources :sites do
         put 'list',:on => :collection
         get 'create_site',:on => :collection
         get 'site_create_save',:on => :collection
         get 'site_properties',:on => :collection
         get 'site_section',:on => :collection
         get 'site_source',:on => :collection
         get 'site_section_save',:on => :collection
         get 'edit_site',:on => :collection  
         get 'site_update_save',:on => :collection
         put 'page_list',:on => :collection  
         get 'action_type',:on => :collection 
         get 'config_group',:on => :collection     
         get 'config_value',:on => :collection  
         get 'update_group',:on => :collection 
         get 'edit_group',:on => :collection
         get 'create_group',:on => :collection
       end
       
       resources :all_redirects do 
         get 'index', :on => :collection
         get 'new_widget',:on => :collection
         get 'delete_redirect', :on => :collection
         get 'edit',:on => :collection
          get 'update',:on => :collection
       end     
  
       # resources :static_page do
       # end
        
       # resources :users do
         # get 'my_setting_change',:on => :collection
         # get 'site_user_list',:on => :collection
         # get 'update',:on => :collection
         # get 'edit',:on => :collection
          # get 'list',:on => :collection
       # end
       
       resources :products do
        get 'new_product', :on => :collection
        get 'index', :on => :collection
        post 'save_product', :on => :collection
        get 'update', :on => :collection
        get 'edit_product', :on => :collection
       end
       
        resources :components do
         put 'list'
         get 'component_tree_view', :on => :collection
         put 'action', :on => :collection
          put 'entity_type', :on => :collection
          get 'new_widget',:on => :collection
          get 'create_widget',:on => :collection 
          get 'list_widget',:on => :collection
            get 'component_search',:on => :collection
             get  'advance_search',:on => :collection
       end
       resources :additional_data do
       get "question_list", :on => :collection
       get "add_field", :on => :collection
       get "new_additional_data", :on => :collection
       get "min_max_value", :on => :collection
       get "option_textarea", :on => :collection
       get "boolean_hidden_field", :on => :collection
       end

       resources :tags do 
         get 'search', :on => :collection
       end

       resources :verticals do 
         get 'search', :on => :collection
       end

       resources :polls do 
         put 'list'
         get 'poll_results', :on => :member
         get 'add_field', :on => :member
         
         
       end
        resources :competitions do 
        put 'list'
       end
       resources :comments do 
           #put 'user_generated'
            #put 'list'
            #put 'update'
       end
       resources :user_generated do 
           #put 'comment_moderation'
           get 'user_generated', :on => :collection
           put 'list'
           get 'bulk_comment_moderation', :on => :collection
           get 'comment_moderation', :on => :collection
           #put 'update'
       end
       resources :ranked_list do 
         post "update"
       end
       resources :site_website do 
         
       end
       
       resources :component_cache do 
         get "destroy" ,:on => :member
       end
       resources :questions do
         put 'list'
       end
       resources :text_questions, :controller => :questions
       resources :text_block_question, :controller => :questions
       resources :authors do
         put 'list'
         put 'update'
       end
       resources :roles do
         get 'download_as_csv',:on => :collection
         get 'edit',:on => :collection
         get "change_user_type_permission", :on => :collection
         put 'list'
       end
       resources :questionnaires do
         get 'question_search'
         get 'new_questionnaire_form', :on=>:collection
         get 'csv_popup', :on=>:collection
         end
       resources :users do
         get 'download_as_csv',:on => :collection
         put 'my_setting_change',:on => :collection
         put 'site_user_list', :on=>:collection
         put 'user_list',:on => :collection
         # get 'edit', :on => :collection
         # get 'update', :on => :collection
         get "remove_site_role", :on => :member
         post 'add_announcement'
       end
       resources :categories do
         post 'reorder_category',:on => :collection
       end
     resources :image_details do
         get 'standalone_image',:on => :collection
         get 'create_standalone_image',:on => :collection 
         get 'gallery_list',:on => :collection 
         get 'search_gallery',:on => :collection 
         get 'new_gallery',:on => :collection 
         get 'popup_image_manager' ,:on => :collection 
         get 'imageset_list' ,:on => :collection
         get 'view_image_information',:on => :collection
         get 'create_imageset',:on => :collection
         get 'save_imageset',:on => :collection 
         get 'show_image_list',:on => :collection
         get 'add_image_to_gallery',:on => :collection
         get 'edit_imageset_in_gallery',:on => :collection
         get 'view_image_information',:on => :collection
         get 'popup_image_gallery', :on => :collection
         get 'edit_gallery', :on => :collection
         get 'selected_image', :on => :collection
         get 'show_image_list_step2', :on => :collection 
         get 'select_inline_image', :on => :collection
         put 'update_imageset_to_gallery', :on => :collection
         put 'update_gallery_metadata', :on => :collection
          put 'image_size_lists', :on => :collection
           put 'new_image_size', :on => :collection
           put 'update_image_size', :on => :collection
           put 'search_image_size', :on => :collection
           
       end
       resources :digital_assets do 
         get 'search',:on => :collection  
         get 'upload',:on => :collection
         get 'asset_details',:on => :collection
         get 'download',:get => :member
         get 'article_asset',:on => :collection
         get 'popup_digital_asset_manager', :on => :collection
       end
       resources :media_details do
         get 'audio' ,:on => :collection
         get 'audio_upload_save' ,:on => :collection
         get 'edit_audio_detail',:on => :collection
         get 'audio_search',:on => :collection
         get 'media',:on => :collection
         get 'media_upload_save', :on => :collection
         get 'edit', :on => :collection
         get 'media_videoplay' ,:on => :collection
         get 'popup_media_manager', :on => :collection
         get 'popup_audio_manager', :on => :collection
         get 'search',:on => :collection
         get 'show_selected_image',:on => :collection
       end
       resources :product_criteria do
         get "asset_date_type", :on => :collection
         get "list_product", :on => :collection
       end
       
       resources :featured_sets
       
       resources :debates
      
       resources :directory_listings
       
       resources :events
       
       resources :directory_listing_categories do
         get 'list',:on => :collection
        end
       
       resources :services do
          get 'list',:on => :collection
       end
       
       resources :login do
         get 'dashboard', :on => :collection
         get "redirect_to_dash_poard", :on => :collection
         get "admin_dashboard", :on => :collection
         get 'edit',:on => :collection
         get "change_website", :on => :collection
         get "logout", :on => :collection
         get "forgot_password", :on => :collection
         get "forgot_password_mail", :on => :collection
       end
       
       resources :subscribers do
         
       end
       
       resources :forum do 
         
       end
       
     end
       
   
       resources :admin do 
         get 'autocomplete_json',:on =>:collection
       end
    match 'autocomplete' ,:to => 'admin#autocomplete' , :as => :autocomplete
    match 'preview_article', :controller => 'wps/pages',:action=>'preview_article', :as => :preview_article  
    match 'static_page' ,:to => 'admin/static_page#index' , :as => :static_page
    match 'add_field' ,:to => 'admin#add_field' , :as => :add_field
    match 'select_fragment' ,:to => 'admin/static_page#select_fragment' , :as => :select_fragment
    match "preview" => "admin/components#compoennt_preview",:as =>"preview_component"

   #match '/user_generated' , :to => 'user_generated#update' ,:as => :admin
      root :to => 'admin/login#index',:as =>:root
match  ':source/:section/:id/:article_title',:controller => "home",:action=> "show_article", :id=>/\d+/ ,:as => :article
 #  match ':controller(/:action(/:id))' , :controller=> /admin\/[^\/]+/ ,:as => :admin

      match "/admin_login", :to => "admin/login#admin_login", :as => "admin_login"
   match ':controller(/:action(/:id))' , :controller=> /admin\/[^\/]+/ ,:as => :admin



   #root :to =>'login#login'
   #match "/hello", :to => proc {|env| [2, {}, ["Hello world"]] }

  #match "/google", :to => redirect("http://google.com/")
  #:root :controller=>'/admin/login#login'

 # match ':controller(/:action(/:id))' , :controller=> /admin\/[^\/]+/ ,:as => :admin
  #match '/admin/login#login'  , :as=> ':root' 
  #match 'admin_login'=> '/admin/login#admin_login' , :as=> ':admin'
  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
