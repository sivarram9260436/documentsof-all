 ROLE_TYPE_SPECIFIC_HOME_PAGE={
                      "WplContentModifier"=>{:controller=>"/wpl_admin/wpl_company",:action=>"index"},
                      "WplAdministrator"=>{:controller=>"/wpl_admin/wpl_home",:action=>"index"},
                      "Admin"=>{:controller=>"/admin/login",:action=>"admin_dashboard"},
                      "Author"=>{:controller=>"/admin/login",:action=>"dashboard"},
                      "EventEditor"=>{:controller=>"/eventive_admin/eventive_home",:action=>"dashboard"}
}
SUBPERMISSION={
#ithound
    :manage_campaign=>{:controller=>"wpl_campaign",:actions=>["index","create","campaign_user","campaign_search","new_campaign","campaign_collateral","edit","update","summary","content_status_summary","software_product_create","software_product_save","optional_software_product",
    "software_product_update","required_information","software_product_edit","cross_industry_taxonomy_display","industry_specific_taxonomy_display","add_or_remove_node","cross_taxonomy_add","specific_taxonomy_add","search_taxonomy_view","search_taxonomy","software_product_list","hardware_product_list","service_product_list",
    "research_list","service_product_create","service_product_save","optional_service_product","service_product_update","service_product_edit","hardware_product_create","optional_hardware_product","hardware_product_save","optional_hardware_product","hardware_product_update","hardware_product_edit","research_product_create","research_product_save",
    "optional_research_product","research_product_update","required_research_information","research_product_edit","set_preference","save_preferences","activity_search","export_leads_to_csv","leads","activity_detail","save_lead_matches","export_setup","export_setup_save","activity_detail","activity_detail_end_user","display_preferences","display_preferences_save",
    "document_status_deactivate","document_status_activate","delete_campaign_products","delete_software_products","delete_hardware_products","delete_service_products","delete_research_articles","research_item","delete_selected_lead","reinstate_lead","adminslist","view_rating","update_sponser_status","add_tag","search_category"
    ]},
    :workflow_company=>{:controller=>"wpl_company",:actions=>["index","create","new_campaign","campaign_collateral","new","upload_new_logo","upload_logo","edit","update","campaign_list","campaign_search","delete_campaign","campaign_user","not_assigned"]   
    },
    :manage_home=>{:controller=>"wpl_home",:actions=>["index","check_email","check_email_id","company_search","account_manager","change_current_site","edit_company","update_company","upload_file","sponsored_listing_search","search_sponsored_listing","sponsored_listing_create","sponsored_listing_save","optinal_sponsored_listing","sponsored_listing_edit",
    "taxonomy_display","cross_taxonomy_add","get_campaign_products","tab_assignment","featured_sponsership_tab_assignment","remove_taxonomy_assignment","company_delete","new_admin","admin_create","admin_list","admin_user_edit","admin_update","admin_delete","new_agency_user","agency_user_create","agency_user_edit","agency_user_update","agency_user_list","agency_user_destroy",
    "new_company_user","company_user_create","company_user_edit","company_user_list","company_user_update","company_user_destroy","end_user_edit","save_assignments","campaign_assigned","campaign_not_assigned","login","send_mail","user_lookup_search","user_lookup","user_activity","export_user_detail","lead_list","export_leads_to_csv","lead_search","weeks_lead_export",
    "export_csv","taxonomy_list","new_taxonomy","new_taxonomy_save","taxonomy_edit","taxonomy_update","taxonomy_delete","campaign_lookup","delete_featured_sponserships","cache_delete","cache_clear","featured_company","featured_logo","save_file","add_file","campaign_logo_display","remove_assignment","sites","site_taxonomy_list","site_taxonomy","save_site_taxonomy","count_white_papers","delete_selected_user_lead","reinstate_user_lead","assign_campaign_user",
    "newsletters","add_news_letters","create_news_letter","edit_taxonomies_newsletters","delete_newsletters","update_newsletters_assignment","remove_featured_logo","mass_registration","mass_registration_status","sample_template","update_sponser","full_export_feed","most_popular_search","assign_most_popular_search","new_skin","create_skin","import_lead","import_lead_status","sample_lead_template","category_report_list","newsletter_search","download_category_report"]},
    :manage_user=>{:controller=>"wpl_home",:actions=>["index"]},
    :manage_report=>{:controller=>"wpl_report",:actions=>["index","campaign_report","demographic_summary","generate_pdf","generate_csv_data","generate_demography_pdf","generate_demography_pdf_range","demography_email_to_colleague","email_to_colleague","send_mail_to_colleague","closewindow","send_demographic_mail_to_colleague","email_to_colleague_search","send_mail_to_colleague_search","generate_pdf_search","generate_csv_data_search","category_summary"]},
    :manage_site=>{:controller=>"wpl_home",:actions=>["index"]},
    :manage_taxonomy=>{:controller=>"wpl_home",:actions=>["index"]},
    
  # Manage Login Dashboard
    :manage_site_modifier_dashboard=>{:controller=>"login",:actions=>["index","admin_dashboard","verify_login","logout","forgot_password","forgot_password_mail","reset_password","save_reset_password","change_website","check_error","save_password","set_password"]},
    :manage_content_modifier_dashboard=>{:controller=>"login",:actions=>["index","dashboard","verify_login","logout","forgot_password","forgot_password_mail","reset_password","save_reset_password","change_website","comment_complaint","update_comment_status","check_error","save_password","set_password"]},
  



  #Content
    :manage_articles => {:controller=>"articles",:actions=>['delete_additional_data', "show_diff","show_all_histories","view_version_history","index","list","create","edit","article_search","preview","advance_search","auto_complete_details","advance_search_view","update","new","static_articles","further_reading","newsletter","newsletter_edit","update_volumn_and_issue","generate_auto_tags","spellchecker","fetched","preview_article","update_time","copy_article", "curate_to_article_form","split_article_into_pages", 'create_article_for_external_source','create_article_for_external_source','additional_data','question_list','show_article_list','blog_further_reading',"save_and_publish","update_and_publish","assign_version","tag_creation"]},
    :delete_artciles => {:controller=>"articles",:actions=>["article_status"]},
    :workflow_unpublish => {:controller=>"articles",:actions=>["unpublish"]},
    :workflow_save => {:controller=>"articles",:actions=>["save_and_draft"]},
    :workflow_submit => {:controller=>"articles",:actions=>["save"]},
    #:workflow_publish => {:controller=>"articles",:actions=>["save_and_publish","update_and_publish"]},
    :view_history => {:controller=>"articles",:actions=>["article_history"]},
    :html_editing => {:controller=>"articles",:actions=>["edit_html"]},
  #    :dynamic_page_management=>{:controller=>"articles",:actions=>["edit_html"]},
  
  # Ranked List
    :admin_ranklist => {:controller=>"ranked_list",:actions=>["list","new","create","edit","update","save_featured","destroy","get_source", "index","service_collection","service_search","service_create","service_edit","service_update","author_collection","author_search","author_create","author_edit","author_update"]},
    :manage_ranklist => {:controller=>"ranked_list",:actions=>["list","edit","drag_drop","destroy","latest_and_most_read_articles","search","get_source", "index","service_collection","service_search","service_create","service_edit","service_update","author_collection","author_search","author_create","author_edit","author_update"]},
    :admin_manage_ranklist => {:controller=>"ranked_list",:actions=>["list","new","create","edit","update","save_featured","get_source","drag_drop","latest_and_most_read_articles","search", "index","service_collection","service_search","service_create","service_edit","service_update","author_collection","author_search","author_create","author_edit","author_update"]},
  
  #Image

    :manage_slideshow => {:controller=>"image_details",:actions=>["slideshow","edit_slideshow","new_slideshow","search","save_images_in_slideshow","update_images_in_slideshow","view_slideshow","show_image_library","show_search_page","gallery_list","edit_gallery","edit_imageset_in_gallery","popup_image_gallery","new_gallery","create_gallery_metadata","update_imageset_to_gallery","update_gallery_metadata","save_image_to_gallery","save_multiple_gallery","gallery_sequence_path","gallery_image_path","search_gallery", "save_gallery_order"]},
    :manage_images => {:controller=>"image_details",:actions=>["list","index","search","create","show_image_list","load_image_set_images","view_image_information","update_image_information","crop_image","cropped_image_value","view_all_images","show_search_page","show_upload_page","show_image_library","default_image","standalone_image","create_standalone_image","imageset_list","popup_image_manager","create_imageset","cancel_standalone_image","standalone_image_search","edit_imageset","selected_image","show_image_list_step2","select_inline_image","save_imageset","create_imageset_step1","create_imageset_step2","update_imageset_metadata","imagset_search","save_imageset_metadata_step1","upload_new_imageset","edit_orientation","show_image_list","cropped_imageset_value","standalone_image_info","edit_standalone_image","message_for_standalone","standalone_browse_help","check_image_width_and_height_status?","pagination_properites","upload_imageset_from_popup","upload_multiple_image","save_multiple_image", "show_preview_imageset", "crop_imageset", "add_image_from_article", "save_image_from_article", "insert_image_to_article","site_popup_image_manager","site_popup_image_manager_step1","popup_work_image_edit","author_image_upload","save_popup_work_image_edit","author_site_popup_image_manager","author_site_popup_image_manager_step1","author_image_upload","product_creation","save_our_product"]},
    :delete_images => {:controller=>"image_details",:actions=>["delete"]},  
    :manage_pic_of_the_day => {:controller=>"image_details",:actions=>["create","search","view_image_information","update_image_information","show_search_page","show_upload_page","show_image_library","default_image","pick_of_the_day","save_pick_of_the_month","active_pick_of_the_day"]},
  #Gallery Management
    :gallery_management => {:controller=>"image_details",:actions=>["add_image_to_gallery","image_gallery","select_image_for_gallery","gallery_list","new_gallery","create_gallery_metadata","edit_gallery","add_imageset_form_to_gallery","save_image_to_gallery","edit_imageset_in_gallery","update_imageset_to_gallery","update_gallery_metadata","search_gallery","popup_image_gallery","save_gallery_order","save_multiple_gallery","gallery_sequence_path","gallery_image_path","save_gallery_order"]},
  #Media
    :manage_media => {:controller=>"media_details",:actions=>["index","media","media_upload","media_upload_save","media_videoplay","audio","popup_media_manager","popup_audio_manager","edit","media_upload_save","audio_download","show_selected_image","create","media_search","search","audio_upload_save","audio_search","edit_audio_detail","update_audio_detail","download","popup_media_upload","popup_audio_upload"]},
    :delete_media => {:controller=>"media_details",:actions=>["delete"]},
  
  #Polls
    :manage_poll => {:controller=>"polls",:actions=>["index","list","new","create","edit","update","remove_poll_option","active","poll_results","reset_polls", 'add_field','destroy']},
    :place_poll => {:controller=>"polls",:actions=>[""]},
    :delete_poll => {:controller=>"polls",:actions=>["destroy"]},
    :admin_poll_management => {:controller=>"polls",:actions=>["index","list","new","create","edit","update","remove_poll_option","active","destroy","poll_results","reset_polls", 'add_field']},
  #Digital Assets
    :manage_assets => {:controller=>"digital_assets",:actions=>["index","list","search","create","upload","asset_details","article_asset","update","popup_digital_asset_manager","download","js_popupclose"]},
    :delete_assets => {:controller=>"digital_assets",:actions=>["delete"]},
  
  #Sites
    :site_management => {:controller=>"sites",:actions=>["index","list","new","create","edit","update","remove_site_properties","delete","add_field","page","site_user_list","create_site","site_create_save","site_properties","site_section","site_source","site_section_save","edit_site","site_update_save", "template_type","page_list","action_type","config_group","create_group","edit_group","update_group","index_asset_group","create_asset_template","list_asset_group","edit_asset_template","update_asset_template"]},
  
  #Menu
    :menu_management=> {:controller=>"menus",:actions=>["index","list","new","create","edit","update","reorder_menu","delete","action_type","menu_site","menu_page","entity_type"]},
  
  #Category
    :taxonomy_management=>{:controller=>"categories",:actions=>["index","list","new","create","edit","update","reorder_category","delete"]},
  #Roles
    :role_management=>{:controller=>"roles",:actions=>["index","list","new","create","edit","update","report","multi_assign","delete","search","permissions_for_user_type","download_as_csv", "show", "change_user_type_permission"]},                 
  #User
    :user_management=>{:controller=>"users",:actions=>["index","list","new","create","edit","update","assign_role","assign_role_and_site","edit_assigned_role","delete","add_announcement","announcement_create","my_setting_change","search","roles_for_user_type","add_permission","site_user_list","add_user_role", 'set_password', 'remove_role', 'remove_user','change_active',"download_as_csv","remove_anouncement","remove_site_role","reset_user_password"]},
    :user_self_setting=>{:controller=>"users",:actions=>["my_setting_change","changing_new_password","change_setting","change_password","reset_user_password","remove_bookmark","add_field","update"]},
  #author
    :author_management=>{:controller=>"authors",:actions=>["index","list","new","create","edit","update","search","further_reading","featured_new","featured_edit","update_featured","update_and_publish_featured","save_featured","featured_list","work_details"]},
  #Component
    #:component_management=>{:controller=>"components",:actions=>["index","list","new","create","edit","update","delete","add_field","component_tree_view","preview","new_create_component","component_update","action","entity_type","create_container"]},
  :component_management=>{:controller=>"components",:actions=>["index","list","new","create","edit","update","delete","add_field","component_tree_view","preview","new_create_component","component_update","action","entity_type","create_container","entity_type","show","new_tab","preview","update","set_partial","get_partial","get_component","new_create_component","component_name","ranklist_name","container_name","create_child_componen","destroy","destroy","get_component_model","save_component","new_component","new_update","edit_container","edit_tab_container","create_container","new_container","new_tab_component","search","list_type","new_widget","create_widget","list_widget","edit_widget","update_widget","list_partials","create_partials","select_page","component_search",'component_search_collection']},

  #Tag
    :tag_management=>{:controller=>"tags",:actions=>["index","list","new","create","edit","update","destroy","search","manual_tags","auto_tags","editable_content","inplace_update","inplace_cancel","tag_search","tag_edit","manual_tag_delete","auto_tag_delete","csv_download","add_to_ptl","new_auto_tag","pagination"]},
#  #Articles(Dynamic Page Creation)
#    :dynamic_page_management=>{:controller=>"static_page",:actions=>["dynamic_articles","save_and_draft","unpublish","save_and_publish","update_and_publish","save","create","edit","article_search","preview","advance_search","auto_complete_details","advance_search_view","update","new"]},
  
    :static_management=>{:controller=>"static_page",:actions=>["index","dynamic_articles","save_and_draft","save_and_publish","unpublish","update_and_publish","save","create","edit","article_search","preview","advance_search","auto_complete_details","advance_search_view","update","new","list","spotlight","alternate_home_page","spellchecker","update_volumn_and_issue","static_fragment_content","further_reading","assign_version","newsletter","newsletter_edit","select_fragment","new_static","new_static_fragment"]},
  
    :admin_static_page_management=>{:controller=>"static_page",:actions=>["save_and_draft","unpublish","dynamic_articles","save_and_publish","update_and_publish","save","create","edit","article_search","preview","advance_search","auto_complete_details","advance_search_view","update","new","list","spotlight","alternate_home_page","spellchecker","update_volumn_and_issue","static_fragment_content","further_reading","assign_version","newsletter","newsletter_edit"]},
  #Authentication
    :product_criteria_management=>{:controller=>"product_criteria",:actions=>["create","new_asset","new_subscription","subscription_list","list_product","excel_questionnaire_report","list_asset","save_asset","save_update_assetcondition","edit_asset","update_asset","asset_date_type","list_product","new_product","save_product","edit_product","update_product","subscription_list","new_subscription","save_subscription","edit_subscription","update_subscription","list_of_subscribers","new_subscriber_institution","save_subscriber_institution","edit_subscriber_institution","update_subscriber_institution","new_subscriber_individual","save_subscriber_individual","edit_subscriber_individual","edit_subscriber_render","update_subscriber_individual","s_m_error_messages","answered_s_m","pagination","assign_article_to_product","create_asset", "index", "new", "save", "edit"]},
    :authentication_management=>{:controller=>"products",:actions=>["index","new_product","save_product","edit_product","update_product","edit_asset","update_asset","asset_date_type","list_product","assign_article_to_product"]},
  
    :questionnaires_management=>{:controller=>"questionnaires",:actions=>['list','save_questionnaire_form','questionnaire_save','update','new','edit','question_search','new_questionnaire_form','export_to_csv','csv_popup','questionnaire_questions','pagination', 'index','new_questionnaire_form','create','update']},
    :questionnaire_data_management => {:controller=>"questionnaires",:actions=>['questionnaire_list','list','question_search','export_to_csv','csv_popup','questionnaire_questions','pagination', 'index','new','create','update','edit','delete','question_search','pagination','new_questionnaire_form','save_questionnaire_form','csv_popup','export_to_csv','questionnaire_save']},
    :questions_management =>{:controller=>"questions",:actions=>["list","new","create","edit","update","delete","pagination", "index"]},
  
  #User Generated
    :user_generated=>{:controller=>"user_generated",:actions=>["index","user_generated","comment_complaint","update_comment_status"]},
    :print_management=>{:controller=>"print_management",:actions=>["index","print_management","list","create_edit","assign_as_current_issue","pagination_sort_properities","comment_complaint"]},
  #Comment Management
    :comment_management=>{:controller=>"user_generated",:actions=>["index","user_generated","comment_moderation","comment_complaint","update","bulk_comment_moderation","update_comment_status","service_generated","poll_generated","authors_generated"]},

  #Directories
    :directory_listing_management=>{:controller=>"directory_listings",:actions=>["index","list","new","create","edit","update","reorder_directory_listing_category","add_sponsor_detail","contact_detail","advance_search"]},
    :directory_categories_management=>{:controller=>"directory_listing_categories",:actions=>["index","list","new","create","edit","update","destroy","add_sponsor_detail","entity_type"]},
    :services_management=>{:controller=>"services",:actions=>["index","list","new","create","edit","update","destroy","upload_images_to_service","save_multiple_images_to_service","new_images","service_management_list"]},

    :component_cache_management=>{:controller=>"component_cache",:actions=>['list','view_component_cache','delete_component_cache','index']},

    :group_management =>{:controller=>"groups",:actions=>['index','list','add','site_change','edit','update','editable_content','inplace_update','inplace_cancel']},
  
    :page_cache_expiry=>{:controller=>"cache_expiry",:actions=>['list','cache_expire','index','update']},
  
    :content_modifier_dashboard_management=>{:controller=>"login",:actions=>["index","dashboard","show_comment_complaint","change_website","login","verify_login","logout","comment_complaint","update_comment_status","forgot_password","forgot_password_mail","reset_password","save_reset_password","random_api"]},
    :site_modifier_dashboard_management=>{:controller=>"login",:actions=>["index","dashboard","show_comment_complaint","change_website","login","verify_login","logout","comment_complaint","update_comment_status","forgot_password","forgot_password_mail","reset_password","save_reset_password","random_api"]},
  
  #Newsletter
    :newsletter_management=>{:controller=>"articles",:actions=>["newsletter","newsletter_edit"]},
    
  #AssetCategory
    :asset_category_management => {:controller=>"asset_categories",:actions=>["index","list","new","create","edit","update"]},
    
  #Curate
    :curate_management=>{:controller=>"curate",:actions=>["index","save_ranked_list","req_url", 'test']},
  
  #For Eventive Application
    :event_management=>{:controller=>"eventive_home",:actions=>["dashboard","new_event","save_event","edit_event","update_event","city_for_country","template_for_event_type","add_event_to_my_list","index","search","cloned_event","create_cloned_articles","tag_cloud_for_related_events","upload_image_and_css","download_css","download_image","add_image_to_event"]},
    :manage_eventive_dashboard=>{:controller=>"login",:actions=>["index","change_website"]},
    :eventive_static_page_management =>{:controller=>"eventive_static_page",:actions=>["list_pages","list_sponsors","list_speakers","save_and_draft","unpublish","save_and_publish","update_and_publish","save","create","edit","article_search","preview","advance_search","auto_complete_details","advance_search_view","update","new","new_sponsors_speakers","edit_sponsors_speakers","clone_event","create_cloned_articles","reorder_collection","common_actions_speaker_sponsor","ranked_list_speaker_sponsor_type","import_sponsors_speaker","get_child_speaker_sponsor","unpublish_sponsor_speaker"]},
    :event_menu_management => {:controller=>"eventive_menus",:actions=>["index","list","new","create","edit","update","reorder_menu","delete"]},
    :event_headlines_management => {:controller=>"eventive_headlines",:actions=>["index","list","new","create","edit","update","delete"]},
    :event_venue_management => {:controller=>"eventive_venues",:actions=>["index","list","new","create","edit","update","save_and_publish","update_and_publish","filter_by_article","advance_search","publish_article","spellchecker","city_for_country","import_venue","get_child_venues","view"]},
    :event_programmes_management => {:controller=>"eventive_programmes",:actions=>["index","list","new","create","edit","update","delete","new_stream","create_stream","edit_stream","update_stream","delete_stream"]},
    
 #For Blogs
    :blog_management=>{:controller=>"blogs",:actions=>["index","list","edit","blog_article_list","save_and_publish","update_and_publish","save_and_draft","save","unpublish","new","blog_list","create","update","preview","advance_search","update_time","advance_search_view"]},
    
 #Additional Data    
    :additional_data=>{:controller=>"additional_data",:actions=>["min_max_value", "list","index","question_list","save","add_field","option_textarea","disable_field","render_subsection_form","save_subsection","new_additional_data", 'boolean_hidden_field', "show"]},

 #Competition
    :competition => { :controller => "competitions", :actions => [ 'index', 'list', 'new', 'edit', 'create', 'update', 'search', 'add_field', 'download_csv','generate_csv' ] },
 #RelatedCompanies
#    :related_companies_management => { :controller => "related_companies", :actions => [ 'edit','related_companies_list','new_alias','update_related_company_aliases','create','show','search','component_pagination' ] },
 
  #roles
   :roles_manager=>{:controller=>"roles",:action=>['index','list','show','new','create','edit','update','report','multi_assign','delete','permissions_for_user_type','search','component_pagination','download_as_csv','change_user_type_permission']},

 #News Wire Feed
    :news_wire_feeds_management => { :controller => "news_wire_feeds", :actions => [ 'list','show','component_pagination','index' ] },

#RelatedCompanies
    :related_companies_management => { :controller => "related_companies", :actions => [ 'edit','related_companies_list','new_alias','update_related_company_aliases','create','company_alias','show','search','component_pagination','index'] },

 #News Wire Feed
    :share_cast_management => { :controller => "news_wire_feeds", :actions => ['list','show','component_pagination' ] },

 
 #Event Calendar
    :event_calender_management => { :controller => "events", :actions => ['list', 'edit', 'create_event', 'update_event', 'edit_event', 'new','city_for_country'] },
 #Robots 

    :robots_management => {:controller =>"sites",:actions => ['list_robot','new_robot','create_robot','edit_robot','update_robot']},
 #Debate
    :debate_content_management => {:controller => "debates", :actions => ["index", "list", "new_debate", "create_debate", "edit_debate", "update_debate", "debate_search", "vote_status", "contributors_list", "new_contributor", "create_contributor", "edit_contributor", "update_contributor", "contributor_search", "sponsors_list", "new_sponsor", "create_sponsor", "edit_sponsor", "update_sponsor", "sponsor_search", "common_phase_edit", "common_phase_update", "announce_debate_winner", "advance_debate_status"]},
    :debate_admin_management => {:controller => "debates", :actions => ["admin_index", "role_type_list", "new_role_type", "create_role_type", "edit_role_type", "update_role_type", "debate_phase_list", "debate_phase_reorder", "new_debate_phase", "create_debate_phase", "edit_debate_phase", "update_debate_phase", "debate_configuration", "update_debate_configuration", "css_uploading", "css_downloading", "user_export", "download_users_csv"]},
    
 #pages
    :page_management => {:controller=>"page", :actions=>["listing_page","listing_page_edit","update_listing_page","listing_page_list","special_page","special_page_list","create_listing_page","create_special_page","update_special_page","special_page_edit","dynamic_url_generate","static_index","static_edit","static_update","static_new","static_create","static_save_and_publish","static_update_and_publish","action_type","list_breadcrums","new_page_properties","create_page_properties","edit_page_properties","update_page_properties","value_breadcrum","create_breadcrum_value","update_breadcrum_value","entity_type"]},
    
 #services
    :service_menu => {:controller=>"services",:action=>["index","create","new","update","edit","destroy","service_management_list"]},  
 
 #directory_listing_category
    :directory_listing_category_menu =>  {:controller=>"directory_listing_categories",:action=>["list"]},
      
 #source
    :source_management => {:controller=>"source",:actions=>["new","edit","update","create","source_name"]},
    
  #section
    :section_management => {:controller => "section", :actions => ["new","create","edit","update","save_section","featured_new","featured_edit","update_featured","update_and_publish_featured","save_featured","featured_list"]},
     
  #datalist
    :datalist_management => {:controller => "data_list", :actions => ["index","pre_defined_list","new","create","edit","update","preview_show","action_type","get_entry_type","data_list_search"]},
    
  #forum_management
   :forum_management => {:controller=>"forum", :actions=>["index","show_forum_topics","edit_forum","new_forum_topic","create_topic","show_forum_thread","create_post","show_post_list","update_tools","edit_forum_post","update_forum_post","change_thread_publish_status","change_post_publish_status","comment_complaint","change_comment","create_new_forum","save_new_forum","update_forum"]},      
  
  #product criteria
  :product_management => {:controller=>"product_criteria",:actions=>["index","list","new","save","save_update_assetcondition","edit","update_asset","asset_date_type"]},
 
  #Classified listing
  :classified_listing_management => {:controller=>"classified_listings",:actions=>["index","new","contact_detail","create","edit","update","advance_search","classified_list","list_category_classified","new_category_classified","create_category_classified","update_category_classified","edit_category_classified"]},

  #Classified listing categories
  :classified_categories_management => {:controller=>"classified_listing_categories",:actions=>["index","new","create","add_sponsor_detail","edit","update","classified_list"]},
      

  :product_management => {:controller=>"product_criteria",:action=>["index","list","new","save","save_update_assetcondition","edit","update_asset","asset_date_type"]},
 
   #layout management
   :layout_menu => {:controller =>"layout_managements",:actions=>["new","create","edit","update","index"]},
       
   #site_creation_management
   :site_creation => {:controller=>'sites',:action=>['create_site','site_create_save','edit_site','site_update_save']},
   
#   :get_featured=>{:controller=>"business_india_common",:actions=>["featured_list","featured_new","featured_edit","update_featured","update_and_publish_featured","save_featured"]}

    :get_featured=>{:controller=>"business_india_common",:actions=>["featured_list","featured_new","featured_edit","update_featured","update_and_publish_featured","save_featured"]},
   
  :virtual_tour=>{:controller=>"business_india_admin",:actions=>["new_virtual","create_virtual","list_project","view_project","list_story","list_advertise","list_contact_us","list_newsletter","list_exhibit_with_us"]},

   #article ranked featured list search
   :article_search_management => {:controller => 'articles',:actions =>["advance_search"]},

   #Article History management 
   :article_history_management => {:controller => 'articles',:actions =>["show_all_histories","edit"]},
  
   #Image Size Management
  :image_size_management => {:controller => 'image_details',:actions =>["image_size_lists","search_image_size","new_image_size","update_image_size"]},

   #User Announsment
   :user_annousment=>{:controller=>"users",:actions=>["add_announcement","announcement_create"]},

   #Export Permission
   :export_permission => {:controller => 'basic_data_export_import', :actions=>['export','seperate_export','entire_exports','article_export','export_for_data_range','export_entire_data','xml_download']},
   #Import PerMission
   :import_permission => {:controller => 'basic_data_export_import', :actions=>['import', 'seperate_import', 'entire_import','actual_import','import_actual_article','upload_data_to_server','xml_upload']}, 
 
    #XML Export
    :xml_export=> {:controller=>"xml_export",:actions=>["index", "generate_category_xml", "generate_product_xml", "generate_company_list_with_contact_xml", "generate_product_grouped_by_company_xml","form_action"]},
    #Subscription
    :subscription_detail=>{:controller=>"authentication",:actions=>["subscriber_index","subscriber_new","subscriber_list","subscriber_search","subscriber_edit","subscriber_update","subscriber_creation"]},
    #Url redirects
    :all_redirects_management =>{:controller=>"all_redirects",:actions=>["index","new","create","delete_redirect","edit","update"]},
    #subscriber Export
    :subscriber_report_management=>{:controller=>"subscribers",:actions=>["subscriber_report","generate_subscriber"]},
    :newsletter_management=>{:controller => 'newsletter',:actions =>["send_test_mail","create_newsletter",'show_newsletter','create_subscriber','update_subject','new_test_subscriber','create_test_subscriber','newsletter_repository', 'export_newsletter_report','import_subscriber','export_subscriber','import_subscriber_newsletter','import_unsubscriber_newsletter','subscribers_upload_sample','newsletter_change_status']} ,
    #rae management
    :rae_management=>{:controller => 'rae',:actions=>['index','search','subscriber_edit','subscriber_update','deactivate_subscriber','export_to_csv','activate_subscriber']}

}
     
