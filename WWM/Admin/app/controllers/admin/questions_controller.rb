class Admin::QuestionsController < AdminController


   def new
     @page_properties={:selected_menu=>'question_list',:menu_title=>'Question > Create New Question'}
     @campaign = Campaign.find(params[:campaign_id]) if params[:campaign_id]
     @company = Company.find(params[:company_id]) if params[:company_id]
     @question=Question.new

   end

   def edit
    @page_properties = { :selected_menu => 'question_list', :menu_title => 'Question > Edit Question' }
    @question=Question.find(params[:id])
    @campaign = Campaign.find(params[:campaign_id]) if params[:campaign_id]
    @company = Company.find(params[:company_id]) if params[:company_id]
    @verification_method = @question.verification_method
    end

   
end

