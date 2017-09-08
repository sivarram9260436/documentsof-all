
SrComponent.define_component('newsletter_repository',
:data_string=>%q{@newsletter.newsletter_parses.paginate(:per_page =>session[:per_page],:page => params[:page])},
:partial => '/admin/newsletter/newsletter_repository',
:xhtml_id => 'article_list',
:title => '',
:empty_message => '',
:error_message => 'Information currently unavailable',
:hide => false,
:hide_on_empty => false,
:hide_on_error => false,
:data_as => :collection,
:pagination => true,
:header =>['ID','Date','View'],
)


  SrComponent.define_component('static_article_list_new',
     :data_string=>%q{@site.all_static_articles.by_section(@site.static_sections.find_by_alias_name("static-page")).paginate(:per_page =>20,:page => params[:page]).order(sort_clause)},
    :partial => '/admin/static_page/list_of_articles',
    :xhtml_id => 'article_list',
    :title => '',
    :empty_message => '',
    :error_message => 'Information currently unavailable',
    :hide => false,
    :hide_on_empty => false,
    :button=>'/admin/static_page/add_new_static_page_button',
    :hide_on_error => false,
    :data_as => :collection,
    :pagination => true,
    :header =>  ['Static ID','Title','Content type','Status','Modified by','Last Modified','Preview'] ,
    :sort_list =>{"Static ID"=>"id","Title"=>"title","Last Modified"=>"updated_at"}
    
  )

SrComponent.define_component('static_fragment_list',
    :data_string=>%q{@site.all_static_articles.by_section(@site.static_sections.find_by_alias_name("static-fragment")).paginate(:per_page =>20,:page => params[:page]).order(sort_clause)},
    :partial => '/admin/static_page/list_of_articles',
    :xhtml_id => 'article_list',
    :title => '',
    :empty_message => '',
    :error_message => 'Information currently unavailable',
    :hide => false,
    :hide_on_empty => false,
    :button=>'/admin/static_page/add_new_static_page_button',
    :hide_on_error => false,
    :data_as => :collection,
    :pagination => true,
    :header =>  ['Static ID','Title','Content type','Status','Modified by','Last Modified'] ,
    :sort_list =>{"Static ID"=>"id","Title"=>"title","Last Modified"=>"updated_at"}
    
  )

SrComponent.define_component('static_fragment_search',
                             :data_string => %q{@site.all_static_articles.not_dynamic_articles.search(sort_clause,"Static",params[:search_data],params[:page],session[:per_page])},
                             :base => 'static_fragment_list'
)

# SrComponent.define_component('static_page_list',
    # :data_string=>%q{(@site.static_articles.only_static_articles('dynamic-page') - @site.static_articles.only_static_articles('static-page')).paginate(:order=>sort_clause,:per_page =>20,:page => params[:page])},
    # :partial => '/admin/static_page/list_of_articles',
    # :xhtml_id => 'article_list',
    # :title => '',
    # :empty_message => '',
    # :error_message => 'Information currently unavailable',
    # :hide => false,
    # :hide_on_empty => false,
    # :button=>'/admin/static_page/add_new_static_page_button',
    # :hide_on_error => false,
    # :data_as => :collection,
    # :pagination => true,
    # :header =>  ['Static ID','Title','Content type','Status','Modified by','Last Modified','Preview'] ,
    # :sort_list =>{"Article ID"=>"id","Title"=>"title","Last Modified"=>"updated_at"}
