jQuery(function() {
    $('#e_date1').datepicker();
    $('#e_date2').datepicker();
    $('#e_date3').datepicker();
    $('#e_date4').datepicker();
    $('.my_button1').click(function() {
 //   $("#ajaxBusyloader").css('display', 'block');
    $(".loading_ajax").css('display', 'block');
});   
   $('.my_button2').click(function() {
 //   $("#ajaxBusyloader").css('display', 'block');
    $(".loading_ajax").css('display', 'block');
});   
});

function remove_digital_asset(){
$('#prev_document').hide();
$('#no_digital_asset').show();
$('#digital_asset_change_link').show();
$('#Add_dig_asset').show();
$('#digital_asset_caption').hide();
 $('#digital_asset_change_link123').hide();
 if ($('#gen_digital_asset')!=null)
    {
   $('#gen_digital_asset').hide();
   
    }   
    $('#no_digital_asset').show();
$('#digital_asset_property_digital_asset_id').attr("value","");
$('#digital_asset_property_display_name').attr("value","");
}


  var windowSizeArray = [ "width=300,height=400",
                                    "width=960,height=600,scrollbars=yes" ];
 
            $(document).ready(function(){
                $('.newWindow').click(function (event){
 
                    var url = $(this).attr("href");
                    var windowName = "popUp";//$(this).attr("name");
                    var windowSize = windowSizeArray[$(this).attr("rel")];
 
                    window.open(url, windowName, windowSize);
 
                    event.preventDefault();
 
                });
                $('.gallery_newwindow').click(function(event){
                        var gallery_id = $("#gallery_property_image_sequence_id").attr("value");
                        var url = $(this).attr("href");
                        var append_url = url+gallery_id;
                        var windowName = "Gallery popUp";//$(this).attr("name");
                    var windowSize = windowSizeArray[$(this).attr("rel")];
                        window.open(append_url, windowName, windowSize);
                                         event.preventDefault();
                                         //return false;
                });
                $('.title_image_newwindow').click(function(event){
                        var image_id = $("#image_property_image_id").attr("value");
                        var url = $(this).attr("href");
                        var append_url = url+image_id;
                        var windowName = "Gallery popUp";//$(this).attr("name");
                    var windowSize = windowSizeArray[$(this).attr("rel")];
                        window.open(append_url, windowName, windowSize);
                                         event.preventDefault();
                                         //return false;
                });
          });
/*code for Image title Set ImageSet display preferences*/
        jQuery("#cust_img").live("click",function(){
                if(jQuery("#cust_img").is(':checked')){ jQuery("#image_customise").show(); }
                else{ jQuery("#image_customise").hide();}
        });
