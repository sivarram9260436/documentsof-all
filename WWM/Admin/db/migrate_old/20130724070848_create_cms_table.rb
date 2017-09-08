class CreateCmsTable < ActiveRecord::Migration
  def up
     create_table "activity_statuses", :force => true do |t|
    t.string   "name"
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "activity_summaries", :force => true do |t|
    t.integer  "activity_status_id"
    t.integer  "document_id"
    t.integer  "campaign_id"
    t.integer  "subscriber_id"
    t.integer  "activity_type_id"
    t.boolean  "feature_sponsorship_id"
    t.date     "first_viewed"
    t.date     "first_exported"
    t.date     "first_auto_viewed"
    t.string   "source"
    t.string   "filters"
    t.string   "query_text"
    t.string   "email_body",             :limit => 4000
    t.integer  "request_type_id"
    t.integer  "budget_range_id"
    t.integer  "purchase_decision_id"
    t.integer  "no_of_views"
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ithound_code",                           :default => "IThound"
    t.boolean  "status",                                 :default => true
    t.integer  "wpl_id"
  end

  add_index "activity_summaries", ["campaign_id"], :name => "index_activity_summaries_on_campaign_id"
  add_index "activity_summaries", ["created_at"], :name => "index_activity_summaries_on_created_at"
  add_index "activity_summaries", ["document_id"], :name => "index_activity_summaries_on_document_id"
  add_index "activity_summaries", ["filters"], :name => "index_activity_summaries_on_filters"
  add_index "activity_summaries", ["subscriber_id"], :name => "index_activity_summaries_on_subscriber_id"

  create_table "activity_types", :force => true do |t|
    t.string   "name"
    t.boolean  "export_field"
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "admins", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by"
    t.integer  "updated_by"
  end

  create_table "agencies", :force => true do |t|
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "all_redirects", :force => true do |t|
    t.string   "host",          :limit => 2048
    t.string   "orig_uri",      :limit => 2048
    t.string   "destination",   :limit => 2048
    t.string   "redirect_type", :limit => 20
    t.string   "record_type",   :limit => 20
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "all_redirects", ["host", "orig_uri"], :name => "index_all_redirects_on_host_and_orig_uri", :unique => true

  create_table "answers", :force => true do |t|
    t.string   "type"
    t.string   "free_text"
    t.string   "others_text"
    t.integer  "subscriber_id"
    t.integer  "question_id"
    t.integer  "option_id"
    t.integer  "number",                      :limit => 8
    t.integer  "year"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "text_block"
    t.integer  "questionnaire_submission_id"
  end

  add_index "answers", ["free_text"], :name => "index_answers_on_free_text"
  add_index "answers", ["option_id"], :name => "index_answers_on_option_id"
  add_index "answers", ["others_text"], :name => "index_answers_on_others_text"
  add_index "answers", ["question_id"], :name => "index_answers_on_question_id"
  add_index "answers", ["questionnaire_submission_id"], :name => "index_questionnaire_submission_id"
  add_index "answers", ["subscriber_id"], :name => "index_answers_on_subscriber_id"

  create_table "article_authors", :force => true do |t|
    t.integer "article_id"
    t.integer "author_id"
    t.integer "sequence_number"
  end

  add_index "article_authors", ["article_id", "sequence_number"], :name => "by_art_auth"
  add_index "article_authors", ["author_id"], :name => "index_article_authors_on_author_id"

  create_table "article_content_authors", :force => true do |t|
    t.integer "article_content_id"
    t.integer "author_id"
    t.integer "sequence_number"
  end

  add_index "article_content_authors", ["article_content_id"], :name => "index_article_content_authors_on_article_content_id"
  add_index "article_content_authors", ["author_id", "article_content_id"], :name => "by_aut_artcon"
  add_index "article_content_authors", ["sequence_number"], :name => "index_article_content_authors_on_sequence_number"

  create_table "article_contents", :force => true do |t|
    t.integer  "article_id"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.string   "image_url"
    t.string   "sub_title"
    t.string   "title",                     :limit => 10000
    t.string   "url_part"
    t.string   "region"
    t.string   "meta_keywords",             :limit => 1000
    t.text     "meta_description"
    t.string   "volume_and_issue"
    t.string   "title_image_url"
    t.text     "pullquote"
    t.string   "author_alias"
    t.text     "description"
    t.text     "editing_notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "content"
    t.integer  "source_id"
    t.string   "title_url"
    t.integer  "section_id"
    t.string   "external_video_url"
    t.string   "fragment_title_text"
    t.string   "external_url_text"
    t.string   "primary_medium"
    t.integer  "magazine_issue_id"
    t.boolean  "premium"
    t.integer  "media_detail_id"
    t.datetime "publish_date"
    t.datetime "expiry_date"
    t.datetime "display_date"
    t.integer  "language_id"
    t.integer  "content_word_count"
    t.text     "extended_body"
    t.integer  "blog_id"
    t.text     "text_for_highlighting"
    t.string   "title_of_feed"
    t.string   "link_to_title_of_feed"
    t.text     "original_source"
    t.boolean  "full_header_and_footer"
    t.boolean  "right_hand_column"
    t.text     "mobile_content"
    t.integer  "mobile_content_word_count"
    t.boolean  "flash_news"
    t.string   "seo_title"
    t.integer  "city_id"
    t.text     "link_type"
    t.text     "video_stream_id"
    t.string   "sponsored"
    t.string   "asset_source"
    t.string   "asset_source_alias"
    t.integer  "primary_category_id"
  end

  add_index "article_contents", ["article_id"], :name => "index_article_contents_on_article_id"
  add_index "article_contents", ["asset_source"], :name => "index_article_contents_on_asset_source"
  add_index "article_contents", ["source_id"], :name => "index_article_contents_on_source_id"
  add_index "article_contents", ["title"], :name => "article_contents_title_idx"

  create_table "article_contents_categories", :force => true do |t|
    t.integer "article_content_id"
    t.integer "category_id"
    t.integer "sequence_number",                       :null => false
    t.boolean "system",             :default => false
    t.boolean "autonomy_flag",      :default => false
    t.integer "relevance"
  end

  add_index "article_contents_categories", ["article_content_id"], :name => "index_article_contents_categories_on_article_content_id"
  add_index "article_contents_categories", ["category_id", "article_content_id"], :name => "by_artcon_cat"

  create_table "article_contents_images", :id => false, :force => true do |t|
    t.integer "article_content_id", :null => false
    t.integer "image_id",           :null => false
  end

  create_table "article_contents_related_companies", :id => false, :force => true do |t|
    t.integer "article_content_id"
    t.integer "related_company_id"
  end

  create_table "article_contents_related_company_aliases", :id => false, :force => true do |t|
    t.integer "article_content_id"
    t.integer "related_company_alias_id"
    t.integer "id"
    t.integer "sequence_number"
  end

  create_table "article_contents_sites", :id => false, :force => true do |t|
    t.integer "article_content_id", :null => false
    t.integer "data_proxy_id",      :null => false
  end

  add_index "article_contents_sites", ["article_content_id"], :name => "index_article_contents_sites_on_article_content_id"
  add_index "article_contents_sites", ["data_proxy_id", "article_content_id"], :name => "by_sit_artcon"

  create_table "article_contents_tags", :force => true do |t|
    t.integer "article_content_id"
    t.integer "tag_id"
    t.integer "sequence_number"
  end

  add_index "article_contents_tags", ["article_content_id"], :name => "index_article_contents_tags_on_article_content_id"
  add_index "article_contents_tags", ["tag_id", "article_content_id"], :name => "by_artcon_tag"

  create_table "article_further_readings", :force => true do |t|
    t.integer  "article_id"
    t.integer  "article_further_reading_id"
    t.integer  "sequence_no"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "article_products", :force => true do |t|
    t.integer  "product_id"
    t.integer  "article_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "article_products", ["article_id"], :name => "article_id"
  add_index "article_products", ["product_id"], :name => "product_id"

  create_table "article_reads", :force => true do |t|
    t.integer  "article_id"
    t.datetime "created_at"
  end

  add_index "article_reads", ["article_id"], :name => "index_article_reads_on_article_id"
  add_index "article_reads", ["created_at"], :name => "index_article_reads_on_created_at"

  create_table "articles", :force => true do |t|
    t.string   "title",                 :limit => 10000
    t.integer  "counter"
    t.integer  "latest_version_id"
    t.integer  "published_version_id"
    t.datetime "publish_date"
    t.datetime "expiry_date"
    t.boolean  "active"
    t.boolean  "in_embargo"
    t.boolean  "expired"
    t.string   "url_part"
    t.datetime "display_date"
    t.integer  "comments_count",                                                        :default => 0
    t.integer  "total_rating",                                                          :default => 0
    t.integer  "number_of_times_rated",                                                 :default => 0
    t.integer  "most_read",                                                             :default => 0
    t.integer  "most_commented",                                                        :default => 0
    t.decimal  "average_rating",                         :precision => 10, :scale => 0
    t.integer  "template_id"
    t.string   "template_type"
    t.boolean  "is_draft",                                                              :default => false
    t.integer  "portal_id"
    t.integer  "image_id"
    t.integer  "section_id"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "source_id"
    t.integer  "media_detail_id"
    t.boolean  "premium"
    t.integer  "magazine_issue_id"
    t.string   "fragment_title_text"
    t.string   "primary_medium"
    t.integer  "image_sequence_id"
    t.integer  "language_id"
    t.integer  "audio_id"
    t.integer  "content_word_count"
    t.integer  "group_id"
    t.boolean  "waiting_for_approval"
    t.integer  "blog_id"
    t.boolean  "for_approval_email"
    t.integer  "subsection_id"
    t.boolean  "flash_news"
    t.string   "seo_title"
    t.integer  "city_id"
    t.string   "format"
    t.string   "meta_keywords"
    t.string   "meta_description"
    t.string   "link_type"
    t.text     "video_stream_id"
    t.string   "sponsored"
    t.string   "asset_source"
    t.string   "asset_source_alias"
    t.integer  "primary_category_id"
  end

  add_index "articles", ["asset_source"], :name => "index_articles_on_asset_source"
  add_index "articles", ["created_at"], :name => "index_articles_on_created_at"
  add_index "articles", ["display_date"], :name => "index_articles_on_display_date"
  add_index "articles", ["most_commented"], :name => "index_articles_on_most_commented"
  add_index "articles", ["most_read"], :name => "index_articles_on_most_read"
  add_index "articles", ["publish_date"], :name => "index_articles_on_publish_date"
  add_index "articles", ["section_id", "display_date"], :name => "section_id_display_date"
  add_index "articles", ["source_id", "display_date"], :name => "key_source_id_display_date"
  add_index "articles", ["title"], :name => "index_articles_on_title"
  add_index "articles", ["updated_at"], :name => "index_articles_on_updated_at"
  add_index "articles", ["url_part"], :name => "index_articles_on_url_part"

  create_table "articles_categories", :force => true do |t|
    t.integer "article_id"
    t.integer "category_id"
    t.integer "sequence_number",                    :null => false
    t.boolean "system",          :default => false
    t.integer "relevance"
    t.boolean "autonomy_flag",   :default => false
  end

  add_index "articles_categories", ["article_id"], :name => "index_articles_categories_on_article_id"
  add_index "articles_categories", ["category_id", "article_id"], :name => "by_cat_art"

  create_table "articles_directors", :id => false, :force => true do |t|
    t.integer "article_id",  :null => false
    t.integer "director_id", :null => false
  end

  add_index "articles_directors", ["article_id"], :name => "index_articles_directors_on_article_id"
  add_index "articles_directors", ["director_id", "article_id"], :name => "by_art_director"

  create_table "articles_images", :id => false, :force => true do |t|
    t.integer "article_id", :null => false
    t.integer "image_id",   :null => false
  end

  create_table "articles_related_companies", :id => false, :force => true do |t|
    t.integer "article_id"
    t.integer "related_company_id"
  end

  create_table "articles_related_company_aliases", :id => false, :force => true do |t|
    t.integer "article_id"
    t.integer "related_company_alias_id"
    t.integer "id"
    t.integer "sequence_number"
  end

  create_table "articles_sites", :id => false, :force => true do |t|
    t.integer "article_id",    :null => false
    t.integer "data_proxy_id", :null => false
  end

  add_index "articles_sites", ["article_id"], :name => "index_articles_sites_on_article_id"
  add_index "articles_sites", ["data_proxy_id", "article_id"], :name => "by_sit_art"

  create_table "articles_tags", :force => true do |t|
    t.integer "article_id"
    t.integer "tag_id"
    t.integer "sequence_number"
  end

  add_index "articles_tags", ["article_id"], :name => "index_articles_tags_on_article_id"
  add_index "articles_tags", ["tag_id", "article_id"], :name => "by_art_tag"

  create_table "asp_application_supports", :id => false, :force => true do |t|
    t.integer  "document_id",                        :null => false
    t.integer  "asp_primary_application_support_id", :null => false
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "asp_primary_application_supports", :force => true do |t|
    t.string   "name"
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "asset_categories", :force => true do |t|
    t.string   "name"
    t.string   "alias_name"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "asset_categories_asset_conditions", :id => false, :force => true do |t|
    t.integer "asset_condition_id"
    t.integer "asset_category_id"
  end

  add_index "asset_categories_asset_conditions", ["asset_category_id"], :name => "index_asset_categories_asset_conditions_on_asset_category_id"
  add_index "asset_categories_asset_conditions", ["asset_condition_id", "asset_category_id"], :name => "by_assconasscat_cat"

  create_table "asset_categories_digital_assets", :id => false, :force => true do |t|
    t.integer "digital_asset_id"
    t.integer "asset_category_id"
  end

  add_index "asset_categories_digital_assets", ["asset_category_id", "digital_asset_id"], :name => "by_asset_category_digass"
  add_index "asset_categories_digital_assets", ["digital_asset_id"], :name => "index_asset_categories_digital_assets_on_digital_asset_id"

  create_table "asset_categories_sites", :id => false, :force => true do |t|
    t.integer "asset_category_id"
    t.integer "data_proxy_id"
  end

  add_index "asset_categories_sites", ["asset_category_id"], :name => "index_asset_categories_sites_on_asset_category_id"
  add_index "asset_categories_sites", ["data_proxy_id", "asset_category_id"], :name => "by_sit_asscat"

  create_table "asset_categorys", :force => true do |t|
    t.string  "name"
    t.string  "alias_name"
    t.integer "created_by"
    t.integer "updated_by"
  end

  create_table "asset_conditions", :force => true do |t|
    t.string   "type"
    t.string   "date_type"
    t.datetime "from_date"
    t.datetime "to_date"
    t.integer  "asset_group_id"
    t.integer  "site_id"
    t.integer  "category_id"
    t.integer  "tag_id"
    t.integer  "section_id"
    t.integer  "older_than"
    t.integer  "newer_than"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "premium"
    t.integer  "source_id"
    t.boolean  "magazine_issue"
    t.boolean  "video_article"
    t.boolean  "audio_article"
    t.boolean  "audio_or_video_article"
    t.integer  "latest_magazine_issue_from_source"
    t.integer  "blog_id"
  end

  add_index "asset_conditions", ["asset_group_id"], :name => "index_asset_conditions_on_asset_group_id"
  add_index "asset_conditions", ["magazine_issue"], :name => "index_asset_conditions_on_magazine_issue"
  add_index "asset_conditions", ["newer_than"], :name => "index_asset_conditions_on_newer_than"
  add_index "asset_conditions", ["older_than"], :name => "index_asset_conditions_on_older_than"
  add_index "asset_conditions", ["premium"], :name => "index_asset_conditions_on_premium"
  add_index "asset_conditions", ["source_id"], :name => "index_asset_conditions_on_source_id"
  add_index "asset_conditions", ["type"], :name => "index_asset_conditions_on_type"

  create_table "asset_conditions_authors", :id => false, :force => true do |t|
    t.integer  "asset_condition_id"
    t.integer  "author_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "asset_conditions_blogs", :id => false, :force => true do |t|
    t.integer  "asset_condition_id"
    t.integer  "blog_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "asset_conditions_categories", :id => false, :force => true do |t|
    t.integer "asset_condition_id", :null => false
    t.integer "category_id",        :null => false
  end

  add_index "asset_conditions_categories", ["asset_condition_id", "category_id"], :name => "by_assconcat_cat"
  add_index "asset_conditions_categories", ["category_id"], :name => "index_asset_conditions_categories_on_category_id"

  create_table "asset_conditions_questionnaires", :id => false, :force => true do |t|
    t.integer  "asset_condition_id"
    t.integer  "questionnaire_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "asset_conditions_sections", :id => false, :force => true do |t|
    t.integer "asset_condition_id", :null => false
    t.integer "section_id",         :null => false
  end

  add_index "asset_conditions_sections", ["asset_condition_id", "section_id"], :name => "by_assconsec_sec"
  add_index "asset_conditions_sections", ["section_id"], :name => "index_asset_conditions_sections_on_section_id"

  create_table "asset_conditions_sites", :id => false, :force => true do |t|
    t.integer "asset_condition_id", :null => false
    t.integer "data_proxy_id",      :null => false
  end

  create_table "asset_conditions_tags", :id => false, :force => true do |t|
    t.integer "asset_condition_id", :null => false
    t.integer "tag_id",             :null => false
  end

  add_index "asset_conditions_tags", ["asset_condition_id", "tag_id"], :name => "by_asscontag_tag"
  add_index "asset_conditions_tags", ["tag_id"], :name => "index_asset_conditions_tags_on_tag_id"

  create_table "asset_groups", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "entity_type"
    t.integer  "presentation_proxy_id"
    t.string   "template"
  end

  add_index "asset_groups", ["name"], :name => "index_asset_groups_on_name"

  create_table "asset_groups_products", :id => false, :force => true do |t|
    t.integer "product_id",     :null => false
    t.integer "asset_group_id", :null => false
  end

  add_index "asset_groups_products", ["asset_group_id"], :name => "index_asset_groups_products_on_asset_group_id"
  add_index "asset_groups_products", ["product_id", "asset_group_id"], :name => "by_agp_prod"

  create_table "asset_sources", :force => true do |t|
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "alias_name"
  end

  add_index "asset_sources", ["alias_name"], :name => "index_asset_sources_on_alias_name"
  add_index "asset_sources", ["name"], :name => "index_asset_sources_on_name"

  create_table "audios", :force => true do |t|
    t.integer  "data_proxy_id"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.string   "name"
    t.string   "audio_path"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.string   "description"
    t.string   "caption"
  end

  add_index "audios", ["data_proxy_id"], :name => "index_audios_on_site_id"
  add_index "audios", ["name"], :name => "index_audios_on_name"

  create_table "audit_details", :force => true do |t|
    t.integer "audit_id"
    t.string  "attr",      :limit => 50
    t.string  "old_value", :limit => 2000
    t.string  "new_value", :limit => 2000
  end

  add_index "audit_details", ["audit_id"], :name => "index_audit_details_on_audit_id"

  create_table "audits", :force => true do |t|
    t.string   "entity_type", :limit => 50
    t.integer  "entity_id"
    t.string   "event",       :limit => 10
    t.datetime "created_at"
    t.integer  "created_by"
  end

  add_index "audits", ["created_at"], :name => "index_audits_on_created_at"
  add_index "audits", ["created_by"], :name => "audit_created_by_index"
  add_index "audits", ["entity_type", "entity_id"], :name => "audits_enity_index"

  create_table "author_aliases", :force => true do |t|
    t.string   "name"
    t.integer  "author_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "author_further_readings", :force => true do |t|
    t.integer  "author_id"
    t.integer  "article_id"
    t.integer  "sequence_no"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "author_profiles", :force => true do |t|
    t.string   "professional_title"
    t.string   "title"
    t.string   "company_name"
    t.string   "company_website_url"
    t.string   "meta_description"
    t.string   "meta_keywords"
    t.string   "meta_title"
    t.string   "twitter_url"
    t.string   "twitter_user_name"
    t.string   "description"
    t.string   "linkedin_url"
    t.boolean  "elected_to_speak"
    t.integer  "author_id"
    t.text     "biography"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "facebook_url"
    t.string   "youtube_url"
    t.string   "blog_url"
    t.text     "recommendation"
    t.string   "company_linkedin_url"
    t.text     "google_plus"
    t.text     "contact"
    t.text     "address"
    t.text     "phone"
    t.text     "fax"
    t.text     "locations"
  end

  create_table "authors", :force => true do |t|
    t.string   "author_image_path"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "email"
    t.string   "job_title"
    t.integer  "user_id"
    t.string   "middle_name"
    t.boolean  "active"
    t.string   "fullname"
    t.string   "delivery_email"
    t.string   "author_type"
    t.integer  "subscriber_id"
    t.string   "profile_name"
  end

  add_index "authors", ["firstname"], :name => "index_authors_on_firstname"

  create_table "authors_categories", :id => false, :force => true do |t|
    t.integer "category_id", :null => false
    t.integer "author_id",   :null => false
  end

  add_index "authors_categories", ["author_id", "category_id"], :name => "by_author_cat"
  add_index "authors_categories", ["category_id"], :name => "index_authors_categories_on_category_id"

  create_table "authors_sites", :id => false, :force => true do |t|
    t.integer "author_id",     :null => false
    t.integer "data_proxy_id"
    t.integer "site_id"
  end

  create_table "autonomy_search_audits", :force => true do |t|
    t.string   "query_text"
    t.integer  "site_id"
    t.datetime "created_at",  :null => false
    t.integer  "created_by"
    t.integer  "updated_by"
    t.string   "search_type"
    t.datetime "updated_at"
  end

  add_index "autonomy_search_audits", ["query_text"], :name => "query_text"
  add_index "autonomy_search_audits", ["site_id"], :name => "site_id"

  create_table "blogs", :force => true do |t|
    t.integer  "data_proxy_id"
    t.string   "url_part"
    t.string   "name"
    t.string   "alias_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "blogs_data_lists", :id => false, :force => true do |t|
    t.integer  "blog_id"
    t.integer  "data_list_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bookmark_details", :force => true do |t|
    t.string   "bookmark_name"
    t.string   "url_path"
    t.integer  "user_id"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bookmark_details", ["user_id"], :name => "index_bookmark_details_on_user_id"

  create_table "brands", :force => true do |t|
    t.string   "site_name"
    t.string   "short_name"
    t.integer  "site_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "brands_sites", :id => false, :force => true do |t|
    t.integer "brand_id"
    t.integer "site_id"
  end

  create_table "breadcrum_values", :force => true do |t|
    t.integer  "page_property_id"
    t.string   "display"
    t.string   "link"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "entity_type"
    t.string   "value"
  end

  create_table "budget_ranges", :force => true do |t|
    t.string   "name"
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bureaus", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "business_sizes", :force => true do |t|
    t.string   "name"
    t.string   "old_id"
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sequence"
  end

  create_table "business_sizes_documents", :id => false, :force => true do |t|
    t.integer  "document_id",      :null => false
    t.integer  "business_size_id", :null => false
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cache_counts", :force => true do |t|
    t.text     "sql_query"
    t.integer  "count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cache_counts", ["sql_query"], :name => "index_cache_counts_on_sql_query"

  create_table "cache_expiry_times", :force => true do |t|
    t.string   "page_type"
    t.integer  "site_id"
    t.integer  "soft_expriy_interval"
    t.integer  "hard_expriy_interval"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "soft_expriy_interval_in_format"
    t.integer  "hard_expriy_interval_in_format"
  end

  add_index "cache_expiry_times", ["site_id", "page_type"], :name => "index_cache_expiry_times_on_site_id_and_page_type"

  create_table "campaigns", :force => true do |t|
    t.string   "name"
    t.string   "overview",         :limit => 3500
    t.integer  "company_id"
    t.boolean  "status"
    t.string   "lead_status"
    t.integer  "sales_contact_id"
    t.integer  "admin_user_id"
    t.integer  "filter_id"
    t.string   "exclude_student"
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "logo_path",                        :default => "/campaign/defaultlogoOPT1.jpg"
    t.integer  "questionnaire_id"
    t.string   "display_name",     :limit => 500
  end

  add_index "campaigns", ["company_id"], :name => "index_campaigns_on_company_id"

  create_table "campaigns_users", :id => false, :force => true do |t|
    t.integer  "campaign_id", :null => false
    t.integer  "user_id",     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "campaigns_wpls", :id => false, :force => true do |t|
    t.integer  "campaign_id", :null => false
    t.integer  "wpl_id",      :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "campaigns_wpls", ["campaign_id"], :name => "index_campaigns_wpls_on_campaign_id"
  add_index "campaigns_wpls", ["wpl_id"], :name => "index_campaigns_wpls_on_wpl_id"

  create_table "categories", :force => true do |t|
    t.integer  "parent_id"
    t.string   "name"
    t.string   "full_name"
    t.string   "full_alias_name"
    t.string   "alias_name"
    t.integer  "sequence_number"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "copied_from"
    t.text     "css"
  end

  add_index "categories", ["alias_name"], :name => "index_categories_on_alias_name"
  add_index "categories", ["full_alias_name"], :name => "index_categories_on_full_alias_name"
  add_index "categories", ["full_name"], :name => "index_categories_on_full_name"
  add_index "categories", ["name"], :name => "index_categories_on_name"
  add_index "categories", ["parent_id"], :name => "index_categories_on_parent_id"

  create_table "categories_portals", :id => false, :force => true do |t|
    t.integer "category_id", :null => false
    t.integer "portal_id",   :null => false
  end

  add_index "categories_portals", ["category_id", "portal_id"], :name => "by_cat_por"
  add_index "categories_portals", ["portal_id"], :name => "index_categories_portals_on_portal_id"

  create_table "categories_sites", :id => false, :force => true do |t|
    t.integer "category_id",   :null => false
    t.integer "data_proxy_id", :null => false
  end

  add_index "categories_sites", ["category_id"], :name => "index_categories_sites_on_category_id"
  add_index "categories_sites", ["data_proxy_id", "category_id"], :name => "by_sit_cat"

  create_table "classified_listing_categories_classifieds", :id => false, :force => true do |t|
    t.integer "classified_listing_category_id", :null => false
    t.integer "classified_id",                  :null => false
  end

  create_table "classified_listing_categories_directory_listings", :id => false, :force => true do |t|
    t.integer "classified_listing_category_id"
    t.integer "directory_listing_id"
  end

  create_table "classified_listing_categories_sites", :id => false, :force => true do |t|
    t.integer "classified_listing_category_id", :null => false
    t.integer "data_proxy_id",                  :null => false
  end

  create_table "collateral_types", :force => true do |t|
    t.string   "name"
    t.string   "short_name"
    t.string   "updated_by"
    t.string   "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "collaterals", :force => true do |t|
    t.string   "file_path"
    t.string   "url"
    t.string   "display_name"
    t.string   "comments"
    t.integer  "collateral_type_id"
    t.integer  "collateral_item_id"
    t.string   "collateral_item_type"
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comment_complaints", :force => true do |t|
    t.integer  "comment_id"
    t.string   "description"
    t.string   "contact_detail"
    t.string   "ipaddress"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comment_complaints", ["comment_id"], :name => "index_comment_complaints_on_comment_id"

  create_table "comments", :force => true do |t|
    t.integer  "entity_id"
    t.text     "title"
    t.string   "email"
    t.text     "description"
    t.string   "user_name"
    t.string   "status",           :default => "live"
    t.string   "ip_address"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "subscriber_id"
    t.string   "entity_type"
    t.string   "entity_attribute"
    t.integer  "parent_id"
    t.string   "name"
  end

  add_index "comments", ["entity_id", "created_at"], :name => "by_article_id_created_at"

  create_table "companies", :force => true do |t|
    t.integer  "campaign_id"
    t.string   "name"
    t.string   "overview",            :limit => 3500
    t.string   "partner"
    t.string   "url"
    t.string   "email"
    t.date     "founded_year"
    t.integer  "annual_sales_volume"
    t.integer  "no_of_employees"
    t.string   "user_data"
    t.integer  "company_language_id"
    t.integer  "admin_user_id"
    t.integer  "company_user_id"
    t.string   "logo_path",                           :default => "/company/defaultlogoOPT1.jpg"
    t.string   "old_id"
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "companies_users", :id => false, :force => true do |t|
    t.integer  "company_id", :null => false
    t.integer  "user_id",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "companies_wpls", :id => false, :force => true do |t|
    t.integer  "company_id", :null => false
    t.integer  "wpl_id",     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "companies_wpls", ["company_id"], :name => "index_companies_wpls_on_company_id"
  add_index "companies_wpls", ["wpl_id"], :name => "index_companies_wpls_on_wpl_id"

  create_table "company_languages", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "company_locations", :force => true do |t|
    t.string   "name"
    t.string   "main_phone"
    t.string   "fax"
    t.string   "additional_phone"
    t.integer  "country_id"
    t.string   "address1"
    t.string   "address2"
    t.string   "address3"
    t.string   "address4"
    t.string   "city"
    t.string   "zip"
    t.integer  "county_id"
    t.integer  "company_id"
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "company_locations", ["company_id"], :name => "index_company_locations_on_company_id"

  create_table "company_locations_languages", :id => false, :force => true do |t|
    t.integer  "language_id",         :null => false
    t.integer  "company_location_id", :null => false
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "company_locations_location_types", :id => false, :force => true do |t|
    t.integer  "company_location_id", :null => false
    t.integer  "location_type_id",    :null => false
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "component_cache_scopes", :force => true do |t|
    t.integer  "component_cache_id"
    t.string   "entity_type"
    t.string   "entity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "component_cache_scopes", ["component_cache_id"], :name => "index_component_cache_scopes_on_component_cache_id"
  add_index "component_cache_scopes", ["entity_id"], :name => "index_component_cache_scopes_on_entity_id"
  add_index "component_cache_scopes", ["entity_type"], :name => "index_component_cache_scopes_on_entity_type"

  create_table "component_caches", :force => true do |t|
    t.integer  "site_id"
    t.string   "name"
    t.datetime "expires_in"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "component_caches", ["name"], :name => "index_component_caches_on_name"
  add_index "component_caches", ["site_id", "name"], :name => "index_component_caches_on_site_id_and_name"
  add_index "component_caches", ["site_id"], :name => "index_component_caches_on_site_id"

  create_table "component_containers", :force => true do |t|
    t.string   "position"
    t.integer  "template_id"
    t.text     "container_type"
    t.integer  "site_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "component_properties", :force => true do |t|
    t.integer  "component_id"
    t.string   "name"
    t.string   "value",        :limit => 100000
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "component_widgets", :force => true do |t|
    t.integer  "widget_id"
    t.integer  "component_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
  end

  create_table "components", :force => true do |t|
    t.integer  "site_id"
    t.string   "name"
    t.string   "short_name"
    t.string   "url"
    t.integer  "number_of_items"
    t.integer  "number_of_prominent"
    t.integer  "cache_duration"
    t.boolean  "status"
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "paginate"
    t.string   "data_string_entity"
    t.string   "entry_value"
    t.integer  "fragment_id"
    t.integer  "presentation_proxy_id"
    t.integer  "parent_id"
  end

  add_index "components", ["site_id"], :name => "index_components_on_site_id"

  create_table "components_curates", :force => true do |t|
    t.integer  "component_id"
    t.integer  "curate_id"
    t.string   "type"
    t.integer  "col"
    t.integer  "row"
    t.string   "status"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "components_data_lists", :id => false, :force => true do |t|
    t.integer  "component_id"
    t.integer  "data_list_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "components_featured_sets", :id => false, :force => true do |t|
    t.integer "component_id"
    t.integer "featured_set_id"
  end

  create_table "configuration_groups", :force => true do |t|
    t.integer  "site_id"
    t.string   "group"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "group_name"
  end

  create_table "configuration_values", :force => true do |t|
    t.integer  "configuration_group_id"
    t.string   "key"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "value"
  end

  create_table "contact_details", :force => true do |t|
    t.integer  "entity_id"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.string   "phone_number"
    t.string   "fax_number"
    t.string   "name"
    t.string   "email"
    t.string   "entity_type"
    t.string   "website_name"
    t.boolean  "primary"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "address1"
    t.string   "address2"
    t.string   "address3"
    t.string   "address4"
    t.string   "post_code"
    t.string   "country"
    t.string   "address5"
    t.string   "pr_contact"
    t.string   "pr_email"
    t.string   "pr_number"
  end

  add_index "contact_details", ["email"], :name => "index_contact_details_on_email"
  add_index "contact_details", ["entity_id"], :name => "index_contact_details_on_entity_id"
  add_index "contact_details", ["entity_type"], :name => "index_contact_details_on_entity_type"
  add_index "contact_details", ["fax_number"], :name => "index_contact_details_on_fax_number"
  add_index "contact_details", ["name"], :name => "index_contact_details_on_name"
  add_index "contact_details", ["phone_number"], :name => "index_contact_details_on_phone_number"
  add_index "contact_details", ["website_name"], :name => "index_contact_details_on_website_name"

  create_table "contacts", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "desigination"
    t.integer  "site_id"
    t.integer  "phonenumber"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "contacts", ["site_id"], :name => "index_contacts_on_site_id"

  create_table "container_components", :force => true do |t|
    t.integer  "component_id"
    t.integer  "component_container"
    t.integer  "component_container_id"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "container_id"
  end

  create_table "container_connected_withs", :force => true do |t|
    t.integer  "container_id"
    t.integer  "container_connect_with_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "container_pages", :force => true do |t|
    t.integer  "position"
    t.integer  "page_id"
    t.integer  "container_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "containers", :force => true do |t|
    t.integer  "position"
    t.integer  "template_id"
    t.string   "name"
    t.text     "container_type"
    t.integer  "site_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "presentation_proxy_id"
  end

  create_table "counties", :force => true do |t|
    t.integer  "country_id"
    t.string   "name"
    t.string   "old_id"
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "countries", :force => true do |t|
    t.string   "name"
    t.string   "old_id"
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "countries_services", :force => true do |t|
    t.integer  "country_id"
    t.integer  "service_id"
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "data_lists", :force => true do |t|
    t.integer  "asset_group_id"
    t.string   "display_name"
    t.string   "data_string",           :limit => 10000
    t.string   "data_list_type"
    t.string   "data_type"
    t.boolean  "context"
    t.integer  "limit"
    t.integer  "integer"
    t.boolean  "paginate"
    t.string   "page"
    t.text     "per_page"
    t.string   "name"
    t.string   "entity"
    t.string   "sort"
    t.string   "automated_data_string", :limit => 10000
    t.string   "ranklist"
    t.integer  "presentation_proxy_id"
    t.string   "entry_value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "display_data_string"
  end

  create_table "data_lists_featured_sets", :id => false, :force => true do |t|
    t.integer  "data_list_id"
    t.integer  "featured_set_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "data_proxies", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "databases", :force => true do |t|
    t.string   "name"
    t.string   "alias_name"
    t.integer  "site_id"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type"
  end

  create_table "debate_configurations", :force => true do |t|
    t.string   "contact_email"
    t.string   "twitter_feed"
    t.string   "facebook_page"
    t.integer  "site_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "debate_configurations", ["site_id"], :name => "debate_configurations_site_id"

  create_table "debate_contributors", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.text     "short_description"
    t.text     "full_description"
    t.integer  "image_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "debate_contributors", ["name"], :name => "debate_contributors_name"

  create_table "debate_phases", :force => true do |t|
    t.integer  "debate_id"
    t.integer  "phase_id"
    t.text     "description"
    t.integer  "phase_order"
    t.string   "title"
    t.datetime "start_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "debate_phases", ["debate_id"], :name => "debate_phases_debate_id"
  add_index "debate_phases", ["phase_id"], :name => "debate_phases_phase_id"
  add_index "debate_phases", ["start_date"], :name => "debate_phases_start_date"

  create_table "debate_role_types", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "debate_role_types", ["name"], :name => "debate_role_types_name"

  create_table "debate_roles", :force => true do |t|
    t.string   "name"
    t.integer  "debate_role_type_id"
    t.integer  "debate_id"
    t.integer  "debate_contributor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "debate_roles", ["debate_contributor_id"], :name => "debate_roles_debate_contributor_id"
  add_index "debate_roles", ["debate_id"], :name => "debate_roles_debate_id"

  create_table "debate_sponsors", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.text     "short_description"
    t.text     "full_description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "debate_sponsors", ["name"], :name => "debate_sponsors_name"

  create_table "debate_sponsors_debates", :id => false, :force => true do |t|
    t.integer "debate_id"
    t.integer "debate_sponsor_id"
  end

  add_index "debate_sponsors_debates", ["debate_id", "debate_sponsor_id"], :name => "debate_sponsors_debates_debate_debate_sponsor_ids"

  create_table "debate_statements", :force => true do |t|
    t.integer  "debate_phase_id"
    t.text     "short_summary"
    t.text     "summary"
    t.integer  "debate_role_id"
    t.integer  "debate_contributor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "debate_statements", ["debate_contributor_id"], :name => "debate_statements_debate_contributor_id"
  add_index "debate_statements", ["debate_phase_id"], :name => "debate_statements_debate_phase_id"

  create_table "debate_voters", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email_address"
    t.string   "password"
    t.string   "screen_name"
    t.integer  "title"
    t.integer  "site_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "incisive_option_flag"
    t.boolean  "third_party_option_flag"
    t.boolean  "terms_condition"
    t.datetime "last_login"
  end

  add_index "debate_voters", ["site_id"], :name => "debate_voters_site_id"

  create_table "debate_votes", :force => true do |t|
    t.integer  "debate_voter_id"
    t.integer  "debate_phase_id"
    t.integer  "debate_role_id"
    t.integer  "debate_contributor_id"
    t.boolean  "for_the_motion"
    t.string   "rem_me_key"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "debate_votes", ["debate_contributor_id"], :name => "debate_votes_debate_contributor_id"
  add_index "debate_votes", ["debate_phase_id"], :name => "debate_votes_debate_phase_id"
  add_index "debate_votes", ["for_the_motion"], :name => "debate_votes_for_the_motion"
  add_index "debate_votes", ["rem_me_key"], :name => "debate_votes_rem_me_key"

  create_table "debates", :force => true do |t|
    t.string   "motion"
    t.datetime "starting_date"
    t.datetime "ending_date"
    t.text     "short_description"
    t.text     "long_description"
    t.integer  "image_set_id"
    t.integer  "sponsor_id"
    t.integer  "site_id"
    t.integer  "user_id"
    t.integer  "status"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.text     "winning_statement"
    t.string   "winner"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "debates", ["ending_date"], :name => "debates_ending_date"
  add_index "debates", ["site_id"], :name => "debates_site_id"
  add_index "debates", ["starting_date"], :name => "debates_starting_date"
  add_index "debates", ["status"], :name => "debates_status"

  create_table "default_display_setups", :force => true do |t|
    t.integer "campaign_id", :null => false
    t.integer "filter_id",   :null => false
  end

  create_table "digital_asset_properties", :force => true do |t|
    t.string   "entity_type"
    t.string   "display_name"
    t.integer  "entity_id"
    t.integer  "digital_asset_id"
    t.integer  "sequence_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "digital_assets", :force => true do |t|
    t.integer  "data_proxy_id"
    t.string   "name"
    t.string   "display_name"
    t.string   "description",    :limit => 10000
    t.string   "document_path"
    t.integer  "file_size"
    t.string   "tag"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "protected"
    t.integer  "source_id"
    t.integer  "download_count"
  end

  add_index "digital_assets", ["data_proxy_id"], :name => "index_digital_assets_on_site_id"

  create_table "digital_assets_products", :id => false, :force => true do |t|
    t.integer "digital_asset_id"
    t.integer "product_id"
  end

  create_table "directories_directory_listing_categories", :id => false, :force => true do |t|
    t.integer "directory_id",                  :null => false
    t.integer "directory_listing_category_id", :null => false
  end

  create_table "directories_directory_sponsors", :id => false, :force => true do |t|
    t.integer "directory_sponsor_id", :null => false
    t.integer "directory_id",         :null => false
  end

  add_index "directories_directory_sponsors", ["directory_id", "directory_sponsor_id"], :name => "by_dir_dir_spnsor"
  add_index "directories_directory_sponsors", ["directory_sponsor_id"], :name => "index_directories_directory_sponsors_on_directory_sponsor_id"

  create_table "directories_locations", :id => false, :force => true do |t|
    t.integer "directory_id", :null => false
    t.integer "location_id",  :null => false
  end

  create_table "directories_memberships", :id => false, :force => true do |t|
    t.integer "directory_id",  :null => false
    t.integer "membership_id", :null => false
  end

  create_table "directories_services", :id => false, :force => true do |t|
    t.integer "directory_id", :null => false
    t.integer "service_id",   :null => false
  end

  create_table "directors", :force => true do |t|
    t.integer  "article_id"
    t.integer  "image_id"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.string   "name"
    t.string   "job_title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "directors", ["article_id"], :name => "index_directors_on_article_id"

  create_table "directory_listing_categories_directory_listings", :id => false, :force => true do |t|
    t.integer "directory_listing_category_id", :null => false
    t.integer "directory_listing_id",          :null => false
  end

  add_index "directory_listing_categories_directory_listings", ["directory_listing_category_id"], :name => "index_directories_directory_categories_on_directory_category_id"
  add_index "directory_listing_categories_directory_listings", ["directory_listing_id", "directory_listing_category_id"], :name => "by_dir_dir_cat"

  create_table "directory_listing_categories_sites", :id => false, :force => true do |t|
    t.integer "directory_listing_category_id", :null => false
    t.integer "data_proxy_id",                 :null => false
  end

  add_index "directory_listing_categories_sites", ["data_proxy_id", "directory_listing_category_id"], :name => "by_site_dir_cat"
  add_index "directory_listing_categories_sites", ["directory_listing_category_id"], :name => "index_directory_categories_sites_on_directory_category_id"

  create_table "directory_listings", :force => true do |t|
    t.integer  "data_proxy_id"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.integer  "image_id"
    t.string   "name"
    t.text     "description"
    t.boolean  "premium"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_sponsor"
    t.boolean  "status",         :default => true
    t.float    "average_rating"
    t.string   "ses_company"
    t.integer  "directory_id"
    t.integer  "classified_id"
    t.datetime "display_date"
    t.datetime "start_date"
    t.datetime "end_date"
    t.string   "company_name"
  end

  add_index "directory_listings", ["data_proxy_id"], :name => "index_directories_on_site_id"
  add_index "directory_listings", ["image_id"], :name => "index_directories_on_image_id"
  add_index "directory_listings", ["name"], :name => "index_directories_on_name"

  create_table "directory_listings_locations", :id => false, :force => true do |t|
    t.integer "location_id",          :null => false
    t.integer "directory_listing_id", :null => false
  end

  add_index "directory_listings_locations", ["directory_listing_id"], :name => "index_directories_locations_on_directory_id"
  add_index "directory_listings_locations", ["location_id", "directory_listing_id"], :name => "by_location_directory"

  create_table "directory_listings_memberships", :id => false, :force => true do |t|
    t.integer "membership_id",        :null => false
    t.integer "directory_listing_id", :null => false
  end

  add_index "directory_listings_memberships", ["directory_listing_id"], :name => "index_directories_memberships_on_directory_id"
  add_index "directory_listings_memberships", ["membership_id", "directory_listing_id"], :name => "by_member_directory"

  create_table "directory_listings_services", :id => false, :force => true do |t|
    t.integer "directory_listing_id", :null => false
    t.integer "service_id",           :null => false
  end

  add_index "directory_listings_services", ["directory_listing_id"], :name => "index_directories_services_on_directory_id"
  add_index "directory_listings_services", ["service_id", "directory_listing_id"], :name => "by_dir_ser"

  create_table "directory_sponsors", :force => true do |t|
    t.integer  "created_by"
    t.integer  "updated_by"
    t.integer  "image_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "directory_sponsors", ["image_id"], :name => "index_directory_sponsors_on_image_id"
  add_index "directory_sponsors", ["name"], :name => "index_directory_sponsors_on_company_name"

  create_table "document_types", :force => true do |t|
    t.string   "name"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "documents", :force => true do |t|
    t.string   "wpl_article_type"
    t.integer  "wpl_article_id"
    t.integer  "campaign_id"
    t.string   "solution_name"
    t.integer  "sales_contact"
    t.integer  "lead_contact"
    t.string   "summary",                    :limit => 3500
    t.text     "overview"
    t.string   "search_keywords",            :limit => 300
    t.text     "operating_system_notes"
    t.text     "supported_databases_notes"
    t.text     "training_notes"
    t.text     "support_notes"
    t.string   "unique_partnership"
    t.text     "network_notes"
    t.text     "programming_language_notes"
    t.text     "middleware_notes"
    t.boolean  "offer_sla"
    t.text     "describe_sla_options"
    t.text     "implementation_notes"
    t.boolean  "status"
    t.string   "is_sponsered"
    t.string   "incomplete_fields",          :limit => 3500
    t.text     "distinguishing_feature"
    t.integer  "updated_by"
    t.integer  "created_by"
    t.string   "product_url"
    t.string   "old_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "went_on_live"
    t.integer  "primary_taxonomy_id"
    t.string   "published_name"
    t.integer  "rank_count",                                 :default => 0
    t.string   "editor_summary",             :limit => 3000
  end

  add_index "documents", ["campaign_id"], :name => "index_documents_on_campaign_id"
  add_index "documents", ["updated_at"], :name => "index_documents_on_updated_at"
  add_index "documents", ["wpl_article_type"], :name => "index_documents_on_wpl_article_type"

  create_table "documents_industries", :id => false, :force => true do |t|
    t.integer  "document_id", :null => false
    t.integer  "industry_id", :null => false
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "documents_industries", ["document_id"], :name => "index_documents_industries_on_document_id"
  add_index "documents_industries", ["industry_id"], :name => "index_documents_industries_on_industry_id"

  create_table "documents_operating_environments", :id => false, :force => true do |t|
    t.integer  "document_id",              :null => false
    t.integer  "operating_environment_id", :null => false
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "documents_operating_environments", ["document_id"], :name => "index_documents_operating_environments_on_document_id"
  add_index "documents_operating_environments", ["operating_environment_id"], :name => "index_on_operating_environment_id"

  create_table "documents_operating_systems", :id => false, :force => true do |t|
    t.integer  "operating_system_id", :null => false
    t.integer  "document_id",         :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "documents_operating_systems", ["document_id"], :name => "index_documents_operating_systems_on_document_id"
  add_index "documents_operating_systems", ["operating_system_id"], :name => "index_on_operating_system_id"

  create_table "documents_product_customization_options", :id => false, :force => true do |t|
    t.integer  "document_id",                     :null => false
    t.integer  "product_customization_option_id", :null => false
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "documents_product_customization_options", ["document_id"], :name => "index_documents_product_customization_options_on_document_id"
  add_index "documents_product_customization_options", ["product_customization_option_id"], :name => "index_on_product_customization_option_id"

  create_table "documents_suggested_implementations", :id => false, :force => true do |t|
    t.integer  "document_id",                 :null => false
    t.integer  "suggested_implementation_id", :null => false
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "documents_suggested_implementations", ["document_id"], :name => "index_documents_suggested_implementations_on_document_id"
  add_index "documents_suggested_implementations", ["suggested_implementation_id"], :name => "index_on_suggested_implementation_id"

  create_table "documents_supported_databases", :id => false, :force => true do |t|
    t.integer  "document_id",           :null => false
    t.integer  "supported_database_id", :null => false
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "documents_supported_databases", ["document_id"], :name => "index_documents_supported_databases_on_document_id"
  add_index "documents_supported_databases", ["supported_database_id"], :name => "index_on_supported_database_id"

  create_table "documents_supported_middlewares", :id => false, :force => true do |t|
    t.integer  "document_id",             :null => false
    t.integer  "supported_middleware_id", :null => false
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "documents_supported_middlewares", ["document_id"], :name => "index_documents_supported_middlewares_on_document_id"
  add_index "documents_supported_middlewares", ["supported_middleware_id"], :name => "index_on_supported_middleware_id"

  create_table "documents_supported_networks", :id => false, :force => true do |t|
    t.integer  "document_id",          :null => false
    t.integer  "supported_network_id", :null => false
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "documents_supported_networks", ["document_id"], :name => "index_documents_supported_networks_on_document_id"
  add_index "documents_supported_networks", ["supported_network_id"], :name => "index_on_supported_network_id"

  create_table "documents_supported_programming_languages", :id => false, :force => true do |t|
    t.integer  "document_id",                       :null => false
    t.integer  "supported_programming_language_id", :null => false
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "documents_supported_programming_languages", ["document_id"], :name => "index_documents_supported_programming_languages_on_document_id"
  add_index "documents_supported_programming_languages", ["supported_programming_language_id"], :name => "index_on_supported_programming_language_id"

  create_table "documents_supports", :id => false, :force => true do |t|
    t.integer  "document_id", :null => false
    t.integer  "support_id",  :null => false
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "documents_supports", ["document_id"], :name => "index_documents_supports_on_document_id"
  add_index "documents_supports", ["support_id"], :name => "index_on_support_id"

  create_table "documents_tags", :id => false, :force => true do |t|
    t.integer  "document_id", :null => false
    t.integer  "tag_id",      :null => false
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "documents_tags", ["document_id"], :name => "index_documents_tags_on_document_id"
  add_index "documents_tags", ["tag_id"], :name => "index_documents_tags_on_tag_id"

  create_table "documents_wpl_taxonomies", :force => true do |t|
    t.integer  "document_id"
    t.integer  "wpl_taxonomy_id"
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sequence_number"
  end

  add_index "documents_wpl_taxonomies", ["document_id"], :name => "index_documents_wpl_taxonomies_on_document_id"
  add_index "documents_wpl_taxonomies", ["wpl_taxonomy_id"], :name => "index_documents_wpl_taxonomies_on_wpl_taxonomy_id"

  create_table "documents_wpls", :id => false, :force => true do |t|
    t.integer  "document_id", :null => false
    t.integer  "wpl_id",      :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "documents_wpls", ["document_id"], :name => "index_documents_wpls_on_document_id"
  add_index "documents_wpls", ["wpl_id"], :name => "index_documents_wpls_on_wpl_id"

  create_table "event_brands", :force => true do |t|
    t.string   "name"
    t.string   "short_name"
    t.integer  "site_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "event_brands_events", :id => false, :force => true do |t|
    t.integer "event_brand_id"
    t.integer "event_id"
  end

  create_table "event_business_areas", :force => true do |t|
    t.string   "name"
    t.integer  "site_id"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "event_cities", :force => true do |t|
    t.string   "name"
    t.integer  "event_country_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "event_cities", ["event_country_id"], :name => "index_event_cities_on_event_country_id"

  create_table "event_countries", :force => true do |t|
    t.string   "name"
    t.integer  "event_region_id"
    t.boolean  "training_country"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "event_countries", ["event_region_id"], :name => "index_event_countries_on_event_region_id"

  create_table "event_statuses", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "event_types", :force => true do |t|
    t.string   "name"
    t.string   "alias_name"
    t.integer  "order_by"
    t.integer  "listing_site_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", :force => true do |t|
    t.string   "title"
    t.integer  "site_id"
    t.string   "external_url"
    t.integer  "event_type_id"
    t.integer  "event_sub_type_id"
    t.integer  "template_id"
    t.integer  "event_status_id"
    t.text     "summary"
    t.string   "password"
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer  "time_format"
    t.boolean  "counter"
    t.boolean  "add_to_calendar"
    t.integer  "event_country_id"
    t.integer  "event_city_id"
    t.string   "venue"
    t.boolean  "enable_map"
    t.boolean  "disallow_public_listing"
    t.string   "header_image_name"
    t.text     "custom_css"
    t.boolean  "template_override"
    t.text     "webtrends"
    t.text     "google_analytics"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.integer  "category_id"
    t.integer  "image_id"
    t.integer  "alias_legacy_ev_id"
    t.string   "post_code",                 :limit => 250
    t.string   "phone_number",              :limit => 100
    t.string   "email"
    t.text     "additional_info"
    t.string   "name"
    t.integer  "event_business_area_id"
    t.text     "address_one"
    t.text     "address_two"
    t.text     "town"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "external_registration_url"
  end

  create_table "events_questionnaires", :id => false, :force => true do |t|
    t.integer "event_id"
    t.integer "questionnaire_id"
  end

  create_table "export_fields", :force => true do |t|
    t.string   "name"
    t.string   "method_name"
    t.string   "assosiation_name_first"
    t.string   "assosiation_name_second"
    t.string   "first_selected"
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "export_fields_export_setups", :id => false, :force => true do |t|
    t.integer  "export_field_id", :null => false
    t.integer  "export_setup_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "export_preferences", :force => true do |t|
    t.string   "name"
    t.integer  "sequence"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "export_preferences_export_setups", :id => false, :force => true do |t|
    t.integer  "export_preference_id", :null => false
    t.integer  "export_setup_id",      :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "export_setups", :force => true do |t|
    t.string   "automated_export_status"
    t.string   "export_frequency"
    t.string   "email"
    t.string   "date_format"
    t.integer  "campaign_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "extended_attribute_values", :force => true do |t|
    t.integer  "extended_attribute_id"
    t.string   "value",                 :limit => 10000
    t.string   "string_value",          :limit => 1000
    t.text     "text_value"
    t.integer  "integer_value"
    t.float    "float_value"
    t.decimal  "decimal_value"
    t.datetime "datetime_value"
    t.datetime "timestamp_value"
    t.time     "time_value"
    t.date     "date_value"
    t.binary   "binary_value"
    t.boolean  "boolean_value"
    t.string   "symbol_type",           :limit => 1000
    t.integer  "symbol_id"
  end

  add_index "extended_attribute_values", ["date_value"], :name => "extended_attribute_values_date_value"
  add_index "extended_attribute_values", ["datetime_value"], :name => "extended_attribute_values_datetime_value"
  add_index "extended_attribute_values", ["extended_attribute_id"], :name => "extended_attribute_values_extended_attributes_id"
  add_index "extended_attribute_values", ["string_value"], :name => "extended_attribute_values_string_value"
  add_index "extended_attribute_values", ["symbol_type", "symbol_id"], :name => "extended_attribute_values_symbol_type_id"
  add_index "extended_attribute_values", ["time_value"], :name => "extended_attribute_values_time_value"
  add_index "extended_attribute_values", ["value"], :name => "extended_attribute_values_value"

  create_table "extended_attributes", :force => true do |t|
    t.string   "key"
    t.string   "value"
    t.string   "model_type"
    t.integer  "model_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "extended_attributes_schema_id"
  end

  add_index "extended_attributes", ["extended_attributes_schema_id"], :name => "extended_attributes_extended_attributes_schema"
  add_index "extended_attributes", ["key"], :name => "extended_attributes_model_key"
  add_index "extended_attributes", ["model_type", "model_id"], :name => "extended_attributes_model_type_id"

  create_table "extended_attributes_schemas", :force => true do |t|
    t.string   "attr_name"
    t.string   "model_type"
    t.string   "validation"
    t.string   "data_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "symbol_type"
    t.boolean  "mandatory"
  end

  add_index "extended_attributes_schemas", ["model_type", "attr_name"], :name => "extended_attributes_schemas_model_attr_name"
  add_index "extended_attributes_schemas", ["model_type"], :name => "extended_attributes_schemas_model_type"
  add_index "extended_attributes_schemas", ["symbol_type"], :name => "extended_attributes_schemas_symbol_type"

  create_table "extended_attributes_schemas_options", :id => false, :force => true do |t|
    t.integer "extended_attributes_schema_id"
    t.integer "option_id"
  end

  create_table "external_sources", :force => true do |t|
    t.string   "title"
    t.string   "attribute_type"
    t.string   "attribute_name"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "twitter_id"
    t.string   "link"
    t.text     "description"
    t.datetime "publish_date"
    t.string   "entity_type"
    t.integer  "entity_id"
  end

  create_table "external_urls", :force => true do |t|
    t.integer  "article_id"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.string   "name"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "external_urls", ["article_id"], :name => "index_external_urls_on_article_id"

  create_table "featured_articles", :force => true do |t|
    t.integer  "entity_id"
    t.integer  "sequence_number"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "featured_set_id"
    t.string   "entity_type"
  end

  add_index "featured_articles", ["entity_id"], :name => "index_featured_articles_on_article_id"
  add_index "featured_articles", ["sequence_number"], :name => "index_featured_articles_on_sequence_number"

  create_table "featured_companies", :force => true do |t|
    t.string   "logo_name"
    t.string   "logo_path"
    t.integer  "campaign_id"
    t.string   "display_order"
    t.boolean  "status"
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "meta_tag"
  end

  create_table "featured_digital_assets", :force => true do |t|
    t.integer  "entity_id"
    t.integer  "sequence_number"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "featured_set_id"
    t.string   "entity_type"
  end

  add_index "featured_digital_assets", ["entity_id"], :name => "index_featured_digital_assets_on_entity_id"
  add_index "featured_digital_assets", ["sequence_number"], :name => "index_featured_digital_assets_on_sequence_number"

  create_table "featured_sets", :force => true do |t|
    t.string   "name"
    t.integer  "entity_id"
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "asset_group_id"
    t.string   "entity_type"
    t.boolean  "expire_status"
    t.datetime "expire_date"
    t.string   "model_name"
  end

  add_index "featured_sets", ["entity_id"], :name => "index_featured_sets_on_site_id"
  add_index "featured_sets", ["name"], :name => "index_featured_sets_on_name"

  create_table "featured_sets_newsletters", :id => false, :force => true do |t|
    t.integer "featured_set_id", :null => false
    t.integer "newsletter_id",   :null => false
  end

  create_table "featured_sponsership_assignments", :force => true do |t|
    t.integer  "featured_sponsership_id"
    t.integer  "wpl_taxonomy_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "featured_sponserships", :force => true do |t|
    t.integer  "campaign_id"
    t.string   "name",            :limit => 75
    t.string   "description",     :limit => 800
    t.string   "small_logo_path"
    t.string   "large_logo_path"
    t.integer  "taxonomy_id"
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active_status",                  :default => true
  end

  create_table "featuredcompany_assignments", :force => true do |t|
    t.integer  "wpl_skin_id"
    t.integer  "featured_company_id"
    t.integer  "sequence_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "file_formats", :force => true do |t|
    t.string   "name"
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "logo_path"
  end

  create_table "filters", :force => true do |t|
    t.string   "name"
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "forum_posts", :force => true do |t|
    t.integer  "forum_topic_id"
    t.integer  "subscriber_id"
    t.integer  "post_parent_id"
    t.integer  "quote_id"
    t.integer  "views"
    t.string   "title"
    t.text     "description"
    t.boolean  "published"
    t.boolean  "status"
    t.boolean  "archive"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "forum_topics", :force => true do |t|
    t.integer  "forum_id"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "forums", :force => true do |t|
    t.integer  "site_id"
    t.integer  "subscriber_id"
    t.string   "name"
    t.text     "description"
    t.boolean  "moderation"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "forums_sites", :id => false, :force => true do |t|
    t.integer "forum_id"
    t.integer "site_id"
  end

  create_table "gallery_properties", :force => true do |t|
    t.integer  "entity_id"
    t.integer  "image_sequence_id"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.string   "entity_type"
    t.string   "entity_attribute"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "general_activity_summaries", :force => true do |t|
    t.integer  "campaign_id"
    t.integer  "document_id"
    t.integer  "subscriber_id"
    t.integer  "wpl_skin_id"
    t.integer  "activity_type_id"
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "wpl_id"
  end

  add_index "general_activity_summaries", ["activity_type_id"], :name => "index_general_activity_summaries_on_activity_type_id"
  add_index "general_activity_summaries", ["campaign_id", "activity_type_id", "created_at"], :name => "index_on_campaign_id_activity_type_id_created_at"
  add_index "general_activity_summaries", ["campaign_id"], :name => "index_general_activity_summaries_on_campaign_id"
  add_index "general_activity_summaries", ["document_id", "campaign_id", "activity_type_id", "created_at"], :name => "index_on_document_id_campaign_id_activity_type_id_created_at"
  add_index "general_activity_summaries", ["document_id", "campaign_id"], :name => "index_general_activity_summaries_on_document_id_campaign_id"
  add_index "general_activity_summaries", ["document_id"], :name => "index_general_activity_summaries_on_document_id"

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.string   "url_label"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.integer  "site_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hardwares", :force => true do |t|
    t.boolean  "gsa_contract"
    t.integer  "from_pricing_id"
    t.integer  "to_pricing_id"
    t.string   "pricing_notes",   :limit => 3500
    t.string   "training_id"
    t.boolean  "status"
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "help_texts", :force => true do |t|
    t.string   "model_name"
    t.string   "field_name"
    t.string   "help_texts"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "image_details", :force => true do |t|
    t.integer  "image_id"
    t.integer  "size"
    t.integer  "width"
    t.integer  "height"
    t.string   "image_path"
    t.string   "size_name"
    t.string   "logical_name"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "extra_info",   :limit => 1000
  end

  add_index "image_details", ["image_id"], :name => "index_image_details_on_image_id"
  add_index "image_details", ["image_path"], :name => "index_image_details_on_image_path"

  create_table "image_image_sequences", :force => true do |t|
    t.integer "image_id"
    t.integer "image_sequence_id"
    t.integer "sequence_number"
  end

  add_index "image_image_sequences", ["image_id"], :name => "index_image_image_sequences_on_image_id"
  add_index "image_image_sequences", ["image_sequence_id"], :name => "index_image_image_sequences_on_image_sequence_id"
  add_index "image_image_sequences", ["sequence_number"], :name => "index_image_image_sequences_on_sequence_number"

  create_table "image_properties", :force => true do |t|
    t.string   "entity_type"
    t.string   "alt_tag"
    t.integer  "entity_id"
    t.integer  "image_id"
    t.integer  "sequence_number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "caption"
    t.string   "entity_attribute",   :default => "TitleImage"
    t.integer  "width"
    t.integer  "height"
    t.text     "description"
    t.string   "logical_name"
    t.string   "author"
    t.string   "display_preference"
    t.string   "customise_scenery"
    t.string   "customise_size"
    t.string   "name"
  end

  add_index "image_properties", ["entity_id"], :name => "image_properties_entity_id"
  add_index "image_properties", ["entity_type"], :name => "image_properties_entity_type"
  add_index "image_properties", ["image_id"], :name => "image_properties_image_id"

  create_table "image_sequences", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "image_path"
    t.string   "image_name"
    t.integer  "data_proxy_id"
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "tag"
    t.date     "publish_date"
    t.boolean  "in_embargo"
    t.boolean  "archive"
    t.boolean  "toon_gallery"
    t.boolean  "status"
  end

  create_table "image_sizes", :force => true do |t|
    t.string   "orientation"
    t.string   "value",       :limit => 1000
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "images", :force => true do |t|
    t.string   "image_name"
    t.string   "title"
    t.string   "alt_tag"
    t.string   "tag"
    t.string   "licence_type"
    t.string   "extension"
    t.integer  "thumbnail_version_id"
    t.integer  "default_version_id"
    t.integer  "original_version_id"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "caption",              :limit => 10000
    t.string   "status"
    t.integer  "site_id"
    t.string   "image_credits"
  end

  add_index "images", ["alt_tag"], :name => "index_images_on_alt_tag"
  add_index "images", ["created_at"], :name => "index_images_on_created_at"
  add_index "images", ["default_version_id"], :name => "index_images_on_default_version_id"
  add_index "images", ["image_name"], :name => "index_images_on_image_name"
  add_index "images", ["licence_type"], :name => "index_images_on_licence_type"
  add_index "images", ["original_version_id"], :name => "index_images_on_original_version_id"
  add_index "images", ["thumbnail_version_id"], :name => "index_images_on_thumbnail_version_id"
  add_index "images", ["title"], :name => "index_images_on_title"

  create_table "impression_reports", :force => true do |t|
    t.integer  "campaign_id"
    t.integer  "document_id"
    t.datetime "created_on"
    t.integer  "quarter"
    t.integer  "week_no"
    t.integer  "year"
    t.integer  "month"
    t.integer  "count"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "site_id"
  end

  create_table "impressions", :force => true do |t|
    t.integer  "document_id"
    t.integer  "user_id"
    t.integer  "activity_type_id"
    t.boolean  "is_feature_sponsorship"
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "site_id"
    t.integer  "campaign_id"
  end

  add_index "impressions", ["campaign_id", "created_at"], :name => "index_impressions_on_campaign_id_created_at"
  add_index "impressions", ["campaign_id"], :name => "index_impressions_on_campaign_id"
  add_index "impressions", ["document_id", "campaign_id", "created_at"], :name => "index_impressions_on_document_id_campaign_id_created_at"
  add_index "impressions", ["document_id", "campaign_id"], :name => "index_impressions_on_document_id_campaign_id"
  add_index "impressions", ["document_id"], :name => "index_impressions_on_document_id"

  create_table "industries", :force => true do |t|
    t.string   "name"
    t.integer  "old_id"
    t.string   "old_name"
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "interests", :force => true do |t|
    t.string   "title"
    t.integer  "site_user_id"
    t.string   "magazine_subscriptions"
    t.boolean  "contact_by"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ipaddresses", :force => true do |t|
    t.string   "start_ip"
    t.string   "end_ip"
    t.integer  "subscriber_institution_id"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "start_ip_value",            :limit => 8
    t.integer  "end_ip_value",              :limit => 8
  end

  add_index "ipaddresses", ["end_ip"], :name => "index_ipaddresses_on_end_ip"
  add_index "ipaddresses", ["start_ip"], :name => "index_ipaddresses_on_start_ip"
  add_index "ipaddresses", ["subscriber_institution_id"], :name => "index_ipaddresses_on_subscriber_institution_id"

  create_table "job_roles", :force => true do |t|
    t.string   "name"
    t.string   "old_id"
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "languages", :force => true do |t|
    t.string   "name"
    t.string   "alias_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "last_report_infos", :force => true do |t|
    t.datetime "created_on"
  end

  create_table "layouts", :force => true do |t|
    t.string   "name"
    t.string   "entity_type"
    t.integer  "entity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "asset_group_id"
  end

  create_table "level_of_aquisitions", :force => true do |t|
    t.string   "name"
    t.string   "old_id"
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "link_to_research_items", :force => true do |t|
    t.string   "name"
    t.string   "old_id"
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "link_to_research_items_researches", :id => false, :force => true do |t|
    t.integer  "link_to_research_item_id", :null => false
    t.integer  "research_id",              :null => false
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "listing_categories", :force => true do |t|
    t.integer  "parent_id"
    t.string   "name"
    t.string   "full_name"
    t.string   "full_alias_name"
    t.string   "alias_name"
    t.integer  "sequence_number"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sponsor_listing_id"
    t.string   "type"
  end

  add_index "listing_categories", ["alias_name"], :name => "index_directory_categories_on_alias_name"
  add_index "listing_categories", ["full_alias_name"], :name => "index_directory_categories_on_full_alias_name"
  add_index "listing_categories", ["full_name"], :name => "index_directory_categories_on_full_name"
  add_index "listing_categories", ["name"], :name => "index_directory_categories_on_name"
  add_index "listing_categories", ["parent_id"], :name => "index_directory_categories_on_parent_id"
  add_index "listing_categories", ["sequence_number"], :name => "index_directory_categories_on_sequence_number"

  create_table "location_types", :force => true do |t|
    t.string   "name"
    t.string   "legend"
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations", :force => true do |t|
    t.integer  "created_by"
    t.integer  "updated_by"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "alias_name"
  end

  add_index "locations", ["name"], :name => "index_locations_on_name"

  create_table "locations_sites", :id => false, :force => true do |t|
    t.integer "location_id", :null => false
    t.integer "site_id",     :null => false
  end

  add_index "locations_sites", ["location_id", "site_id"], :name => "by_location_site"
  add_index "locations_sites", ["site_id"], :name => "index_locations_sites_on_site_id"

  create_table "magazine_issues", :force => true do |t|
    t.integer  "source_id"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.string   "short_name"
    t.string   "description"
    t.datetime "date_of_publication"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
  end

  add_index "magazine_issues", ["source_id", "date_of_publication"], :name => "magazine_issues_source_id_date_of_publication"
  add_index "magazine_issues", ["source_id"], :name => "magazine_issues_source_id"

  create_table "media_details", :force => true do |t|
    t.integer  "data_proxy_id"
    t.string   "name"
    t.string   "display_name"
    t.string   "description"
    t.string   "video_path"
    t.string   "image_path"
    t.string   "image_name"
    t.string   "video_duration"
    t.integer  "image_size"
    t.integer  "image_height"
    t.integer  "file_size"
    t.string   "tag"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "original_file_name"
    t.integer  "image_id"
    t.string   "title"
  end

  add_index "media_details", ["created_at"], :name => "index_media_details_on_created_at"
  add_index "media_details", ["data_proxy_id"], :name => "index_media_details_on_site_id"

  create_table "medias", :force => true do |t|
    t.integer  "article_id"
    t.string   "video_path"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "memberships", :force => true do |t|
    t.integer  "created_by"
    t.integer  "updated_by"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "memberships", ["name"], :name => "index_memberships_on_name"

  create_table "memberships_sites", :id => false, :force => true do |t|
    t.integer "membership_id", :null => false
    t.integer "data_proxy_id", :null => false
  end

  add_index "memberships_sites", ["data_proxy_id", "membership_id"], :name => "by_memberships_sites"
  add_index "memberships_sites", ["membership_id"], :name => "index_memberships_sites_on_membership_id"

  create_table "menus", :force => true do |t|
    t.integer  "presentation_proxy_id"
    t.integer  "parent_id"
    t.integer  "entity_id"
    t.string   "entity_type"
    t.string   "url"
    t.string   "name"
    t.string   "alias_name"
    t.integer  "action_id"
    t.integer  "article_id"
    t.integer  "sequence_number"
    t.string   "action_name"
    t.string   "controller_name"
    t.string   "static_page_name"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "section_id"
    t.integer  "category_id"
    t.string   "tag_name"
    t.integer  "author_id"
    t.string   "dynamic_page_name"
    t.integer  "source_id"
    t.integer  "blog_id"
    t.integer  "copied_from"
    t.integer  "priority"
    t.string   "menu_access"
  end

  add_index "menus", ["alias_name"], :name => "index_menus_on_alias_name"
  add_index "menus", ["article_id"], :name => "index_menus_on_article_id"
  add_index "menus", ["controller_name"], :name => "index_menus_on_controller_name"
  add_index "menus", ["entity_id"], :name => "index_menus_on_entity_id"
  add_index "menus", ["entity_type"], :name => "index_menus_on_entity_type"
  add_index "menus", ["name"], :name => "index_menus_on_name"
  add_index "menus", ["parent_id", "sequence_number"], :name => "by_parent_id_sq_no"
  add_index "menus", ["presentation_proxy_id"], :name => "index_menus_on_site_id"
  add_index "menus", ["static_page_name"], :name => "index_menus_on_static_page_name"

  create_table "middlewares", :force => true do |t|
    t.string   "name"
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mode_of_deliveries", :force => true do |t|
    t.string   "name"
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mode_of_deliveries_softwares", :id => false, :force => true do |t|
    t.integer  "software_id",         :null => false
    t.integer  "mode_of_delivery_id", :null => false
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "model_access_schemas", :force => true do |t|
    t.string   "model_name"
    t.string   "access_model"
    t.string   "relationship_name"
    t.string   "attr_name"
    t.string   "method_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "monthly_document_impressions", :force => true do |t|
    t.integer  "campaign_id"
    t.integer  "document_id"
    t.integer  "count"
    t.integer  "year"
    t.integer  "month"
    t.string   "month_year"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "status",      :default => true
  end

  create_table "monthly_impressions", :force => true do |t|
    t.integer  "campaign_id"
    t.integer  "count"
    t.integer  "year"
    t.integer  "month"
    t.string   "month_year"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "status",      :default => true
  end

  create_table "most_read_per_days", :force => true do |t|
    t.integer  "data_proxy_id"
    t.integer  "article_id"
    t.integer  "most_read_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "most_read_per_hours", :force => true do |t|
    t.integer  "data_proxy_id"
    t.integer  "article_id"
    t.integer  "most_read_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "most_read_per_months", :force => true do |t|
    t.integer  "data_proxy_id"
    t.integer  "article_id"
    t.integer  "most_read_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "multiple_answers_options", :id => false, :force => true do |t|
    t.integer "multiple_answer_id", :null => false
    t.integer "option_id",          :null => false
  end

  add_index "multiple_answers_options", ["multiple_answer_id", "option_id"], :name => "by_mulans_opt"
  add_index "multiple_answers_options", ["option_id"], :name => "index_multiple_answers_options_on_option_id"

  create_table "my_favourites", :force => true do |t|
    t.integer  "entity_id"
    t.integer  "subscriber_id"
    t.string   "entity_type"
    t.string   "name"
    t.text     "description"
    t.text     "url"
    t.boolean  "private"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "data_proxy_id"
  end

  create_table "my_research_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "my_researches", :force => true do |t|
    t.string   "name"
    t.integer  "wpl_directory_id"
    t.string   "query_text"
    t.string   "doc_id"
    t.integer  "subscriber_id"
    t.integer  "taxonomy_id"
    t.string   "alpha"
    t.string   "controller"
    t.string   "action"
    t.string   "params"
    t.integer  "my_research_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by"
    t.integer  "updated_by"
  end

  create_table "new_impressions", :force => true do |t|
    t.integer  "document_id"
    t.integer  "campaign_id"
    t.integer  "user_id"
    t.integer  "site_id"
    t.integer  "activity_type_id"
    t.boolean  "is_feature_sponsorship"
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "wpl_id"
  end

  add_index "new_impressions", ["campaign_id", "created_at"], :name => "index_new_impressions_on_campaign_id_and_created_at"
  add_index "new_impressions", ["campaign_id"], :name => "index_new_impressions_on_campaign_id"
  add_index "new_impressions", ["document_id", "campaign_id", "created_at"], :name => "index_on_document_id_and_campaign_id_and_created_at"
  add_index "new_impressions", ["document_id"], :name => "index_new_impressions_on_document_id"

  create_table "new_tags", :force => true do |t|
    t.string   "name"
    t.string   "alias_name"
    t.string   "entity_type"
    t.integer  "entity_id"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "news_letters", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status",                      :default => 1
    t.string   "display_name", :limit => 500
  end

  create_table "news_letters_subscribers", :id => false, :force => true do |t|
    t.integer  "subscriber_id",  :null => false
    t.integer  "news_letter_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "news_letters_wpl_taxonomies", :id => false, :force => true do |t|
    t.integer  "news_letter_id",  :null => false
    t.integer  "wpl_taxonomy_id", :null => false
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "news_letters_wpls", :id => false, :force => true do |t|
    t.integer  "news_letter_id", :null => false
    t.integer  "wpl_id",         :null => false
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "news_wire_feeds", :force => true do |t|
    t.string   "title"
    t.datetime "date_time"
    t.datetime "revision_time"
    t.integer  "revesion_version"
    t.text     "content"
    t.text     "summary"
    t.text     "abstract"
    t.string   "by_line"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "site_id"
    t.integer  "article_id"
  end

  create_table "news_wire_feeds_related_companies", :id => false, :force => true do |t|
    t.integer "news_wire_feed_id"
    t.integer "related_company_id"
  end

  create_table "newsletter_audit_summaries", :force => true do |t|
    t.integer  "newsletter_id"
    t.integer  "user_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "newsletter_static_fragments", :id => false, :force => true do |t|
    t.integer "article_id",    :null => false
    t.integer "newsletter_id", :null => false
  end

  create_table "newsletters", :force => true do |t|
    t.string   "name"
    t.integer  "data_proxy_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "old_campaigns", :force => true do |t|
    t.string   "name"
    t.integer  "campaign_id"
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer  "company_id"
    t.boolean  "status"
    t.string   "lead_status"
    t.integer  "admin_user_id"
    t.integer  "filter_id"
    t.string   "exclude_student"
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "old_campaigns", ["campaign_id"], :name => "index_old_campaigns_on_campaign_id"

  create_table "old_look_up_datas", :force => true do |t|
    t.integer  "created_by"
    t.integer  "updated_by"
    t.integer  "o_uid"
    t.string   "reference"
    t.string   "title"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email_id"
    t.string   "subscription_type"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "old_taxonomies", :force => true do |t|
    t.string   "name"
    t.integer  "old_id"
    t.integer  "taxonomy_id"
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "old_urls", :force => true do |t|
    t.integer  "xml_migrated_data_id"
    t.string   "old_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "old_urls", ["xml_migrated_data_id"], :name => "old_urls_xml_migrated_data_id"

  create_table "operating_systems", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "options", :force => true do |t|
    t.integer  "question_id"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "positive_value"
    t.string   "negative_value"
    t.boolean  "default_value"
  end

  add_index "options", ["name"], :name => "index_options_on_name"
  add_index "options", ["question_id"], :name => "index_options_on_question_id"

  create_table "page_cache_entities", :force => true do |t|
    t.string   "entity_type"
    t.integer  "entity_id"
    t.integer  "page_cache_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "page_cache_entities", ["entity_type", "entity_id"], :name => "index_page_cache_entities_on_entity_type_and_entity_id"
  add_index "page_cache_entities", ["page_cache_id"], :name => "index_page_cache_entities_on_page_cache_id"

  create_table "page_caches", :force => true do |t|
    t.string   "page_type"
    t.integer  "priority"
    t.integer  "site_id"
    t.string   "file_path"
    t.string   "request_path"
    t.datetime "soft_expriy_time"
    t.datetime "hard_expriy_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "page_caches", ["created_at"], :name => "index_page_caches_on_created_at"
  add_index "page_caches", ["file_path"], :name => "index_page_caches_on_file_path"
  add_index "page_caches", ["site_id", "hard_expriy_time"], :name => "index_page_caches_on_site_id_and_hard_expriy_time"
  add_index "page_caches", ["site_id", "page_type"], :name => "index_page_caches_on_site_id_and_page_type"
  add_index "page_caches", ["site_id", "soft_expriy_time"], :name => "index_page_caches_on_site_id_and_soft_expriy_time"

  create_table "page_properties", :force => true do |t|
    t.integer  "page_id"
    t.string   "key"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "page_templates", :force => true do |t|
    t.integer  "page_id"
    t.integer  "template_id"
    t.integer  "presentation_proxy_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages", :force => true do |t|
    t.integer  "site_id"
    t.string   "template_type"
    t.string   "page_name"
    t.string   "layout"
    t.integer  "menu_id"
    t.integer  "asset_group_id"
    t.integer  "presentation_proxy_id"
    t.boolean  "active"
    t.string   "url"
    t.string   "template"
    t.string   "type"
    t.integer  "copied_from"
    t.integer  "blog_id"
    t.boolean  "layout_required"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "cache"
  end

  create_table "pages_sites", :force => true do |t|
    t.integer  "page_id"
    t.integer  "site_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "parent_applications", :force => true do |t|
    t.integer  "document_id"
    t.integer  "parent_document_id"
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "partial_sites", :force => true do |t|
    t.text     "file_path"
    t.integer  "partial_type_id"
    t.integer  "site_id"
    t.string   "display_name"
    t.integer  "partial_id"
    t.string   "data_as_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "partials", :force => true do |t|
    t.integer  "site_id"
    t.string   "partial_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "permissions", :force => true do |t|
    t.string   "short_name"
    t.string   "description"
    t.string   "user_type"
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "permissions_roles", :id => false, :force => true do |t|
    t.integer "role_id",       :null => false
    t.integer "permission_id", :null => false
  end

  add_index "permissions_roles", ["permission_id"], :name => "index_permissions_roles_on_permission_id"
  add_index "permissions_roles", ["role_id", "permission_id"], :name => "index_permissions_roles_on_role_id_and_permission_id"

  create_table "phases", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "phase_order"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "phases", ["name"], :name => "phases_name"

  create_table "pick_of_the_days", :force => true do |t|
    t.integer  "site_id"
    t.integer  "image_id"
    t.string   "image_path"
    t.string   "url"
    t.boolean  "active"
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pick_of_the_days", ["active"], :name => "index_pick_of_the_days_on_active"
  add_index "pick_of_the_days", ["image_id"], :name => "index_pick_of_the_days_on_image_id"
  add_index "pick_of_the_days", ["site_id"], :name => "index_pick_of_the_days_on_site_id"

  create_table "poll_details", :force => true do |t|
    t.string   "poll_id"
    t.string   "poll_description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "poll_logs", :force => true do |t|
    t.string   "ip_address"
    t.integer  "poll_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "poll_logs", ["poll_id"], :name => "index_poll_logs_on_poll_id"

  create_table "poll_options", :force => true do |t|
    t.integer  "poll_id"
    t.string   "option"
    t.integer  "hits",       :default => 0
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "poll_options", ["created_at"], :name => "index_poll_options_on_created_at"
  add_index "poll_options", ["hits"], :name => "index_poll_options_on_hits"
  add_index "poll_options", ["poll_id"], :name => "index_poll_options_on_poll_id"

  create_table "polls", :force => true do |t|
    t.string   "title"
    t.string   "question",      :limit => 1000
    t.integer  "data_proxy_id"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "status"
    t.string   "reference"
    t.text     "description"
  end

  add_index "polls", ["created_at"], :name => "index_polls_on_created_at"
  add_index "polls", ["data_proxy_id"], :name => "index_polls_on_site_id"

  create_table "popular_search_per_days", :force => true do |t|
    t.integer  "data_proxy_id"
    t.string   "query_text"
    t.integer  "count"
    t.datetime "date"
    t.datetime "created_at",    :null => false
    t.string   "search_type"
    t.datetime "updated_at"
  end

  add_index "popular_search_per_days", ["created_at"], :name => "pop_sea_created_at"
  add_index "popular_search_per_days", ["data_proxy_id"], :name => "pop_sea_site_id"
  add_index "popular_search_per_days", ["date"], :name => "pop_sea_date"
  add_index "popular_search_per_days", ["query_text"], :name => "pop_sea_query_text"

  create_table "popular_search_per_months", :force => true do |t|
    t.integer  "site_id"
    t.string   "query_text"
    t.integer  "count"
    t.datetime "month"
    t.datetime "year"
    t.datetime "created_at",  :null => false
    t.string   "search_type"
    t.datetime "updated_at"
  end

  add_index "popular_search_per_months", ["month"], :name => "pop_month_month"
  add_index "popular_search_per_months", ["query_text"], :name => "pop_month_query_text"
  add_index "popular_search_per_months", ["site_id"], :name => "pop_month_site_id"

  create_table "portals", :force => true do |t|
    t.string   "name"
    t.integer  "site_id"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "portals_sites", :id => false, :force => true do |t|
    t.integer "portal_id"
    t.integer "site_id"
  end

  create_table "preference_filter_business_sizes", :id => false, :force => true do |t|
    t.integer  "campaign_id",      :null => false
    t.integer  "business_size_id", :null => false
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "preference_filter_countries", :id => false, :force => true do |t|
    t.integer  "campaign_id", :null => false
    t.integer  "country_id",  :null => false
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "preference_filter_industries", :id => false, :force => true do |t|
    t.integer  "campaign_id", :null => false
    t.integer  "industry_id", :null => false
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "preference_filter_job_roles", :id => false, :force => true do |t|
    t.integer  "campaign_id", :null => false
    t.integer  "job_role_id", :null => false
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "preference_lead_activity_recipients", :id => false, :force => true do |t|
    t.integer  "campaign_id",      :null => false
    t.integer  "campaign_user_id", :null => false
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "preference_sets", :force => true do |t|
    t.integer "campaign_id", :null => false
    t.integer "user_id",     :null => false
    t.boolean "status",      :null => false
  end

  create_table "presentation_proxies", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pricings", :force => true do |t|
    t.string   "name"
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_customization_options", :force => true do |t|
    t.string   "name"
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_teaser_types", :force => true do |t|
    t.integer "product_id"
    t.integer "teaser_type_id"
  end

  add_index "product_teaser_types", ["product_id", "teaser_type_id"], :name => "by_protestyp_teser"
  add_index "product_teaser_types", ["teaser_type_id"], :name => "index_product_teaser_types_on_teaser_type_id"

  create_table "products", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.boolean  "trail"
    t.boolean  "key_icon"
    t.boolean  "play_video"
    t.text     "product_action_content"
    t.string   "subscriber_headline",     :default => "Subscriber Login"
    t.string   "action_headline",         :default => "To read this story please register"
    t.integer  "teaser_type_id"
    t.integer  "data_proxy_id"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "expired_action_headline"
    t.text     "expired_action_content"
    t.string   "product_type"
    t.integer  "questionnaire_id"
    t.string   "subject_prefix"
    t.string   "sender_address"
    t.string   "friendly_sender"
    t.string   "site_address"
    t.string   "signation"
    t.string   "ps"
    t.string   "display_label"
    t.string   "url"
    t.boolean  "dirty"
    t.text     "contact_details"
  end

  add_index "products", ["action_headline"], :name => "index_products_on_action_headline"
  add_index "products", ["data_proxy_id"], :name => "index_products_on_site_id"
  add_index "products", ["key_icon"], :name => "index_products_on_key_icon"
  add_index "products", ["name"], :name => "index_products_on_name"
  add_index "products", ["subscriber_headline"], :name => "index_products_on_subscriber_headline"
  add_index "products", ["teaser_type_id"], :name => "index_products_on_teaser_type_id"

  create_table "properties", :force => true do |t|
    t.integer  "entity_id"
    t.string   "entity_type"
    t.string   "key"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "purchase_decisions", :force => true do |t|
    t.string   "name"
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "question_sites", :force => true do |t|
    t.integer  "site_id"
    t.integer  "question_id"
    t.integer  "position"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.boolean  "mandatory"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "question_sites", ["position"], :name => "index_question_sites_on_position"
  add_index "question_sites", ["question_id"], :name => "index_question_sites_on_question_id"
  add_index "question_sites", ["site_id", "question_id"], :name => "by_quesite_site"

  create_table "questionnaire_questions", :force => true do |t|
    t.integer  "question_id"
    t.integer  "questionnaire_id"
    t.integer  "position"
    t.integer  "page_number"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.boolean  "mandatory"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "questionnaire_questions", ["questionnaire_id"], :name => "index_questionnaire_id"

  create_table "questionnaire_submissions", :force => true do |t|
    t.integer  "questionnaire_id"
    t.integer  "subscriber_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "http_referrer"
    t.string   "ip_address"
    t.integer  "product_id"
  end

  create_table "questionnaires", :force => true do |t|
    t.string   "name"
    t.string   "campaign"
    t.string   "header"
    t.text     "introduction"
    t.string   "thankyou_header"
    t.string   "thankyou_acknowledge", :limit => 1000
    t.string   "alert_email"
    t.string   "submit_label"
    t.string   "end_message_text"
    t.integer  "site_id"
    t.boolean  "show_captcha"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.string   "email_subject"
    t.string   "email_from"
    t.string   "entity_type"
    t.integer  "entity_id"
    t.string   "specific_to"
  end

  add_index "questionnaires", ["entity_id", "entity_type"], :name => "index_entity_id_entity_type"

  create_table "questionnaires_sites", :id => false, :force => true do |t|
    t.integer "questionnaire_id", :null => false
    t.integer "data_proxy_id",    :null => false
  end

  create_table "questions", :force => true do |t|
    t.string   "type"
    t.string   "name"
    t.boolean  "mandatory"
    t.boolean  "allow_others"
    t.boolean  "number_of_lines_answer"
    t.integer  "max_length"
    t.integer  "min_number"
    t.integer  "max_number"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "prefilled_field_hint"
    t.integer  "max_input_length"
    t.integer  "input_field_length"
    t.integer  "verification_method_id"
    t.integer  "entity_id"
    t.string   "entity_type"
    t.string   "specific_to"
    t.string   "alias_name"
  end

  add_index "questions", ["allow_others"], :name => "index_questions_on_allow_others"
  add_index "questions", ["mandatory"], :name => "index_questions_on_mandatory"
  add_index "questions", ["max_length"], :name => "index_questions_on_max_length"
  add_index "questions", ["max_number"], :name => "index_questions_on_max_number"
  add_index "questions", ["min_number"], :name => "index_questions_on_min_number"
  add_index "questions", ["name"], :name => "index_questions_on_name"

  create_table "questions_sections", :force => true do |t|
    t.string   "entity_type"
    t.integer  "entity_id"
    t.integer  "question_id"
    t.integer  "sequence_number"
    t.boolean  "status"
    t.boolean  "section_mandatory"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "quotes", :force => true do |t|
    t.integer "old_id",      :null => false
    t.integer "site_id"
    t.integer "author_id"
    t.string  "text"
    t.boolean "active"
    t.string  "author_name"
  end

  create_table "rating_transactions", :force => true do |t|
    t.integer  "entity_id"
    t.integer  "rate"
    t.integer  "subscriber_id"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "entity_type"
  end

  create_table "ratings", :force => true do |t|
    t.string   "entity_type"
    t.integer  "entity_id"
    t.integer  "user_id"
    t.integer  "rate"
    t.string   "ipaddress"
    t.integer  "subscriber_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "related_companies", :force => true do |t|
    t.string   "company_name"
    t.string   "epic_code"
    t.string   "isin_number"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "primary_name"
    t.string   "is_parent"
  end

  create_table "related_companies_sites", :id => false, :force => true do |t|
    t.integer "related_company_id"
    t.integer "site_id"
  end

  create_table "related_company_aliases", :force => true do |t|
    t.integer  "related_company_id"
    t.string   "company_alias_name"
    t.string   "email_id"
    t.boolean  "display_status"
    t.boolean  "primary_status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "related_company_aliases_sites", :id => false, :force => true do |t|
    t.integer "related_company_alias_id"
    t.integer "site_id"
  end

  create_table "related_company_children", :id => false, :force => true do |t|
    t.integer  "related_company_id"
    t.integer  "children_related_company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "related_documents", :id => false, :force => true do |t|
    t.integer  "document_id",         :null => false
    t.integer  "related_document_id", :null => false
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "related_products", :force => true do |t|
    t.integer  "article_id"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.string   "name"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "related_products", ["article_id"], :name => "index_related_products_on_article_id"

  create_table "request_types", :force => true do |t|
    t.string   "name"
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "researches", :force => true do |t|
    t.string   "upload_file_path"
    t.string   "url"
    t.integer  "file_size"
    t.string   "file_format"
    t.string   "registration_status"
    t.date     "publish_date"
    t.integer  "price"
    t.integer  "length_of_research_item"
    t.boolean  "content_partner"
    t.boolean  "status"
    t.integer  "type_of_content_id"
    t.integer  "link_to_research_item_id"
    t.integer  "file_format_id"
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "researches", ["type_of_content_id"], :name => "index_researches_on_type_of_content_id"

  create_table "researches_type_of_contents", :id => false, :force => true do |t|
    t.integer  "research_id",        :null => false
    t.integer  "type_of_content_id", :null => false
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "review_users", :force => true do |t|
    t.integer  "directory_listing_id"
    t.integer  "site_id"
    t.string   "name"
    t.string   "email"
    t.text     "review"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reviews", :force => true do |t|
    t.integer  "article_id"
    t.integer  "user_id"
    t.text     "content"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.string   "user_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_sub_permissions", :id => false, :force => true do |t|
    t.integer "role_id",           :null => false
    t.integer "sub_permission_id", :null => false
  end

  add_index "roles_sub_permissions", ["role_id"], :name => "index_roles_sub_permissions_on_role_id"
  add_index "roles_sub_permissions", ["sub_permission_id", "role_id"], :name => "index_roles_sub_permissions_on_sub_permission_id_and_role_id"

  create_table "schedule_tasks", :force => true do |t|
    t.string   "schedule_name"
    t.datetime "starting_time"
    t.datetime "ending_time"
    t.datetime "last_updated_at"
  end

  create_table "sections", :force => true do |t|
    t.string   "name"
    t.string   "alias_name"
    t.string   "entity_type"
    t.integer  "template_id"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "copied_from"
  end

  add_index "sections", ["entity_type"], :name => "index_sections_on_entity_type"
  add_index "sections", ["template_id"], :name => "index_sections_on_template_id"

  create_table "sections_sites", :id => false, :force => true do |t|
    t.integer "section_id",    :null => false
    t.integer "data_proxy_id", :null => false
  end

  add_index "sections_sites", ["data_proxy_id", "section_id"], :name => "by_sec_sit"
  add_index "sections_sites", ["section_id"], :name => "index_sections_sites_on_section_id"

  create_table "send_to_friends", :force => true do |t|
    t.integer  "data_proxy_id"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.integer  "entity_id"
    t.integer  "subscriber_id"
    t.string   "entity_type"
    t.string   "comment_text",   :limit => 10000
    t.string   "receiver_email"
    t.string   "sender_email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "sender_name"
  end

  add_index "send_to_friends", ["comment_text"], :name => "index_send_to_friends_on_comment_text"
  add_index "send_to_friends", ["data_proxy_id"], :name => "index_send_to_friends_on_site_id"
  add_index "send_to_friends", ["entity_id"], :name => "index_send_to_friends_on_entity_id"
  add_index "send_to_friends", ["entity_type"], :name => "index_send_to_friends_on_entity_type"

  create_table "services", :force => true do |t|
    t.integer  "created_by"
    t.integer  "updated_by"
    t.string   "name"
    t.string   "alias_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "services", ["alias_name"], :name => "index_services_on_alias_name"
  add_index "services", ["name"], :name => "index_services_on_name"

  create_table "services_sites", :id => false, :force => true do |t|
    t.integer "data_proxy_id", :null => false
    t.integer "service_id",    :null => false
  end

  add_index "services_sites", ["data_proxy_id"], :name => "index_services_sites_on_site_id"
  add_index "services_sites", ["service_id", "data_proxy_id"], :name => "by_ser_site"

  create_table "simple_captcha_data", :force => true do |t|
    t.string   "key",        :limit => 40
    t.string   "value",      :limit => 6
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "simple_captcha_data", ["key"], :name => "idx_key"

  create_table "site_aliases", :force => true do |t|
    t.integer  "site_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "site_aliases", ["name"], :name => "index_site_aliases_on_name"

  create_table "site_events", :force => true do |t|
    t.integer  "event_id"
    t.integer  "site_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "site_properties", :force => true do |t|
    t.integer  "site_id"
    t.string   "name"
    t.string   "value",      :limit => 10000
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "site_properties", ["site_id", "name"], :name => "index_site_properties_on_site_id_and_name"
  add_index "site_properties", ["site_id"], :name => "index_site_properties_on_site_id"

  create_table "site_user_roles", :force => true do |t|
    t.integer  "site_id"
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "site_user_roles", ["role_id"], :name => "index_site_user_roles_on_role_id"
  add_index "site_user_roles", ["site_id"], :name => "index_site_user_roles_on_site_id"
  add_index "site_user_roles", ["user_id"], :name => "index_site_user_roles_on_user_id"

  create_table "site_users", :force => true do |t|
    t.integer  "site_id",    :null => false
    t.integer  "user_id",    :null => false
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "site_users", ["site_id"], :name => "index_site_users_on_site_id"
  add_index "site_users", ["user_id"], :name => "index_site_users_on_user_id"

  create_table "sites", :force => true do |t|
    t.string   "name"
    t.string   "short_name"
    t.string   "layout_path"
    t.string   "url"
    t.string   "action"
    t.integer  "content_sharing_portal_id"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "wpl_id"
    t.integer  "presentation_proxy_id"
    t.integer  "data_proxy_id"
    t.string   "url_display_name"
    t.text     "robot"
    t.boolean  "active",                    :default => true
    t.string   "status"
    t.string   "domain"
    t.string   "prefix"
    t.string   "site_type"
    t.string   "external_url"
    t.datetime "start_date"
    t.datetime "end_date"
  end

  create_table "sites_sources", :id => false, :force => true do |t|
    t.integer "data_proxy_id", :null => false
    t.integer "source_id",     :null => false
  end

  add_index "sites_sources", ["data_proxy_id", "source_id"], :name => "by_sit_srce"
  add_index "sites_sources", ["data_proxy_id"], :name => "index_sites_sources_on_site_id"

  create_table "sites_tags", :id => false, :force => true do |t|
    t.integer "data_proxy_id", :null => false
    t.integer "tag_id",        :null => false
  end

  add_index "sites_tags", ["data_proxy_id", "tag_id"], :name => "by_site_tag"
  add_index "sites_tags", ["tag_id"], :name => "index_sites_tags_on_tag_id"

  create_table "software_plugins", :force => true do |t|
    t.string   "name"
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "softwares", :force => true do |t|
    t.string   "data_security",                :limit => 3500
    t.boolean  "additional_hardware_software"
    t.string   "asp_notes",                    :limit => 3500
    t.integer  "no_of_licenced_seats"
    t.boolean  "gsa_contract"
    t.integer  "source_code_id"
    t.integer  "software_plugin_id"
    t.integer  "from_pricing_id"
    t.integer  "to_pricing_id"
    t.string   "pricing_notes",                :limit => 3500
    t.string   "training_id"
    t.boolean  "status"
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "solution_types", :force => true do |t|
    t.string   "name"
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "source_codes", :force => true do |t|
    t.string   "name"
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sources", :force => true do |t|
    t.integer  "site_id"
    t.string   "name"
    t.string   "alais_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "current_issue_id"
    t.text     "css"
    t.integer  "copied_from"
  end

  add_index "sources", ["name"], :name => "index_sources_on_name"

  create_table "special_urls", :force => true do |t|
    t.integer  "presentation_proxy_id"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.string   "url"
    t.string   "layout"
    t.string   "dynamic_page_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "special_urls", ["dynamic_page_name"], :name => "index_special_urls_on_dynamic_page_name"
  add_index "special_urls", ["layout"], :name => "index_special_urls_on_layout"
  add_index "special_urls", ["presentation_proxy_id"], :name => "index_special_urls_on_site_id"
  add_index "special_urls", ["url"], :name => "index_special_urls_on_url"

  create_table "sponsers", :force => true do |t|
    t.string   "name"
    t.string   "logo"
    t.string   "url"
    t.string   "description"
    t.string   "image_path"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sponsers", ["resource_id"], :name => "index_sponsers_on_resource_id"
  add_index "sponsers", ["resource_type"], :name => "index_sponsers_on_resource_type"

  create_table "sub_catalogs", :force => true do |t|
    t.string   "name"
    t.integer  "subcatalogid"
    t.integer  "featured_sponsership_id"
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sub_permissions", :force => true do |t|
    t.integer  "permission_id"
    t.string   "short_name"
    t.string   "name"
    t.string   "description"
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sub_permissions", ["permission_id"], :name => "index_sub_permissions_on_permission_id"

  create_table "subscriber_audits", :force => true do |t|
    t.integer  "subscription_id"
    t.integer  "subscriber_id"
    t.integer  "site_id"
    t.integer  "article_id"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.boolean  "count_decremented"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "sessionid"
    t.string   "provider_type"
  end

  create_table "subscriber_deliveries", :force => true do |t|
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "pincode"
    t.string   "state"
    t.string   "country"
    t.integer  "subscriber_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subscriber_properties", :force => true do |t|
    t.string   "solutation"
    t.string   "title"
    t.string   "phone",                   :limit => 16
    t.integer  "extn"
    t.integer  "fax"
    t.integer  "job_role_id"
    t.integer  "industry_id"
    t.integer  "level_of_aquisition_id"
    t.integer  "business_size_id"
    t.integer  "campaign_id"
    t.string   "end_user_company_name"
    t.string   "Job_title"
    t.string   "address1"
    t.string   "address2"
    t.string   "address3"
    t.string   "city"
    t.integer  "country_id"
    t.integer  "county_id"
    t.string   "postal_code"
    t.boolean  "terms_acceptance"
    t.boolean  "magazine_receive_status"
    t.boolean  "status"
    t.string   "data_source"
    t.date     "registration_date"
    t.string   "old_id"
    t.integer  "updated_by"
    t.integer  "created_by"
    t.string   "newsletter_membership"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_user_company_id"
    t.string   "question"
    t.string   "answer"
    t.integer  "subscriber_id"
  end

  create_table "subscribers", :force => true do |t|
    t.string   "title"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email_id"
    t.string   "password"
    t.string   "type"
    t.string   "institution_name"
    t.string   "reset_password_code"
    t.integer  "concurrent_user_max",         :default => 2
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "last_login"
    t.datetime "reset_password_code_until"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "o_uid"
    t.string   "legacy_uid"
    t.string   "remember_me_key"
    t.datetime "remember_me_time"
    t.integer  "interval"
    t.integer  "remaining_concurrent_logins", :default => 2
    t.integer  "bureau_id"
    t.string   "provider_type"
    t.string   "provider_id"
    t.string   "user_name"
    t.integer  "registered_from_site_id"
    t.integer  "login_count"
  end

  add_index "subscribers", ["email_id"], :name => "index_subscribers_on_email_id"
  add_index "subscribers", ["first_name"], :name => "index_subscribers_on_first_name"
  add_index "subscribers", ["institution_name"], :name => "index_subscribers_on_institution_name"
  add_index "subscribers", ["last_login"], :name => "index_subscribers_on_last_login"
  add_index "subscribers", ["last_name"], :name => "index_subscribers_on_last_name"

  create_table "subscribers_wpls", :id => false, :force => true do |t|
    t.integer  "subscriber_id", :null => false
    t.integer  "wpl_id",        :null => false
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subscriptions", :force => true do |t|
    t.string   "name"
    t.string   "time_out",                 :limit => 11
    t.string   "time_type"
    t.string   "subscription_type"
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer  "remaining_no_of_articles"
    t.integer  "allowed_no_of_articles"
    t.integer  "subscriber_id"
    t.integer  "product_id"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "o_pid"
    t.datetime "last_login"
    t.integer  "o_oid"
    t.datetime "last_login_previous"
    t.string   "activation_email",                       :default => "YES"
    t.integer  "bureau_id"
    t.integer  "o_uid"
  end

  add_index "subscriptions", ["end_date"], :name => "index_subscriptions_on_end_date"
  add_index "subscriptions", ["name"], :name => "index_subscriptions_on_name"
  add_index "subscriptions", ["product_id"], :name => "index_subscriptions_on_product_id"
  add_index "subscriptions", ["start_date"], :name => "index_subscriptions_on_start_date"
  add_index "subscriptions", ["subscriber_id"], :name => "index_subscriptions_on_subscriber_id"

  create_table "subsections", :force => true do |t|
    t.integer  "section_id"
    t.string   "name"
    t.string   "alias_name"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "suggested_implementations", :force => true do |t|
    t.string   "name"
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "support_messages", :force => true do |t|
    t.string   "message"
    t.string   "topic"
    t.integer  "user_id"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.boolean  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "support_messages", ["created_at"], :name => "index_support_messages_on_created_at"
  add_index "support_messages", ["user_id"], :name => "index_support_messages_on_user_id"

  create_table "supported_databases", :force => true do |t|
    t.string   "name"
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "supported_middlewares", :force => true do |t|
    t.string   "name"
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "supported_networks", :force => true do |t|
    t.string   "name"
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "supported_programming_languages", :force => true do |t|
    t.string   "name"
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "supports", :force => true do |t|
    t.string   "name"
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tab_assignments", :force => true do |t|
    t.integer  "featured_sponsership_assignment_id"
    t.integer  "tab_id"
    t.integer  "document_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "featured_sponsership_id"
  end

  add_index "tab_assignments", ["document_id"], :name => "index_tab_assignments_on_document_id"
  add_index "tab_assignments", ["featured_sponsership_id"], :name => "index_tab_assignments_on_featured_sponsership_id"

  create_table "tabs", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags", :force => true do |t|
    t.string   "name",        :limit => 10000
    t.string   "entity_type"
    t.integer  "entity_id"
    t.string   "alias_name"
    t.string   "type"
    t.datetime "created_at"
    t.integer  "created_by"
    t.datetime "updated_at"
    t.integer  "updated_by"
    t.integer  "copied_from"
  end

  add_index "tags", ["alias_name"], :name => "index_tags_on_alias_name"
  add_index "tags", ["entity_type"], :name => "index_tags_on_entity_type"
  add_index "tags", ["name"], :name => "index_tags_on_name"

  create_table "taxonomies_old", :force => true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.boolean  "status"
    t.string   "serial_no"
    t.string   "description"
    t.integer  "old_id"
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "display_name"
  end

  create_table "teaser_types", :force => true do |t|
    t.string   "name"
    t.string   "partial_name"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "teaser_types", ["name"], :name => "index_teaser_types_on_name"
  add_index "teaser_types", ["partial_name"], :name => "index_teaser_types_on_partial_name"

  create_table "templates", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "entity_id"
    t.string   "entity_type"
    t.integer  "asset_group_id"
  end

  create_table "trainings", :force => true do |t|
    t.string   "name"
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "type_of_contents", :force => true do |t|
    t.string   "name"
    t.string   "old_id"
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_activity_summaries", :force => true do |t|
    t.integer  "user_id"
    t.datetime "last_access_time"
  end

  add_index "user_activity_summaries", ["user_id"], :name => "user_activity_summaries_user_id"

  create_table "users", :force => true do |t|
    t.integer  "entity_id"
    t.string   "entity_type"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "password"
    t.string   "salutation"
    t.string   "title"
    t.string   "email"
    t.string   "phone"
    t.integer  "extn"
    t.integer  "fax"
    t.integer  "final_selected_site_id"
    t.string   "end_user_company_name"
    t.string   "job_title"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.integer  "country_id"
    t.integer  "postal_code"
    t.boolean  "terms_acceptance"
    t.boolean  "magazine_receive_status"
    t.boolean  "status"
    t.datetime "reset_password_code_until"
    t.string   "reset_password_code"
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "expiry_date"
    t.string   "notes"
    t.boolean  "active",                    :default => true
    t.string   "remember_me_key"
    t.datetime "expiry_time"
    t.string   "fullname"
    t.string   "delivery_email"
    t.integer  "admin_selected_site_id"
  end

  add_index "users", ["entity_id"], :name => "index_users_on_entity_id"
  add_index "users", ["entity_type"], :name => "index_users_on_entity_type"
  add_index "users", ["final_selected_site_id"], :name => "index_users_on_final_selected_site_id"
  add_index "users", ["fullname"], :name => "users_full_name"

  create_table "users_wpls", :id => false, :force => true do |t|
    t.integer  "user_id",    :null => false
    t.integer  "wpl_id",     :null => false
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "verification_methods", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "message"
    t.string   "regex"
  end

  create_table "weekly_impressions", :force => true do |t|
    t.integer  "campaign_id"
    t.integer  "count"
    t.integer  "year"
    t.integer  "week_no"
    t.string   "week_start_day"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "status",         :default => true
  end

  create_table "widgets", :force => true do |t|
    t.string   "name"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "wpl_category_activity_summaries", :force => true do |t|
    t.integer  "campaign_id"
    t.integer  "document_id"
    t.integer  "subscriber_id"
    t.integer  "wpl_skin_id"
    t.integer  "activity_type_id"
    t.integer  "wpl_id"
    t.integer  "news_letter_id"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "wpl_directories", :force => true do |t|
    t.string   "name"
    t.integer  "subscriber_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by"
    t.integer  "updated_by"
  end

  create_table "wpl_roles", :force => true do |t|
    t.string   "name"
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "wpl_roles_users", :id => false, :force => true do |t|
    t.integer  "user_id",     :null => false
    t.integer  "wpl_role_id", :null => false
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "wpl_services", :force => true do |t|
    t.string   "location"
    t.string   "data_security",                :limit => 3500
    t.boolean  "additional_hardware_software"
    t.string   "asp_notes",                    :limit => 3500
    t.integer  "from_pricing_id"
    t.integer  "to_pricing_id"
    t.string   "pricing_notes",                :limit => 3500
    t.string   "training_id"
    t.boolean  "status"
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "wpl_services_solution_types", :id => false, :force => true do |t|
    t.integer  "wpl_service_id",   :null => false
    t.integer  "solution_type_id", :null => false
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "wpl_skins", :force => true do |t|
    t.string   "name"
    t.string   "layout_name"
    t.string   "short_name"
    t.string   "display_name"
    t.string   "sub_domain_name"
    t.string   "full_name"
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "wpl_id"
  end

  create_table "wpl_skins_wpl_taxonomies", :id => false, :force => true do |t|
    t.integer  "wpl_skin_id",     :null => false
    t.integer  "wpl_taxonomy_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "wpl_skins_wpl_taxonomies", ["wpl_skin_id"], :name => "index_wpl_skins_wpl_taxonomies_on_wpl_skin_id"
  add_index "wpl_skins_wpl_taxonomies", ["wpl_taxonomy_id"], :name => "index_wpl_skins_wpl_taxonomies_on_wpl_taxonomy_id"

  create_table "wpl_skins_wpl_top_taxonomies", :id => false, :force => true do |t|
    t.integer  "wpl_skin_id",     :null => false
    t.integer  "wpl_taxonomy_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "wpl_skins_wpl_top_taxonomies", ["wpl_skin_id"], :name => "index_wpl_skins_wpl_top_taxonomies_on_wpl_skin_id"
  add_index "wpl_skins_wpl_top_taxonomies", ["wpl_taxonomy_id"], :name => "index_wpl_skins_wpl_top_taxonomies_on_wpl_taxonomy_id"

  create_table "wpl_taxonomies", :force => true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.boolean  "status"
    t.string   "serial_no"
    t.string   "description"
    t.integer  "old_id"
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "display_name", :limit => 300
  end

  add_index "wpl_taxonomies", ["parent_id"], :name => "index_wpl_taxonomies_on_parent_id"

  create_table "wpl_taxonomies_wpls", :force => true do |t|
    t.integer  "wpl_id"
    t.integer  "wpl_taxonomy_id"
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "document_count",  :default => 0
  end

  add_index "wpl_taxonomies_wpls", ["wpl_id"], :name => "index_wpl_taxonomies_wpls_on_wpl_id"
  add_index "wpl_taxonomies_wpls", ["wpl_taxonomy_id"], :name => "index_wpl_taxonomies_wpls_on_wpl_taxonomy_id"

  create_table "wpls", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "xml_migrated_data", :force => true do |t|
    t.string   "model_type"
    t.string   "ext_id",                   :limit => 1000
    t.integer  "int_id"
    t.integer  "publication_id"
    t.datetime "article_last_modify_date"
    t.string   "old_url_part"
    t.integer  "previous_id"
  end

  add_index "xml_migrated_data", ["ext_id"], :name => "xml_migrated_datas_ext_id"
  add_index "xml_migrated_data", ["int_id"], :name => "xml_migrated_datas_int_id"
  add_index "xml_migrated_data", ["model_type"], :name => "xml_migrated_datas_model_type"
  add_index "xml_migrated_data", ["previous_id"], :name => "xml_migrated_datas_previous_id"
  end

  def down
  end
end
