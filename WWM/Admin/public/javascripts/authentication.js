   function questionnaire_questions(id)
   {
        new Ajax.Updater('questionnaire_questions', '/admin/questionnaires/questionnaire_questions/',{method: 'get', evalScripts:true, asynchronous:true, parameters:'id=' + id})
   } 

   function values()
   {   
        var value = document.getElementById('question_type').value;
        params = "value="+ value
        var myajax = new Ajax.Updater('questiontype','/admin/authentication/choice_of_question',{method: 'get',evalScripts: true,asynchronous: true, parameters: params});
   }
   
   function option_drag()
   {
        Sortable.destroy( 'myfield' );
           Sortable.create('myfield', {
                containment: ['myfield'],
                dropOnEmpty: true,
                tag: 'li'      
            });
   }
   
   function create_question_option1()
   {  
        var numi = $('theValue');
        var num = ($('theValue').value - 1) + 2;
        numi.value = num;
        id = num
        name = "option[option_value][]"
        value = ""
        var li = new Element('li')    
        var label = new Element('label')
        var span= new Element('span',{'class':'left_label'})
        label.innerHTML = ' Option' + num +' : '
        var span1= new Element('span',{'class':'right_label'})
    
        var box = new Element('input', {
            id: id,
            name: name,
            value: value,
            'class': 'textBoxWidth'
        })    

        var label1 = new Element('label')
        id1 = num 
        var td3 = new Element('td')	
        li.appendChild(label)
        li.appendChild(box)   
        Insertion.Bottom('myfield',li); 
        option_drag(); 
   }
   
   
  function values_edit(question_type)
   {
        var value = document.getElementById('question_type').value;
        if (question_type.value=="TextQuestion" || question_type.value=="NumberQuestion" || question_type.value=="DateQuestion" || question_type.value=="YearQuestion"){
            $('questiontype_value').hide();
            $('questiontype').show();
            params = "value="+ value
            var myajax = new Ajax.Updater('questiontype','/admin/authentication/choice_of_question',{method: 'get',evalScripts: true,asynchronous: true, parameters: params});
        }
        else 
        {
            $('questiontype_value').show();
            $('questiontype').hide();
        }
   }
   
   
   function values_edit_freetext(question_type)
   {   
        var value = document.getElementById('question_type').value;   
        if (question_type.value=="SingleAnswerQuestion" || question_type.value=="MultipleAnswerQuestion" || question_type.value=="DateQuestion" || question_type.value=="YearQuestion")
        {
            $('question_freetext').hide();
            $('questiontype').show();
            params = "value="+ value
            var myajax = new Ajax.Updater('questiontype','/admin/authentication/choice_of_question',{method: 'get',evalScripts: true,asynchronous: true, parameters: params});
        }
        else   
        {
            $('question_freetext').show();
            $('questiontype').hide();
        }
   }
   
   function add_asset_date_condition()
   {
        var assettype = document.getElementById('asset_condition_type').value;    
        params = "value="+ assettype
        var myajax = new Ajax.Updater('asset_date_type','/admin/authentication/asset_date_type',{method: 'get',evalScripts: true,asynchronous: true, parameters: params});      
   }
   
   function question_search(search_text)
   {
       params = "value="+ search_text
       var myajax = new Ajax.Updater('question_search_result','/admin/questionnaires/question_search',{method: 'get',evalScripts: true,asynchronous: true, parameters: params});      
   }
   
   function save_questionlist(flag)
   {
        list_value = Sortable.serialize($('listTaken'));
        document.multi.action+="?"+list_value+'&flag='+flag;
        document.multi.submit();
   }
  
    function blockNonNumbers(obj, e, allowDecimal, allowNegative)
    {
        var key;
        var isCtrl = false;
        var keychar;
        var reg;
            
        if(window.event) {
            key = e.keyCode;
            isCtrl = window.event.ctrlKey
        }
        else if(e.which) {
            key = e.which;
            isCtrl = e.ctrlKey;
        }
        
        if (isNaN(key)) return true;
        
        keychar = String.fromCharCode(key);
        
        // check for backspace or delete, or if Ctrl was pressed
        if (key == 8 || isCtrl)
        {
            return true;
        }
    
        reg = /\d/;
        
        var isFirstN = allowNegative ? keychar == '-' && obj.value.indexOf('-') == -1 : false;
        var isFirstD = allowDecimal ? keychar == '.' && obj.value.indexOf('.') == -1 : false;
        
        return isFirstN || isFirstD || reg.test(keychar);
    }


    function add_other_txt_field_single(id, input_elements_id, new_or_exist)
    {
        div_single_others=$(input_elements_id)
        radio_buttons=div_single_others.getElementsByTagName('input');
        for(i=0;i<radio_buttons.length;i++) { radio_buttons[i].checked=false;  }
         
          name="questionnaire_submission[" + new_or_exist + "][single_others][" + id + "]"
          id = 'other_' + id + '_single'
          value=""
          var div = $(id)
          var box = new Element('input', {
              id: id+'txt',
              name: name,
              value: value,
              'class': 'textBoxOther'
          })
          $(id).innerHTML=""
          div.appendChild(box)           
          return false    
    }

    function add_other_txt_field_multiple(id, multiple_other, new_or_exist)
    {
        if(multiple_other.checked)
        {
            name="questionnaire_submission[" + new_or_exist + "][multiple_others][" + id + "]"
            id = 'other_' + id + '_multiple'
            value="";
            var div = $(id);
            var textbox = new Element('input', 
            {
                id: id+'txt',
                name: name,
                value: value,
                'class': 'textBoxOther'
            });
            $(id).innerHTML="";
            div.appendChild(textbox);      
        }
        else
            $('other_' + id + '_multiple').innerHTML="";
    }
  
    function add_ip_address(x)
    {
        if (x.value=='SubscriberInstitution')
        {
            $('hide_ip').show();
            $('hide_inst_name').show();
        }
        else
        {
            $('hide_ip').hide();
            $('hide_inst_name').hide();
        }
    }
    
    function disable_others(div_id, button_id)
    {
        if($(button_id) != null )
        {
            $(button_id).checked=false;
            $(div_id).innerHTML='';
        }
    }
    
    function export_to_csv(id)
    {
        url_path= "/admin/questionnaires/export_to_csv?from="+$('from_date').value+"&to="+$('to_date').value+"&id="+id
        window.open(url_path,"Questionnaire Report", "heigth=100px")
    }
    
    function save_auto_tag()
    {
       tag_name = $('auto_tag_name').value
       if(tag_name != "") 
       {
          /^[a-zA-Z0-9]/.test(tag_name) ? ( /[^a-zA-Z0-9-\'\s!£$%\^\&\*\(\)\`\+\-\"\?\@\¥]/.test(tag_name) ? alert('Name is not valid\nThe tag name should only contain characters A-Z, 0-9, dash, apostrophe , space,!, £, $, %, ^, &, *, (, ), `, +, -, ?, @, ¥, \', \",') : ( new Ajax.Request('/admin/tags/new_auto_tag', { method: 'post', evalScripts: true, parameters: $H({'name': tag_name}).toQueryString() }) ) ) : alert('Name should start with A-Z or a-z or 0-9')
       } 
       else
       {
            alert('Name should not be blank')
       }
    }
    
    function save_group()
    {
       tag_name = $('auto_tag_name').value
       if(tag_name != "") 
       {
            /^[a-zA-Z0-9]/.test(tag_name) ? ( /[^a-zA-Z0-9-\'\s!£$%\^\&\*\(\)\`\+\-\"\?\@\¥]/.test(tag_name) ? alert('Name is not valid') : ( document.auto_tag_form.submit() ) ) : alert('Name should start with A-Z or a-z or 0-9')
       } 
       else
       {
            alert('Name should not be blank')
       }
    }
    
    
    function update_group_or_tag(id, controller, type)
    {
       value = $('edit_name').value
    
       if(value != "")
       {
            /^[a-zA-Z0-9]/.test(value) ? ( /[^a-zA-Z0-9-\'\s]/.test(value) ? alert('Name is not valid') : ( new Ajax.Request('/admin/' + controller + '/update', { method: 'post', evalScripts: true, parameters: 'id=' + id + '&name=' + value + '&type=' + type }) ) ) : alert('Name should start with A-Z or a-z or 0-9')
       } 
       else
       {
            alert('Name should not be blank')
       }
    }
	
	
	
function remove_rule(rules_value_id){

    if (confirm("Are you Sure?")) {
        var myajax = new Ajax.Request('/wpl_admin/wpl_classifier/delete_rule', {
            method: 'get',
            onSuccess: function(){
                $(rules_value_id).remove()
            },
            onFailure: function(){
                alert('Unable to delete')
            },
            evalScripts: true,
            asynchronous: true,
            parameters: '?rules_value_id=' + rules_value_id
        });
    }
    
}	
	
	
	
	
function mandatory_select(ele, id){
    var status = ele.checked;
    $$(id).each(function(e){
        e.checked = status
    });
    ele.title = status ? 'Unselect all' : 'Select all'
}
	
	
	
	function delete_selected_rule_values(){
    var name = new Array();
    
    $$('#existing_fields input.delete_value:checked').each(function(e){
        name.push(e.value)
    });
    
    if (name.length < 1) {
        alert('Select atleast one rule value to delete')
    }
    else {
        if (confirm("Are you Sure?")) {
            document.delete_all.action += '&rules_value_ids=' + name
            document.delete_all.submit()
        }
    }
}

