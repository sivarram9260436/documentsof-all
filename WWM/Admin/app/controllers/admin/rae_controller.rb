class  Admin::RaeController < AdminController

def index
  @page_properties={:selected_menu=>'rae_menu',:menu_title=>'RAE Search'}
  @subscriber=Subscriber.new()
  @subscriber_property = SubscriberProperty.new()
end

def search
	@page_properties={:selected_menu=>'rae_menu',:menu_title=>'RAE Search Result'}
	@subscribers = Subscriber.advanced_search_subscriber(params[:subscriber],params[:page])
	render :partial=>'search_result'
end

def subscriber_edit
	@page_properties={:selected_menu=>'rae_menu',:menu_title=>'Edit Subscriber Info'}
	@subscriber = Subscriber.find(params[:id])
	@subscriber_property = (@subscriber.subscriber_property.blank? ? SubscriberProperty.new() : @subscriber.subscriber_property)
	render :template=>'/admin/rae/subscriber_edit',:layout=>false
end

def subscriber_property
 @subscriber.profile_picture(params[:subscriber_image][:profile_image]) if params[:subscriber_image] and params[:subscriber_image][:profile_image]
	if @subscriber.blank? or @subscriber.subscriber_property.blank?
	  @subscriber_property=SubscriberProperty.new(params[:subscriber_property])
	  @subscriber_property.subscriber_id = @subscriber.id
	  @subscriber_property.save(:validate=>false)
	else
	  @subscriber_property=@subscriber.subscriber_property
	  @subscriber_property.attributes = (params[:subscriber_property])
	  @subscriber_property.save(:validate=>false)
	  @subscriber.subscriptions.collect{|a| a.destroy}
	end
end


def subscriber_update
    @page_properties={:selected_menu=>'rae_menu',:menu_title=>'Edit Subscriber Info'}
	@subscriber = Subscriber.find(params[:id])
	@subscriber.update_attributes(params[:subscriber])
  subscriber_property
	@subscriber_property = @subscriber.subscriber_property
	render :template=>'/admin/rae/subscriber_edit',:layout=>false
end

def export_to_csv
  @page_properties={:selected_menu=>'rae_menu',:menu_title=>'RAE Search Result'}
  @subscribers = Subscriber.advanced_search_subscriber(params[:subscriber],1,30,false)
  SubscriberExportCsvGeneration.rae_export(@site,@subscribers)
  send_file("#{Rails.root}/public/rae_export/rae_export.csv")
end
 
end
