class Poll < ActiveRecord::Base

   def get_all_gragh_values(site=nil)
    @graph_val=[]
    @total_count=self.poll_options.collect{|aa| aa.hits}.inject(:+)
     i = 0
    for poll in self.poll_options.find(:all,:order=>"id asc")
      @graph={:value=>(@total_count == 0  ? 0 : (poll.hits * 100/@total_count)) ,:color=>(site and site.config.vote.option_colors ? site.config.vote.option_colors.split(",")[i] : DEFAULT_COLOUR_FOR_POLL[i]),:label=>poll.option,:count=>poll.hits}
      i = 1 + i
      @graph_val << @graph
    end
    return @graph_val
  end
  
  

  
  def self.search(search,status)
  
      if search
        if !status.blank?
         Poll.where("LOWER(question) LIKE ?", "%#{search.downcase.strip}%").where("status = ?" ,status) 
        #Poll.where("question LIKE ?", "%#{search}%").where("status = ?" ,status)
        else
         Poll.where("LOWER(question) LIKE ?", "%#{search.downcase.strip}%") 
        #Poll.where("question LIKE ?", "%#{search}%") 
        end
      else
        Poll.all
      end
  end
  
  
end
