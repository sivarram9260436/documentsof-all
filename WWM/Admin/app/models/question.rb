class Question < ActiveRecord::Base

   def question_validate
     errors[:base] << ("1_Question should not be blank") if name.blank?
     errors[:base] << ("1_Question type should not be blank") if type.blank?
     if type=="NumberQuestion"
     errors[:base] << ("1_Question maximum value should not be blank") if max_number.blank?
     errors[:base] << ("1_Question minimum value should not be blank") if min_number.blank?
    end

    if type=="TextBlockQuestion" or type=="TextQuestion"
    errors[:base] << ("1_Question maximum length should not be blank") if max_length.blank?
  end
  end

  def self.search(search,type)
      if search
        if !type.blank?
          Question.where("LOWER(name) LIKE ?", "%#{search.downcase.strip}%").where("type = ?" ,type)
        else
        Question.where("LOWER(name) LIKE ?", "%#{search.downcase.strip}%")
         end 
      else
        Question.all
      end
  end
  
end