/*code for Image title Set ImageSet display preferences show*/
        jQuery("#set_preference").live("click",function(){
                 jQuery('#preference_setup').show();
         });


 
  $(document).ready(function(){
(function($){
  /*Code for menu ajax*/
  var ajax_call_menu=jQuery.fn.ajax_post = function() { 
    
                var id=$(this).attr("id");
                
  var data_url=$('#'+id).data('url');
   var data_param=$('#'+id).data('param');
   var update_id=$('#'+id).data('update');
          $.ajax({
                        url: data_url,
                        data:  data_param,
                        beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
                        error: function() {alert('eerrrr');},
                        beforeSend:function(){
                        jQuery("#load_indicatior").show();
                         },
                        success: function(msg) {
                         jQuery("#load_indicatior").hide();
                        $("#"+update_id).html(msg);
                          var action_type = $("#menu_entity_type option:selected").attr("value");
                          menu_action(action_type,id);
                                 // funcRegister();
                        }
                });
};
function menu_action(action_type,id){
  $.ajax({
    type:'POST',
    url:"/admin/menus/action_type?action_type="+action_type+"&id="+id,
     beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
     success: function(msg) {
        $("#action_type").html(msg);
     }
  });
}


        //making a ajax call and update the response and register the event
  var image_click_info=jQuery.fn.ajax_post = function() { 
                var id=$(this).attr("id");
  var data_url=$('#'+id).data('url');
   var data_param=$('#'+id).data('param');
   var update_id=$('#'+id).data('update');
          $.ajax({
                        url: data_url,
                        data:  data_param,
                        beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
                        error: function() {alert('eerrrr');},
                        beforeSend:function(){
                          jQuery("#load_indicatior").show();
                          },
                        success: function(msg) {
                         jQuery("#load_indicatior").hide();
                        $("#"+update_id).html(msg);
                                  funcRegister();
                        }
                });
};
   //making a ajax call and update the response without event register
  var ajax_call_update=jQuery.fn.ajax_post = function() { 
  
                var id=$(this).attr("id");
  var data_url=$(this).data('url');
   var data_param=$(this).data('param');
   var update_id=$(this).data('update');
          $.ajax({
                        url: data_url,
                        data:  data_param,
                        beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
                        error: function() {alert('eerrrr');},
                        beforeSend:function(){
                               jQuery("#load_indicatior").show();
                          },
                        success: function(msg) {
                          jQuery("#load_indicatior").hide();
                        var a=$("#"+update_id).html(msg);
                           subform(); 
                        },
                        complete:function(){
                          //call_tinymce();
                        }
                });
};


//making a ajax call and append the response
        var add_element=jQuery.fn.ajax_append_element = function() { 
          
                var id=$(this).attr("id");
                
  var data_url=$('#'+id).data('url');
   var data_param=$('#'+id).data('param');
 
   var update_id=$('#'+id).data('update');
          $.ajax({
                        url: data_url,
                        data:  data_param,
                        beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
                        error: function() {alert('eerrrr');},
                        success: function(msg) {
                        $("#"+update_id).append(msg);
                        
                        }
                });
};

//making a ajax call and append the response
        var add_element=jQuery.fn.ajax_append_element = function() { 
          
           var id=$(this).attr("id");
           var data_url=$(this).data('url');
           var data_param=$(this).data('param');
           var update_id=$(this).data('update');
              $.ajax({
                        url: data_url,
                        data:  "id="+data_param,
                        beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
                        error: function() {alert('eerrrr');},
                        success: function(msg) {
                        $("#"+update_id).append(msg);
                        funcRegister();
                        }
                  });
};
//jQuery(".ajax_append").click(add_element);

//article form submit
var article_submitfn=jQuery.fn.article_submit = function() { 
  var form_id = jQuery(this).parents("form").attr("id");
  var id=$(this).attr("id");
  var data_url =$('#'+id).data('url');
  var type=$('#'+id).data('type');
  var form_name=$('#'+id).data('fname');
  if (type == 'new')
  {
         
    $('form[name='+form_name+']').attr("action", data_url);
    $('form[name='+form_name+']').submit();
 }
 else if (type == 'edit')
 {
  $('form[name='+form_name+']').attr("action", data_url);
  $('form[name='+form_name+']').submit();
 }
else{
$('form[name='+form_name+']').attr("action", data_url);
$('form[name='+form_name+']').submit();
}
};

 

jQuery(".submit_form").click(article_submitfn);
/*script for digital_assets pop up and upload*/
//$('.submit_form_digital').live('click',function(){
//  var form_id = jQuery(this).parents("form").attr("id");
//  var id=$(this).attr("id");
//  var data_url =$('#'+id).data('url');
//  var form_name=$('#'+id).data('fname');
//  $('form[name='+form_name+']').attr("action", data_url);
//  $('form[name='+form_name+']').submit();
//  parent.jQuery.fn.colorbox.close(); 
//});

$(document).bind('cbox_closed', function(){
  var t = location.href
  if(t.indexOf('digital_assets')>0){
    location.reload();
  }
});


//close the form
 var close_content=jQuery.fn.close_button = function() { 

                var id=$(this).attr("id");
                var update_id=$('#'+id).data('update');
                $('#'+update_id).empty();
          
};



  var ajax_call_update_new=jQuery.fn.ajax_post = function() { 
  var id=$(this).attr("id");
  var data_url=$('#'+id).data('url');
   var data_param=$('#'+id).data('param');
   var update_id=$('#'+id).data('update');
   
          $.ajax({
                        url: data_url,
                        data:  data_param,
                        beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
                        error: function() {alert('eerrrr');},
                        beforeSend:function(){
                               jQuery("#load_indicatior").show();
                          },
                        success: function(msg) {
                          jQuery("#load_indicatior").hide();
                        var a=$("#"+update_id).html(msg);
                            subform(); 
                          },
                        complete:function(){
                          breadcrum_check_check();
                        }
                });
};

//jqurey function call
jQuery(".ajax_call_menu").unbind("click");
jQuery(".ajax_call_menu").click(ajax_call_menu);
jQuery(".ajax_call").die("click");
jQuery(".ajax_call").live("click",image_click_info);
jQuery(".ajax_call_update").die("click");
jQuery(".ajax_call_update").live("click",ajax_call_update);
jQuery(".ajax_call_update_new").die("click");
jQuery(".ajax_call_update_new").live("click",ajax_call_update_new);
jQuery(".ajax_append").unbind("click");
jQuery(".ajax_append").click(add_element);

jQuery("#tag_search").click(function(){
        var name = jQuery("#tag_name").val();
        var type = jQuery("#tag_entity_type option:selected").val();
        jQuery.ajax({
                url:'/admin/tags/search',
                data:'&tag[name]=' + name + '&tag[entity_type]=' + type,
                dataType:'html',
                beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
                success:function(search_data){
                         jQuery("#tag").html(search_data);
                         funcRegister();
                }
        });
});

jQuery("#vertical_search").click(function(){
        var name = jQuery("#vertical_name").val();
        jQuery.ajax({
                url:'/admin/verticals/search',
                data:'&vertical[name]=' + name ,
                dataType:'html',
                beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
                success:function(search_data){
                         jQuery("#vertical").html(search_data);
                         funcRegister();
                }
        });
});

function subform(){
    jQuery('.submitForm').click(function(){
                        jQuery('form').submit();
                });
}
function breadcrum_check_check(){
  if($('#object_select').attr('checked')){
      jQuery('#object').show();
    jQuery('#link').show();
  }
  else if($('#link_select').attr('checked')){
    jQuery('#object').hide();
    jQuery('#link').show();
  }
//$(document).ready(function(){ 
  /*jQuery('.breadcrum_type').live("click",function(){
  var temp = jQuery(this).attr('id');
  var page_property_id = jQuery("#bread_page_property").val();
          jQuery.ajax({
              type:'GET',
              url:'/admin/page/entity_type?action_type='+temp+'&page_property='+page_property_id,
              dataType:'html',
              success:function(data){
                                  jQuery("#bread_update").html(data);
                                 }
          });
      });*/
 // });
}
function funcRegister(){
      //  jQuery('#emp_tabs').tabs();
      // jQuery(".ajax_call_update").click(ajax_call_update);
        jQuery(".close_button").click(close_content);
      
                jQuery(".close_button_option").click(function(){    
                        jQuery(this).parent().parent("tr.site_property").remove();
                });
                
                 /* this is for image title in article form*/
                $('.add_img_article').click(function(){

                var id=$(this).attr("id");
                var image=$("#"+id).data('imagename');
                var image_path=$("#"+id).data('imagepath');
                var thumbnail_path=$("#"+id).data('thumbnailpath');
                var image_id=$("#"+id).data('imageid');
                var caption=$("#"+id).data('caption');
                
                confirmed = window.confirm("Do you want to make this image as title image");
                if (confirmed)
                {
          
                var img_pre="<table class='title_image_table'><tr><td><img src="+thumbnail_path+" "+" alt= /></td><td>Caption:<br/>"+caption+"</td></tr></table>";

                window.opener.$('#prev_image').html(img_pre);
                window.opener.$('#image_property_image_id').attr("value",image_id);
                window.opener.$('#no_image').hide();
                window.opener.$('#change_link').hide();
                window.opener.$('#prev_image').show();
                window.opener.$('#imageset_caption').show();
                window.opener.$('#change_link123').show();
                window.opener.$('#set_preference').show();
                parent.close();
                }
                else
                {}
                });
                
                /* this is for author image  in author form*/
                $('.add_img_author').click(function(){
                var id=$(this).attr("id");
                var image=$("#"+id).data('imagename');
                var image_path=$("#"+id).data('imagepath');
                var thumbnail_path=$("#"+id).data('thumbnailpath');
                var image_id=$("#"+id).data('imageid');
                var caption=$("#"+id).data('caption');
                
                confirmed = window.confirm("Do you want to make this image as title image");
                if (confirmed)
                {
          
                var img_pre="<table class='title_image_table'><tr><td><img src="+thumbnail_path+" "+" alt= /></td><td>Caption:<br/>"+caption+"</td></tr></table>";
                window.opener.$('#prev_author').show();
                window.opener.$('#prev_author').html(img_pre);
                window.opener.$('#image_property_image_id').attr("value",image_id);
                window.opener.$('#no_image').hide();
                window.opener.$('#change_link').hide();
                window.opener.$('#imageset_caption').show();
                window.opener.$('#change_link123').show();
                window.opener.$('#set_preference').show();
                window.opener.$('#gen_image').hide();
                parent.close();
                }
                else
                {}
                });
                
                  
                  /* this is for company image in author form*/
       $('.add_img_company').click(function(){
                var id=$(this).attr("id");
                var image=$("#"+id).data('imagename');
                var image_path=$("#"+id).data('imagepath');
                var thumbnail_path=$("#"+id).data('thumbnailpath');
                var image_id=$("#"+id).data('imageid');
                var caption=$("#"+id).data('caption');
                
                confirmed = window.confirm("Do you want to make this image as title image");
                if (confirmed)
                {
          
                var img_pre="<table class='title_image_table'><tr><td><img src="+thumbnail_path+" "+" alt= /></td><td>Caption:<br/>"+caption+"</td></tr></table>";
                 window.opener.$('#prev_company').show();
                window.opener.$('#prev_company').html(img_pre);
                window.opener.$('#company_logo_image_id').attr("value",image_id);
                window.opener.$('#no_image').hide();
                window.opener.$('#change_link').hide();
                window.opener.$('#no_image_company_logo').hide();
                window.opener.$('#imageset_caption').show();
                window.opener.$('#change_link123').show();
                window.opener.$('#set_preference').show();
                parent.close();
                }
                else
                {}
                });  

 

/*Code for change company logo in auther page*/
                jQuery(".add_img_company_logo").click(function(){
                        var id=jQuery(this).attr("id");
                        var image=jQuery("#"+id).data('imagename');
                        var image_path=jQuery("#"+id).data('imagepath');
                        var thumbnail_path=jQuery("#"+id).data('thumbnailpath');
                        var image_id=jQuery("#"+id).data('imageid');
                        var caption=jQuery("#"+id).data('caption');
                        var confirmed = window.confirm("Do you want to make this image as company logo image");
                        if (confirmed)
                        {
                            var img_pre='<table><tr><td><img src='+thumbnail_path+' '+' alt= /></td></tr></table>'
                            window.opener.jQuery('#change_link_company_logo').hide();
                            window.opener.jQuery('#no_image').hide();   
                            window.opener.jQuery('#change_link').hide(); 
                            window.opener.jQuery('#prev_company_logo').show();
                            window.opener.jQuery('#change_link123').show();
                            
                            
                        if(window.opener.jQuery('#gen_image_company_logo')!=''){window.opener.jQuery('#gen_image_company_logo').hide();}    
                         
                            window.opener.jQuery('#prev_company_logo').html(img_pre); 
                            window.opener.jQuery('#image_property_image_id').attr("value",image_id); 
                          parent.close();
                        } 
                        else {}
                });

 
 
 }

                
                
                

        })(jQuery);
        
});

 //the code without generic