#     
  # )


  SrComponent.define_component("poll_list_search",
     :base => "base", 
      :data_string => %q{Poll.search(params[:search_data]["question"],params[:search_data]["status"]).paginate(:conditions=>['data_proxy_id=?',Site.find(session[:site_id]).data_proxy_id],:page => params[:page],:per_page =>15) },
      :partial     => 'poll_list',
      :xhtml_id    => 'poll_new_list',
      :button=>'/admin/polls/add_new_poll_button',
      :decoration  => '/decoration/decoration_article_list',
      :title       => 'Poll List',
      :empty_message => 'No results',
      :error_message => 'Information currently unavailable',
      :data_as     => :collection,
      :pagination  => true,
      :header      => ['Poll ID', 'Question', 'Title', 'Created at','Result','Status','Trash'],
      :sort_list   => {'Question'=>'question', 'Title'=>'title', 'Created at'=>'created_at'}
      )
      
     SrComponent.define_component("poll_list_new",
     :base => "base", 
      :data_string => %q{Poll.paginate(:conditions=>['data_proxy_id=?',Site.find(session[:site_id]).data_proxy_id],:page => params[:page],:per_page =>15) },
      :partial     => 'poll_list',
      :xhtml_id    => 'poll_new_list',
      :button=>'/admin/polls/add_new_poll_button',
      :decoration  => '/decoration/decoration_article_list',
      :title       => 'Poll List',
      :data_as     => :collection,
      :pagination  => true,
      :header      => ['Poll ID', 'Question', 'Title', 'Created at','Result','Status','Trash'],
      :sort_list   => {'Question'=>'question', 'Title'=>'title', 'Created at'=>'created_at'}
      )
   
    SrComponent.define_component("QuestionList_search",
      :base => "base",
      :data_string   => %q{(@questions=question_list_data(params.dup).search(params[:search_data]["name"],params[:search_data]["type"]))},
      :partial       => '/admin/questions/question_list_temp',
      :xhtml_id      => 'Question',
      :button=>'/admin/questions/add_new_question_button',
      :decoration    => '/decoration/decoration_article_list',
      :title         => 'QuestionList',
      :data_as       => :object,
      :pagination  => true,
      :button      =>'/admin/questions/question_button',
      :header        => ['Id', 'Name', 'Question Type', 'Questionnaires'],
      :sort_list     => {},
      :pagination  => true)
   
    SrComponent.define_component("QuestionnaireList_search",
      :base         => "base",
      :data_string  => %q{(questionnaire_list_data(params.dup).search(params[:search_data]["name"]))},
      :partial      => '/admin/questionnaires/questionnaire',
      :button=>'/admin/questionaries/add_new_blog_button',
      :xhtml_id     => 'Questionnaire',
      :decoration   => '/decoration/decoration_article_list',
      :title        => 'QuestionnaireList',
      :data_as      => :collection,
      :button       => '/admin/questionnaires/questionnaire_button',
      :pagination   => true,
      :header       => ['Name', 'Campaign', 'Questions', 'Submissions', 'Created by', 'Date Created','Report','Preview'],
      :sort_list    => {}) 
   
   
   
  SrComponent.define_component("issue_management_list_new",
      :base => "base", 
      :data_string => %q{MagazineIssue.search(params[:search_data], params[:page], session[:per_page])},
      :partial     => 'magazine_issues_list',
      :xhtml_id    => 'print_management_list',
      :decoration  => 'decoration/decoration_article_list',
      :title       => 'Issue Management List',
      :data_as     => :collection,
      :button     =>  '/admin/print_management/print_button',
      :pagination  => true,
      :header      => ['Volume Number and Issue Number', 'Source', 'Date of publication','Created at','Issue status'],
      :sort_list   => {'Created at'=>'created_at','Source'=>'source_id','Date of publication'=>'date_of_publication'})             
        

SrComponent.define_component("imageset_list_merge",
     :base => "base",
     :data_string=>%q{Image.search_imageset(params[:image_detail_search],params[:page],params[:per_page]).order('updated_at desc')},
     :partial => 'imageset_list',
     :xhtml_id => 'image_list',
     :decoration => 'decoration/decoration_image_set',
     :title => 'imagesets',
     :empty_message => 'No Image Available',
     :search_partial => "upload_search",
     :data_as => :object
      )

SrComponent.define_component("imageset_search_list",
           :base => "base",
           :data_string=>%q{Image.search_imageset(params[:image_detail_search],params[:page],params[:per_page]).order('updated_at desc')},
           :partial => 'imageset_list',
           :xhtml_id => 'image_list',
           :decoration => 'decoration/decoration_image_set',
           :title => 'matching imageset',
           :search_partial => "upload_search_new",
           :empty_message => 'No Image Available',
           :data_as => :object
            )

SrComponent.define_component('rae_search_result',
:data_string => %q{@subscribers.paginate(:per_page =>10,:page => params[:page])},
:partial     => '/admin/rae/rae_search_result',
:name        => 'rae_search_result',
:empty_message=>'No Subscribers',
:xhtml_id    => 'rae_search_result',
:decoration    => '/decoration/decoration_rae_ajax_list',
:pagination => true,
:header =>  ['User Id','First Name','Last Name','Registeration Date','Edit'] ,
)

