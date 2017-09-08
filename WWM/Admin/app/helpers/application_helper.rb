module ApplicationHelper
 def link_to_render_partial(display_name,path,article_id,options={})
      link_to display_name, render_partial_path({:controller=>"application" ,:action=>'render_partial' ,:path=>path,:article_id=>article_id}.merge(options))
 end 

 def error_messages_for(*params)
    options = params.extract_options!.symbolize_keys
    object = options.delete(:object) ?objects = [object].flatten : objects = params.collect {|object_name| instance_variable_get("@#{object_name}") }.compact
    count  = objects.inject(0) {|sum, object| sum + object.errors.count }
    unless count.zero?
      html = {}
      [:id, :class].each do |key|
        html[key] =  options.include?(key) ? ( options[key] unless options[key].blank? ) : 'errorExplanation'
      end
      options[:object_name] ||= params.first
      I18n.with_options :locale => options[:locale], :scope => [:activerecord, :errors, :template] do |locale|
        header_message = if options.include?(:header_message)
        options[:header_message]
        else
          object_name = options[:object_name].to_s.gsub('_', ' ')
          object_name = I18n.t(object_name, :default => object_name,:scope => [:activerecord, :models], :count => 1)
        locale.t :header, :count => count, :model => object_name
        end
        message = options.include?(:message) ? options[:message] : locale.t(:body)
        error_messages = objects.sum {|object| object.errors.full_messages.map {|msg| content_tag(:li, msg) } }.join
        contents = ''
        contents << "<div class='errorExplanation' id = 'errorExplanation'>\n"
        contents << "\t\t<h3> #{count}errors prevented this form from being saved</h3>\n"
        contents << "\t\t<ul>\n"
        contents << "\t\t\t#{objects.sum {|object| object.errors.full_messages.map {|msg| msg.lstrip }.collect{|emsg| content_tag(:li, emsg.split('_')[1]) } }.join}\n"
        contents << "\t\t</ul>\n"
        contents << "\t</div>\n"
      end
    else
      ''
    end
  end


end