//add video
$(function() {

/*$('.select_video').click(function(){
var id=$(this).attr("id");
var video_id=$(this).data('videoid');
var video_name=$(this).data('videoname');
var img_pre='<img src='+video_name+' '+' alt= />';
alert("DO you want to insert this Video?");
window.opener.$('#prev_video').show();
window.opener.$('#prev_video').html(img_pre);
window.opener.$('#add_audio2').hide();
window.opener.$('#no_video').hide();
window.opener.$('#gen_video').hide();
window.opener.$('#vid_close').hide();
window.opener.$('#no_vid').show();
window.opener.$('#article_media_detail_id').val(video_id);
parent.close();
});
*/

$('.remove_video').click(function(){
        $('#gen_video').hide();
        $('#add_video_div').show();
        $('#prev_video').hide();
        $('#no_vid').hide();
        $('#vid_close').show();
        $('#article_media_detail_id').attr("value","");
});


//code to remove image 
//code only to remove aricle title image 
$('.remove_image9').click(function(){      
//alert('hi'); 
    $('#no_image_div').show();
    $('#no_image').hide();
    $('#no_image124').hide();
    $('#change_link').show();
    $("#change_link_add_image").show();
    $("#gen_image").hide();
    $('#prev_image').hide();
    $("#prev").hide();
    $('#change_link123').hide();
    $('#preference_setup').hide();
    $('#set_preference').hide();        
    $('#imageset_caption').hide();
    $('#image_property_image_id').attr("value","");
});

//code to remove other title image 
$('.remove_image').click(function(){      
//alert('hi'); 
    $('#no_image').show();
    $('#no_image124').hide();
    $('#change_link').show();
    $("#change_link_add_image").show();
    $("#gen_image").hide();
    $('#prev_image').hide();
    $("#prev").hide();
    $('#change_link123').hide();
    $('#preference_setup').hide();
    $('#set_preference').hide();        
    $('#imageset_caption').hide();
    $('#image_property_image_id').attr("value","");
});
//audio add code

$('.remove_companylogo_image').click(function(){
  $('#prev_company_logo').hide();
    $('#gen_image_company_logo').hide();
});

$('.insert_audio').click(function(){
var id=$(this).attr("id");
var audio_id=$("#"+id).data('audioid');
var audio_name=$("#"+id).data('audioname');
var img_pre='<img width=100 height=80 src=/images/music.png  alt=no_image_available /><div>'+audio_name+'</div>';
window.opener.$('#prev_audio').show();
window.opener.$('#prev_audio').html(img_pre);
window.opener.$('#add_audio').hide();
window.opener.$('#no_audio').hide();
window.opener.$('#no_audio_div').hide();
window.opener.$('#no_aid').show();
//window.opener.$('#add_audio').show();
window.opener.$('#article_audio_id').val(audio_id);
parent.close();
});

/*Code for Add Image Gallery for Article page*/
jQuery("#gallery_list .insert_gallery").click(function(){
  //alert('hi');
        var gallery_id = jQuery(this).data("imageid");
        var image_path = jQuery(this).data("imgpath");
    var img_pre='<table><tr><td><img src='+image_path+' '+' alt= width=80 height=80 /></td></tr></table>'
    window.opener.jQuery('#gallery_link').hide();   
    window.opener.jQuery('#gallery_link123').show();
    window.opener.jQuery('#prev_gallery').show();
    window.opener.jQuery('#remove_1').show();
    window.opener.jQuery('#edit_1').show();
    window.opener.jQuery('#change_1').show();    
    if (window.opener.jQuery('#no_gallery')!=''){window.opener.jQuery('#no_gallery').hide();}    
    if (window.opener.jQuery('#gen_gallery')!=''){window.opener.jQuery('#gen_gallery').hide();} 
    window.opener.jQuery('#no_gallery1').hide();
    window.opener.jQuery('#prev_gallery').html(img_pre); 
    window.opener.jQuery('#no_gallery_div').hide();
    window.opener.jQuery('#no_gallery_div_old').hide();
    window.opener.jQuery('#gallery_property_image_sequence_id').attr("value",gallery_id);    
    parent.close();
});

jQuery("#remove_1").click(function(){
	//alert('test')
        jQuery('#prev_gallery').hide();
         jQuery('#no_gallery_div5').show();
         
         jQuery('#prev_gallery').hide();
        jQuery('#gallery_link123').hide();
        jQuery('#gallery_link').show();
        jQuery('#no_gallery_div').show();
        jQuery('#no_gallery_div').show();
        jQuery('#gallery_no').show();      
        $('#no_gallery').show();    //added new    
        jQuery('#no_gallery_div5').show();
     //   jQuery('#add_gallery1').hide();
        jQuery('#no_gallery_div').show();
         jQuery('#no_gallery_div_old').show();
        if (jQuery('#gen_gallery')!=''){ jQuery('#gen_gallery').hide();}
        jQuery('#gallery_property_image_sequence_id').attr("value"," ");
        if (jQuery('#add_2')!=''){jQuery('#add_2').show();}
});


jQuery("#remove_abc").click(function(){
	//alert('testaaaa')
	 jQuery('#no_gallery_div5').show();
	 jQuery('#prev_gallery').hide();
	 jQuery('#gallery_link123').hide();
	 
});
	
/*function insert_gallery_to_article(image_path,gallery_id)
{
   var img_pre='<table><tr><td><img src='+image_path+' '+' alt= width=60 height=60 /></td></tr></table>'
//parent.$('#no_gallery_div5').show(); //new
   parent.$("#repsitory_r").hide();
   parent.$("#browse_b").hide();
   parent.$('#gallery_link').hide();
   parent.$('#gallery_link123').show();
   parent.$('#prev_gallery').show();
   if (parent.$('#no_gallery')!=null)
    {
    parent.$('#no_gallery').hide();

    }
     if (parent.$('#gen_gallery')!=null)
    {
    parent.$('#no_gallery_div5').hide();
    parent.$('#gen_gallery').hide();
    parent.$('#gallery_link123').show();
    
    }
    parent.$('#prev_gallery').html(img_pre);
    parent.$('#gallery_property_image_sequence_id').val(gallery_id);
    parent.jQuery.fn.colorbox.close();
}*/
//GALLERY end 

$('.remove_audio').click(function(){
        $('#prev_audio').hide();
        $('#no_aid').hide();
        $('#gen_audio').hide();
        $('#no_audio').show();
        $('#add_audio').show();
        if(jQuery('#no_audio1')!=''){jQuery('#no_audio').hide();}
        $('#no_audio1').show();
       //$('#no_audio_div').show();
        jQuery("#article_audio_id").attr("value","")
});
$('#set_preference').click(function(){
        $('#preference_setup').show();
});
$('#cust_img').click(function(){
        if ($('cust_img').checked == true){
$('#image_customise').show();
}
else{
$('#image_customise').hide();
} 
});
/*Code for OnChange in Products Create Product*/
jQuery("#product_product_type").change(function () {
var productType= jQuery("#product_product_type").val();
if(productType =='Questionnaires'){
jQuery('.Authorized').hide();
jQuery('.Questionnaires').show();
}
else{
jQuery('.Questionnaires').hide();
jQuery('.Authorized').show();
}
});

});