SrComponent.define_component("NewsletterListNew",
:base => "base",
:data_string   => %q{@site.newsletters.paginate(:per_page => 30, :page => params[:page])},
:partial       => 'admin/articles/newsletter_form',
:xhtml_id      => 'sponsor_list',
:decoration    => 'decoration/decoration_article_list',
:title         => 'Newsletter List',
:hide_on_empty => true,
:hide_on_error => true,
:data_as       => :collection,
:header        => ['Sn.', 'Name', 'Preview','Register','New Test Subscriber','Newsletter Archive','Subscribers Report'],
:sort_list     => {})


SrComponent.define_component("new_gallery_management_list",
     :base => "base", 
      :data_string => %q{ @site.image_sequences.find(:all,:conditions=>['toon_gallery is null or toon_gallery = ?',false],:order=>sort_clause).paginate(:per_page =>session[:per_page],:page => params[:page])},
      :partial     => 'gallery_list',
      :xhtml_id    => 'gallery_list',
      :decoration  => '/decoration/decoration_gallery',
      :title       => 'Gallery List',
      :data_as     => :collection,
      :pagination  => true,
            :button =>'/admin/image_details/gallery_button',
      :hide_on_empty => false,
      :hide_on_error => false,
      :header      => ['Gallery', 'Name', 'Author','Used In','Last Modified',''],
      :sort_list   => {'Name'=>'name','Last Modified'=>'updated_at'})  
      
 SrComponent.define_component("toon_gallery_management_list",
     :base => "base", 
      :data_string => %q{ @site.image_sequences.find(:all,:conditions=>['toon_gallery is not null or toon_gallery != ?',false]).paginate(:per_page =>session[:per_page],:page => params[:page])},
      :partial     => 'gallery_list',
      :xhtml_id    => 'gallery_list',
      :decoration  => '/decoration/decoration_gallery',
      :title       => 'Gallery List',
      :data_as     => :collection,
      :pagination  => true,
            :button =>'/admin/image_details/gallery_button',
      :hide_on_empty => false,
      :hide_on_error => false,
      :header      => ['Gallery', 'Name', 'Author','Used In','Last Modified',''],
      :sort_list   => {'Name'=>'name','Last Modified'=>'updated_at'})   
  
  SrComponent.define_component("NewsletterList",
      :base => "base", 
      :data_string   => %q{ @site.newsletters.paginate(:per_page => 30, :page => params[:page] ) },
      :partial       => 'admin/articles/newsletter_form',
      :xhtml_id      => 'sponsor_list',
      :decoration    => 'decoration/decoration_article_list',
      :title         => 'Newsletter List',
      :hide_on_empty => true,
      :hide_on_error => true,
      :data_as       => :collection,
      :header        => ['Sn.', 'Name', 'Preview'],
      :sort_list     => {})  

  SrComponent.define_component("OLD_NewsletterSubscriberReport",
      :base => "base",
      :data_string   => %q{NewsletterRegisteration.search(params[:search_data]["status"],params[:search_data]["start_date"],params[:search_data]["end_date"],params[:search_data]["email_id"],params[:search_data]["company_name"],params[:search_data]["Job_title"]).paginate(:page => params[:page],:per_page =>30)},
      :partial       => 'admin/newsletter/subscriber_active_report',
      :xhtml_id      => 'sponsor_list',
      :decoration    => 'decoration/decoration_article_list',
      :title         => 'Subscriber Report',
      :hide_on_empty => true,
      :hide_on_error => true,
      :pagination => true,
      :data_as       => :collection,
      :header        => ['Sn.', 'FirstName', 'Emailid','Company Name','Job Title','Status'],
      :sort_list     => {})

  SrComponent.define_component("NewsletterSubscriberReport",
                             :base => "base",
                             :data_string => %q{NewsletterRegisteration.search(params[:search_data]).paginate(:per_page => 20, :page => params[:page])},
                             :partial => 'admin/newsletter/subscriber_active_report',
                             :xhtml_id => 'sponsor_list',
                             :decoration => 'decoration/decoration_article_list',
                             :title => 'Subscriber Report',
                             :data_as => :collection,
                             :pagination => true,
                             :header => ['Sn.', 'FirstName', 'Emailid','Company Name','Job Title','Status',''],
                             :sort_list => {})


