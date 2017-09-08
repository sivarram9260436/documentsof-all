class Questionnaire < ActiveRecord::Base
 
  def self.search(search)
      if search
         Questionnaire.where("LOWER(name) LIKE ?", "%#{search.downcase.strip}%")
       else
        Questionnaire.all
      end
  end 
  
end