$(function(){
	$("#tab_1 li+li").remove();
})



jQuery( function() {
/*for audio upload*/
jQuery("#audio_upload").click(function(){
var value=jQuery("#audio_audio_path").val();
if(value == "")
{
alert("Audio path can't be blank");
return false;
}
else
{
jQuery("#audio_submit").submit();
}
});


/*for video upload*/
jQuery("#media_upload").click(function(){
var value=jQuery("#media_detail_video_path").val();
if(value == "")
{
alert("Video path can't be blank");
return false;
}
else
{
jQuery("#media_submit").submit();
}
});
});
jQuery( function() {
  jQuery("#tab_tab_1").tabs();

});
jQuery( function() {
  jQuery(".close_button_option").click( function() {
    jQuery(this).parent().parent("tr").remove();
  });
});
jQuery( function() {
  jQuery(".close_button_option_td").click( function() {
    jQuery(this).parent().parent("td").remove();
  });
});
/*code for insert add image gallery from image window*/
/*written by karthikeyan*/

  jQuery("#add_image_gallery a").live("click",function() {
    window.opener.jQuery('#image_property_width').attr("value",jQuery(this).data('width'));
    window.opener.jQuery('#image_property_height').attr("value",jQuery(this).data('height'));
    window.opener.jQuery('#image_property_image_id').attr("value",jQuery(this).data('imageid'));
    var img_pre='<table><tr><td><img src='+ jQuery(this).data('imgpath') +' '+' alt= /></td></tr></table>'
    window.opener.jQuery('#add_image_to_gallery').html(img_pre);
    parent.close();
  });