SrComponent.define_component("new_ranked_list",
:data_string=>%q{@site.featured_sets.paginate(:conditions=>["model_name='Article'"],:per_page =>session[:per_page],:page => params[:page]).order(sort_clause)},
:base=>"base",
:partial => '/admin/ranked_list/ranked_list',
:button=>'/admin/ranked_list/add_new_ranked_list_button',
:xhtml_id => 'article_list',
:title => 'Ranked List',
:hide => false,
:hide_on_empty => false,
:hide_on_error => false,
:data_as => :collection,
:pagination => true,
:button=>'/admin/ranked_list/ranked_list_button',
:header => ['Id','Name','Date Created'],
:sort_list =>{"Id"=>"id","Name"=>"name","bDate Created"=>"created_at"} )

  SrComponent.define_component("ranked_list_search",
    :data_string=>%q{@site.featured_sets.article_search(params[:search_data]["name"]).paginate(:conditions=>[""],:per_page =>session[:per_page],:page => params[:page]).order('updated_at desc')},
    :base=>"base",
    :partial => '/admin/ranked_list/ranked_list',
    :button=>'/admin/ranked_list/add_new_ranked_list_button',
    :xhtml_id => 'article_list',
    :title => 'Ranked List',
    :hide => false,
    :hide_on_empty => false,
    :hide_on_error => false,
    :data_as => :collection,
    :pagination => true,
    :button=>'/admin/ranked_list/ranked_list_button',
    :header => ['Id','Name','Date Created'],
    :sort_list =>{"Id"=>"id","Name"=>"name","bDate Created"=>"created_at"} )



 SrComponent.define_component("new_ranked_list_service",
           :data_string=>%q{@site.featured_sets.paginate(:conditions=>["model_name='Service'"],:page => params[:page],:per_page =>session[:per_page]).order(sort_clause)},
            :base=>"base",
            :partial => '/admin/ranked_list/ranked_list',
            :xhtml_id => 'article_list',
            :title => 'Ranked List',
            :hide => false,
            :hide_on_empty => false,
            :hide_on_error => false,
            :data_as => :collection,
            :pagination => true,
             :button=>'/admin/ranked_list/ranked_list_button',
            :header => ['Id','Name','Date Created'],
            :sort_list =>{"Id"=>"id","Name"=>"name","Date Created"=>"created_at"} )  
              


    SrComponent.define_component("ranked_list_service_search",
      :data_string=>%q{@site.featured_sets.service_search(params[:search_data]["name"]).paginate(:conditions=>[""],:per_page =>session[:per_page],:page => params[:page]).order('updated_at desc')},
      :base=>"base",
      :partial => '/admin/ranked_list/ranked_list',
      :button=>'/admin/ranked_list/add_new_ranked_list_button',
      :xhtml_id => 'article_list',
      :title => 'Ranked List',
      :hide => false,
      :hide_on_empty => false,
      :hide_on_error => false,
      :data_as => :collection,
      :pagination => true,
      :button=>'/admin/ranked_list/ranked_list_button',
      :header => ['Id','Name','Date Created'],
      :sort_list =>{"Id"=>"id","Name"=>"name","bDate Created"=>"created_at"} )



SrComponent.define_component("ranked_list_digital_asset",
:data_string=>%q{@site.featured_sets.paginate(:conditions=>["model_name='Digital_asset'"],:per_page =>session[:per_page],:page => params[:page]).order('updated_at desc')},
:base=>"base",
:partial => '/admin/ranked_list/ranked_list',
:xhtml_id => 'article_list',
:title => 'Ranked List',
:hide => false,
:hide_on_empty => false,
:hide_on_error => false,
:data_as => :collection,
:pagination => true,
:button=>'/admin/ranked_list/ranked_list_button',
:header => ['Id','Name','Date Created'],
:sort_list =>{"Id"=>"id","Name"=>"name","bDate Created"=>"created_at"} )



SrComponent.define_component("ranked_list_digital_search",
:data_string=>%q{@site.featured_sets.digital_search(params[:search_data]["name"]).paginate(:conditions=>[""],:per_page =>session[:per_page],:page => params[:page]).order('updated_at desc')},
:base=>"base",
:partial => '/admin/ranked_list/ranked_list',
:xhtml_id => 'article_list',
:title => 'Ranked List',
:hide => false,
:hide_on_empty => false,
:hide_on_error => false,
:data_as => :collection,
:pagination => true,
:button=>'/admin/ranked_list/ranked_list_button',
:header => ['Id','Name','Date Created'],
:sort_list =>{"Id"=>"id","Name"=>"name","bDate Created"=>"created_at"} )



