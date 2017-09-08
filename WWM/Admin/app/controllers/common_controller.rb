class CommonController < WpsController
  def rating
    if RATINGCONST.include?(params[:entity_type])
      entity = @site.send(params[:entity_type]).find(params[:id])
      rating = entity.ratings.new(:rate => params[:rating])
      if rating.save
      average_rating = entity.average_rating
      end
      render :text => average_rating,:layout => false
    else
      render_404
    end
  end
  
 

  


end