// jQuery added by selva Start

// Permission changing in new and edit role type.
jQuery(function(){
  jQuery("#role_user_type").change(function() {
    var user_type = jQuery("#role_user_type").val();
    var params = "&type=" + user_type;
    var path = window.location.host;
    jQuery.ajax({
      type : 'GET',
      url : "http://" + path + "/admin/roles/change_user_type_permission?" + params,
      dataType : "html",
      beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
      success : function(data) {
        jQuery("#user_type_base_permissions").html(data);
      }
    });
  });
});

// Site changing in the top dropdown
jQuery(function(){
  jQuery("#site_id").change(function() {
    jQuery('#change_website').submit();
  });
});

// Product criteria link change according to the dropdown change
jQuery(function(){
  jQuery(".select_asset_type_entity_type").change(function() {
    var selected_type = jQuery(this).attr("value");
      if (selected_type == ""){
          jQuery('.asset_type_1').attr('href','/admin/product_criteria/new?type=Article');
          jQuery(".select_asset_type_entity_type").attr("value", "");
      }
      else {
          jQuery('.asset_type_1').attr('href',"/admin/product_criteria/new?type="+selected_type);
          jQuery(".select_asset_type_entity_type").attr("value", selected_type);
      }
  });
});

// Older than & newer than in product criteria
jQuery(function(){
  jQuery("#asset_condition_type").change(function() {
    var assettype = jQuery("#asset_condition_type").attr("value");
    var path = window.location.host;
    var params = "value="+ assettype;
    jQuery.ajax({
      type : 'GET',
      url : "http://" + path + "/admin/product_criteria/asset_date_type?" + params,
      dataType : "html",
      beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
      success : function(data) {
        jQuery("#asset_date_type").html(data);
      }
    });
  });
});