SrComponent.define_component('featured_digital_asset',
:base=>"base",
:data_string=>%q({:articles=>@site.featured_sets.find(params[:id]).featured_digital_assets,:featured_set_id=>params[:id]}),
:name => 'featured_articles',
:partial => '/admin/ranked_list/featured_asset',
:decoration => '/admin/ranked_list/decoration_featured_article',
:xhtml_id => 'asset_group_article_tab',
:hide => false,
:data_as => :object,
:hide_on_empty => false,
:hide_on_error => false   )

SrComponent.define_component('latest_asset_tab',
:base        => "tab_list",
:data_string => %q{{:data => @site.digital_assets.paginate(:page => params[:page],:per_page =>10,:order=>'created_at desc'), :entity_type => 'asset', :results => @site.digital_assets.paginate(:page => params[:page],:per_page =>10,:order=>'created_at desc')}},
:partial     => '/admin/ranked_list/asset',
:name        => 'latest_asset_tab',
:xhtml_id    => 'latest_asset_tab',
:decoration  => "/decoration/simple_decoration",
:data_as     => :object,
:type        => "asset")

SrComponent.define_component('event_list',
:base=>"base",
:data_string=>%q{@event=@site.events.all},
:partial => '/admin/events/event_list',
:xhtml_id => 'event',
:decoration  => 'decoration/decoration_analysis_article_list',
  :button=>'/admin/events/event_list_button',
:title => 'event_list',
:data_as => :object,
:header      => ['Id', 'My Event Title'," EventCategory" ,'EventType','Event Start Date', 'Event End Date', 'Country', 'City'],
:sort_list   => {'All Available Content Types'=>'content_type'},
:hide_on_error => true)


  SrComponent.define_component("special_page_list",
      :base        => 'base', 
      :data_string=>%q{@site.all_special_pages.paginate(:per_page =>30, :page => params[:page]).order('updated_at desc')}, 
      :xhtml_id => 'special_page_list',
      :partial     => '/admin/page/special_page_list',
      :button=>'/admin/page/special_page_list_button',
#     :decoration    => 'decoration/decoration_article_list',
 :decoration  => 'decoration/decoration_analysis_article_list',
    :pagination => true,
      :header      => ['Sn.', 'Special Page Name', 'Url', 'Template']
      ) 
      
  SrComponent.define_component('article_search',
        :base=>"base",
        :data_string=>%q(@site.all_articles.search(sort_clause,["Article","Blog"],params[:search_data],params[:page],session[:per_page])  ),                       
        :xhtml_id => 'article_list', 
        :partial=>'/admin/articles/article',
        :data_as => :collection,
        :type=>"Article",
        :hide => false,           
        :hide_on_empty => false,
        :pagination => true,
        :header => ['Article ID','Title','Content type','Status','Author','Last Modified','Preview'] ,
        :hide_on_error => false,
        :sort_list =>{"Article ID"=>"id","Title"=>"title","Last Modified"=>"updated_at"}
         )
         
  SrComponent.define_component('new_article_search_for_ranked_list',
        :data_string=> %q({:data =>Article.search('display_date desc', (params[:article_type].humanize == "All") ? ["Article","Blog"] : params[:article_type].humanize, params[:search_data], params[:page], 10).published, :type => 'search'} ),                       
        :xhtml_id => 'article_search', 
        :partial=>'/admin/ranked_list/articles',
        :data_as => :object,
        :decoration=>"/decoration/simple_decoration",
        :type=>"search"
         )


  SrComponent.define_component("VerticalList",
      :base => "base",
      :data_string => %q{@site.verticals.paginate(:per_page =>session[:per_page], :page => params[:page]).order('updated_at desc')},
      :partial     => '/admin/verticals/vertical',
      :xhtml_id    => 'vertical',
      :decoration  => '/decoration/decoration_tag_list',
      :title       => 'Vertical List',
      :data_as     => :collection,
      :header      => ['Sn.', 'Vertical Name', 'Alias Name'],
      :sort_list   => {'Vertical Name' => 'name'},
      :pagination  => true)

  SrComponent.define_component("VerticalSearch",
      :base => "base", 
      :partial     => '/admin/verticals/vertical_search',
      :xhtml_id    => 'vertical_search',
      :decoration  => 'decoration/simple_decoration',
      :title       => 'Vertical Search',
      :data_as     => :none)

  SrComponent.define_component("VerticalNewList",
      
      :base        => 'VerticalList', 
      :partial     => '/admin/verticals/search_list',
      :decoration  => '/decoration/decoration_tag_list',
      :header      => ['Sn.', 'Vertical Name', 'Alias Name'],
      :sort_list   => {'Vertical Name' => 'name'}
      )

  SrComponent.define_component("VerticalNewEdit",
      :base => "base",  
      :data_string   => '@vertical=Vertical.new',
      :partial       => '/admin/verticals/new_vertical_vertical',
      :xhtml_id      => 'vertical',
      :decoration    => '/decoration/decoration_box',
      :title         => 'Vertical Box',
      :data_as       => :object)  

 SrComponent.define_component("VerticalEdit",
       :base => "base",  
      :data_string   => 'Vertical.find(params[:id])',
      :partial       => '/admin/verticals/new_vertical_vertical',
      :xhtml_id      => 'vertical',
      :decoration    => '/decoration/decoration_box',
      :title         => 'Vertical Box',
      :data_as       => :object)         

         

  SrComponent.define_component("new_media_box_list",
        :base => "curved_box_base_with_will_paginate",
        :data_string=>%q{@site.media_details.by_videos_with_image.paginate(:per_page =>12,:page => params[:page]).order("created_at desc")},
        :partial => 'media_list',
        :xhtml_id => 'media_seq',
        :title => 'Video List',
        :empty_message => 'No Video Available',
        :pagination => 'true',
    #          :pagination_params => params,
        :data_as => :object
        )  

  SrComponent.define_component("NewQuestionnaireList",
      :base         => "base",
      :data_string  => %q{(questionnaire_list_data(params.dup))},
      :partial      => '/admin/questionnaires/questionnaire',
      :button=>'/admin/questionaries/add_new_blog_button',
      :xhtml_id     => 'Questionnaire',
      :decoration   => '/decoration/decoration_article_list',
      :title        => 'QuestionnaireList',
      :data_as      => :collection,
      :button       => '/admin/questionnaires/questionnaire_button',
      :pagination   => true,
      :header       => ['Name', 'Campaign', 'Questions', 'Submissions', 'Created by', 'Date Created','Report','Preview','Get Code'],
      :sort_list    => {})
      
         
   SrComponent.define_component('component_advance_search',
      :base => "base",
      :data_string => %q{Array(@site.components.advance_search("updated_at desc",params[:search_data],@site,params[:page],20))},
      :partial     => '/admin/components/advance_search',
      :xhtml_id    => 'component',
      :decoration  => '/decoration/decoration_analysis_article_list',
      :title       => 'Component List',
      :hide => false,           
      :hide_on_empty => false,
      :data_as     => :collection,
      :pagination => true,
      :header      => ['ID', 'Compoenent Name', 'Container Name'],
      :hide_on_error => false
         )   
         
     SrComponent.define_component("all_redirects_list",
      :base         => "base",
      :data_string  => %q{AllRedirect.all.paginate(:per_page=>10,:page=>params[:page])},
      :partial      => '/admin/all_redirects/all_redirects',
      :button=>'/admin/all_redirects/all_redirects_new_button',
      :xhtml_id     => 'All Redirects',
      :decoration   => '/decoration/decoration_analysis_article_list',
      :title        => 'AllRedirectList',
      :data_as      => :collection,
      :pagination   => true,
      :header       => ['Host', 'Original Uri', 'Destination', 'Redirect Type', 'Record Type','Destroy'],
      :sort_list    => {})      
         
        SrComponent.define_component("TagListNew",
            :base => "base",
            :data_string => %q{@site.tags.paginate(:per_page =>session[:per_page], :page =>params[:page] ,:order=>"id desc")},
            :partial     => '/admin/tags/tag',
            :xhtml_id    => 'tag',
            :decoration  => '/decoration/decoration_tag_list',
            :button      =>'/admin/tags/tag_button',
            :title       => 'Tag List',
            :data_as     => :collection,
            :header      => ['Sn.', 'Tag Name', 'Alias Name'],
            :sort_list   => {'Tag Name' => 'name'},
            :pagination  => true)
 

        
    SrComponent.define_component("data_list_new",
      :base        => 'base', 
      :data_string=>%q{@site.data_lists.paginate(:per_page =>20,:page => params[:page]).order('updated_at desc')}, 
      :xhtml_id => 'pre_defined_component_list',
        :decoration  => 'decoration/decoration_analysis_article_list',
      :partial     => '/admin/data_list/data_list',
      :button => '/admin/data_list/data_list_button',
      :pagination => true,
      :header      => ['Sn.', 'Name','Data String']
      )  
 
       
 
