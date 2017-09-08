module ComponentHelper


 def datetimepicker_input(model_name,attr_name,options={})
    name=options[:name] ? options[:name] : "#{model_name}[#{attr_name}]"
    id="#{model_name}_#{attr_name}_id"
    instance_variable=self.instance_variable_get("@#{model_name}")
    object=instance_variable ? instance_variable : options[:object]
   logger.info "-------------------------------------------------------------------#{object.send(attr_name).inspect if object and object.send(attr_name)}"
    value = options[:value] ? options[:value] : (object.send(attr_name).nil? ? "" : object.send(attr_name).strftime("%B %d %Y %l:%M %p" )) rescue nil
    datetime_input ="<input type='text' name='#{name}' id='#{id}' value ='#{value}' cursor = pointer >"
    "#{datetime_input}
    <script type='text/javascript'>
     $(document).ready(function() {
     $('##{id}').datetimepicker({
        dateFormat: 'MM d, yy',
        changeMonth: true,
        changeYear: true,
        showOn: 'button',
        buttonImage: '/images/calendar_date_select/calendar.gif ',
        buttonImageOnly: true,
        ampm: true
     });

 });
 </script>"
  end

end