jQuery(function(){
  jQuery("#site_template").change(function() {
    var template_type = jQuery("#site_template").attr("value");
    var path = window.location.host;
    var params = "template_type="+ template_type;
    jQuery.ajax({
      type : 'GET',
      url : "http://" + path + "/admin/sites/template_type?" + params,
      dataType : "html",
      beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
      success : function(data) {
        jQuery("#dynamic_template_selection").html(data);
      }
    });
  });
});

// jQuery added by selva End


/*for gallery new imageset*/
jQuery(function(){
                jQuery("#new_button").click(function(){
                         jQuery('#image_property_height').attr("value","");
                         jQuery('#image_property_image_id').attr("value","");
                         jQuery('#image_property_logical_name').attr("value","");
                         jQuery('#image_property_author').attr("value","");        
                         jQuery('#image_property_description').attr("value","");
                         jQuery('#add_image_to_gallery').html(" ");
                         jQuery('#test').show();
                });

        
                /*Code for remove author image*/
                jQuery(".remove_author_image").click(function(){
                        if(jQuery('#prev_author')!=''){jQuery('#prev_author').hide();}
                        if(jQuery('#no_image')!=''){jQuery('#no_image').show();}
                        if(jQuery('#change_link')!=''){jQuery('#change_link').show();}
                        if(jQuery('#no_image_div')!=''){jQuery('#no_image_div').show();}
                        if(jQuery('#set_preference')!=''){jQuery('#set_preference').hide();jQuery('#preference_setup').hide();
                        jQuery('#image_customise').hide();}
                        if(jQuery('#imageset_caption') != '') {jQuery('#imageset_caption').hide();}
                        jQuery('#change_link123').hide();
                        if(jQuery('#gen_image')!=''){jQuery('#gen_image').hide();}   
                        jQuery('#image_property_image_id').attr("value","");
                        if(jQuery('#imageset_caption') != '') {jQuery('#image_property_caption').attr("value","");}
                });                           
         /*Code for remove company logo image in author page*/
        jQuery(".remove_companylogo_image").click(function(){
                        jQuery('#prev_company_logo').hide();
                        jQuery('#no_image_company_logo').show();
                        jQuery('#change_link_company_logo').show();
                        jQuery('#change_link123_company_logo').hide();
                        if (jQuery('#gen_image_company_logo')!=''){jQuery('#gen_image_company_logo').hide();}   
                        jQuery('#company_logo_image_id').attr("value","");
                        
                        
                });

});

