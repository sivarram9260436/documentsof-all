class Admin::QuestionnairesController < AdminController

  def new
    @page_properties={:selected_menu=>'questionnaire_list',:menu_title=>'Questionnaire > Create New Questionnaire '}
    @campaign = Campaign.find(params[:campaign_id]) if params[:campaign_id]
    @company = Company.find(params[:company_id]) if params[:company_id]
    @questions = if params[:campaign_id] 
                    @campaign.company.questions
                 elsif params[:company_id]
                    @company.questions
                 else
                   Question.specific_to(nil)
               end
   @questionnaire=Questionnaire.new
  end
  def edit
    @page_properties={:selected_menu=>'questionnaire_list',:menu_title=>'Questionnaire > Edit Questionnaire' }
    @questionnaire=Questionnaire.find(params[:id])
    @questions = Question.specific_to(nil)
  end
  
  def update
    @questionnaire = Questionnaire.find(params[:id])
    if @questionnaire.update_attributes(params[:questionnaire])
      params[:listTaken].uniq! unless params[:listTaken].nil?
      @questionnaire.question_ids(params[:listTaken],params[:questionnaire_questions])
      @questionnaire.questionnaire_submissions.delete
      @questionnaire_submission = QuestionnaireSubmission.new(:questionnaire_id => @questionnaire.id,:subscriber_id => session[:user_id])
      @questionnaire_submission.save(:validate=>false)
      @campaign = Campaign.find(params[:campaign_id]) if params[:campaign_id]
      @company = Company.find(params[:company_id]) if params[:company_id]
      if params[:flag].eql?('save_preview')
        @questionnaire_submission=nil
        @page_properties={:selected_menu=>'questionnaire_list',:menu_title=>'Questionnaire Form'}
      render :template => '/admin/questionnaires/questionnaire_questions_form', :locals => {:questionnaire => @questionnaire}
       else
        redirect_to( 
          if params[:campaign_id]
            { :controller => 'admin/questions' , :action => 'index', :campaign_id => params[:campaign_id] } 
          elsif params[:company_id]
            { :controller => 'admin/questionnaires' , :action => 'index', :company_id => params[:company_id] }
          else
            {:controller => 'admin/questionnaires' , :action => 'index' }
          end)
      end
    else
      @page_properties={:selected_menu=>'questionnaire_list',:menu_title=>'Edit Questionnaire '}
      @questions = (params[:campaign_id] ? @campaign.company.questions : Question.specific_to(nil)).paginate(:page => params[:page], :per_page =>20)
      pagination('edit','question_result','question_list') #(render_template,partial_template,replace_html_div)
    end
  end  
  
  
end