jQuery(function(){
 jQuery("#imageset_search").click(function(){
   var image_name=jQuery("#image_detail_search_name").attr("value"); 
   var created_by=jQuery("#image_detail_search_created_by option:selected").attr("value");
   var site_id=jQuery("#image_detail_search_site_id option:selected").attr("value");
   var from=jQuery("#image_detail_search_from_id").attr("value"); 
   var to=jQuery("#image_detail_search_to_id").attr("value");
   var title=jQuery("#path_title").attr("value");
   var order_by = jQuery(this).data("orderby");
    if (order_by=="date"){
        order_by="updated_at desc"
    }
    if (order_by=="name"){
        order_by="image_name"
    } 
    if (jQuery("#set_flag1")==null){
      var flag=""
    }
   else{
    var flag=jQuery("#set_flag1").attr("value");
    }
   var path=jQuery("#path_flag").attr("value");
   var params = "&image_detail_search[name]=" + image_name + "&image_detail_search[created_by]=" + created_by + "&image_detail_search[site_id]=" + site_id + "&image_detail_search[from]=" + from + "&image_detail_search[to]=" + to + "&flag=" + flag + "&path=" + path + "&title=" + title

      jQuery.ajax({
        type:"GET",
        url:"/admin/image_details/imageset_list",
        data:params,
        dataType:"html",
        success: function(data) {
        jQuery("#image_list").html(data);
               
        }
    });

});
});
/*Code for open colorbox for article further reading*/

function colorbox_call(){
  
}
jQuery(function(){
  jQuery(".further_reading").live("click",function(event){
 var article_id = jQuery(this).data("id");
    var href = jQuery(this).data("url");
//    href = /admin/articles/further_reading?
    var allvals = [];
    jQuery("#further_reading_list input").each(function(){
        allvals.push(jQuery(this).attr("value"));
    });
   // alert(allvals);
    if(article_id=='new'){
      var set_url = href+'assign_id='+allvals;
      jQuery(this).attr("href",set_url);
     // jQuery(this).find(".further_reading").colorbox({slideshow:true,iframe:true,width:"80%", height:"80%"});
      $.colorbox({href:set_url,iframe:true,width:"90%", height:"90%"});
       event.preventDefault();
    }
    else{
       var pars =  '&assign_id=' + allvals+ '&article_id=' + article_id; 
       var set_url = href+pars;
       jQuery(this).attr("href",set_url);
      // jQuery(this).find(".further_reading").colorbox({slideshow:true,iframe:true,width:"80%", height:"80%"});
       
       $.colorbox({href:set_url,iframe:true,width:"90%", height:"90%"});
       event.preventDefault();
    }
});
});
       


/*close button for sortable list items*/
jQuery("#listTaken li a.closebutton").live("click", function(event){
  jQuery(this).parents("li.fe_pui-autocomplete-box").remove();
});
/*Sortable list item for Questionaries page*/           
$(function() {
          $("#listTaken").append('<li style="height:35px;"></li>');
          $( "#listTaken, #result_drag" ).sortable({
                   connectWith: ".fe_pui-autocomplete-holder",
                   opacity:0.7
          });
 });
 
 jQuery(function(){
        jQuery('#tab_tab_1').tabs();


});





/*for upload image rules in imagelist*/
jQuery(function(){
jQuery(".help_show").click(function(){
 
   jQuery("#browse_help").toggle();
  
});
});

/*this code is for character count in article form*/
jQuery(document).ready(function () {
      jQuery('#txtarea1').bind('keyup', function() {
       var cnt = $(this).val().length;
       jQuery('#counter1').html(cnt);
        });
});
    

/* below code has been added by selva for imageset redesign */
function image_popup(current){
    var url = $(current).attr('data-url');
    $.colorbox({href:url,iframe:true,width:"90%", height:"90%"});
    event.preventDefault();
}

/*function insert_gallery_to_article(image_path,gallery_id)
{
    var img_pre='<table><tr><td><img src='+image_path+' '+' alt= width=60 height=60 /></td></tr></table>'
    
    opener.$('#gallery_link').hide();   
    opener.$('#gallery_link123').show();
    opener.$('#no_gallery_div_old').hide();
    opener.$('#no_gallery_div').hide();   
    opener.$('#prev_gallery').show();
      if (opener.$('#no_gallery')!=null)
    {
    opener.$('#no_gallery').hide();
   
    }    
     if (opener.$('#gen_gallery')!=null)
    {
    opener.$('#gen_gallery').hide();
   
    }    
    opener.$('#prev_gallery').html(img_pre); 
    opener.$('#gallery_property_image_sequence_id').val(gallery_id);    
    parent.close();
}*/
/*start this Code insert into gallery in article page added by ramesh*/

function insert_gallery_to_article(image_path,gallery_id)
{
	confirmed = window.confirm("Do you want to upload this image");
if (confirmed) 
{
   var img_pre='<table><tr><td><img src='+image_path+' '+' alt= width=60 height=60 /></td></tr></table>'
//parent.$('#no_gallery_div5').show(); //new
   parent.$("#repsitory_r").hide();
   parent.$("#browse_b").hide();
   parent.$('#gallery_link').hide();
   parent.$('#gallery_link123').show();
   parent.$('#prev_gallery').show();
   if (parent.$('#no_gallery')!=null)
    {
    parent.$('#no_gallery').hide();

    }
     if (parent.$('#gen_gallery')!=null)
    {
    parent.$('#no_gallery_div5').hide();
    parent.$('#gen_gallery').hide();
    parent.$('#gallery_link123').show();
    
    }
    parent.$('#prev_gallery').html(img_pre);
    parent.$('#gallery_property_image_sequence_id').val(gallery_id);
    parent.jQuery.fn.colorbox.close();
   }else{
   	 return false;
   }
  
}

$(function() {
$(".changethumbnailimage").click(function() {
         var url = $(this).attr('data-url');
    $.colorbox({href:url,iframe:true,width:"90%", height:"90%"});
    event.preventDefault();
        })
})

$(function() {
$(".newthumbnailimage").click(function() {
         var url = $(this).attr('data-url');
    $.colorbox({href:url,iframe:true,width:"90%", height:"90%"});
    event.preventDefault();
        })
})

jQuery("#remove_abc").click(function(){
        //alert('testaaaa')
         jQuery('#no_gallery_div5').show();
         jQuery('#prev_gallery').hide();
         jQuery('#gallery_link123').hide();

});

/*end*/


