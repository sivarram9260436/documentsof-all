jQuery(document).ready(function() { // Document ready start
/*split article*/
$(function(){
	$(".start").click(function(){
	  var article_id = $(this).data("articleid");
	  var content= tinyMCE.activeEditor.getContent();
	        if (content=="")
	        {
	         alert("Content should not be blank");
	        }
	        else
	        {           
	          $(this).attr("onclick","return false");
	          var  article_act = "/admin/articles/split_article_into_pages?id="+article_id;          
	          $("#edit_article_"+article_id).attr("action",article_act);
	          $("#edit_article_"+article_id).submit();
	        }
	
	});
});	
	
jQuery(function() {
		/*Code for save & return button*/
		jQuery("#save_return_list").click(function() {
			var get_action = jQuery("#new_featured_set").attr("action");
			var rankedlistname = jQuery('#featured_set_name').val();
			var blankRE = /^\s/;
			if (rankedlistname.trim() == "") {
				alert("Ranked List Name should not be blank.");
				return false;
			} else if (blankRE.test(rankedlistname)) {
				alert("Ranked List Name should not start with a blank space.")
				return false;
			} else {
				$(this).parents("form").submit()
			}
		});

		jQuery("#save_collections a").click(function() {
			var get_action = jQuery("#new_featured_set").attr("action");
			var rankedlistname = jQuery('#featured_set_name').val();
			var blankRE = /^\s/;
			if (rankedlistname.trim() == "") {
				alert("Ranked List Name should not be blank.")
				return false;
			} else if (blankRE.test(rankedlistname)) {
				alert("Ranked List Name should not start with a blank space.")
				return false;
			} else {
				var list_value = jQuery("#listTaken").sortable('serialize', {
					key : 'listTaken[]',
					attribute : 'data-listid'
				});
				$.ajax({
					url:$(this).parents("form").attr('action'),
					type:'POST',
					dataType:'json',
					data:list_value+'&featured[name]='+rankedlistname+'&featured[expire_date]='+$('#featured_expire_date_id').attr('value')+'&path=edit&featured_set='+$('#featured_set').attr('value')+'&flag=save&featured[expire_status]='+$('#featured_expire_status').attr('value'),
					success:function(data){
						//location.reload();
						location.href=data.path			
					}
				});
			}
		});
	});	
	
/*this is the code for the preview*/
jQuery('.preview_select').popupWindow({ 
height:500, 
width:800, 
top:50, 
left:50,
 scrollbars: 1  
}); 	
	
/*This is code for hide and show od addedit in static fragment form*/      
jQuery('#article_format_html').click(function(){
jQuery('#inline_static').show();
jQuery('#static_tinymc').show();
jQuery('#plain_static').hide();
});
jQuery('#article_format_plain_text').click(function(){
jQuery('#plain_static').show();
jQuery('#inline_static').show();
jQuery('#static_tinymc').hide();
});
	
/*Code for Imageset insert Tinymce select image*/
	jQuery("#image_upload_form .ajax_call").live("click", function() {
		//jQuery("#image_upload_form .ajax_call").click(function(){
 
		var id = jQuery(this).attr("id");
		var data_url = $('#' + id).data('url');
		var data_param = $('#' + id).data('param');
		var update_id = $('#' + id).data('update');
		jQuery.ajax({
			url : data_url,
			data : data_param,
                        beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
			error : function() {
				alert('eerrrr');
			},
			success : function(msg) {
				//jQuery("#"+update_id).html(msg);
				jQuery("#view_image_information").html(msg);
			}
		});
	});
	
/*Code for Imageset insert Tinymce select image options with size*/	
	jQuery("#view_image .image_option").live("click", function() {
		var id = jQuery(this).data("id");
		var width = jQuery(this).data("width");
		var height = jQuery(this).data("height");
		var image_type = jQuery(this).data("type");
		var path = jQuery(this).data("path");
		var pars = "id=" + id + '&width=' + width + '&height=' + height + '&image_type=' + image_type + '&path=' + path;
		jQuery.ajax({
			type : 'GET',
			url : '/admin/image_details/select_inline_image',
			data : pars,
                        beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
			dataType : 'html',
			success : function(image_update) {
				jQuery("#view_image_information").html(image_update);
			}
		});
	});

/*Code for comment moderation selct checkbox*/
	jQuery("#button_id").click(function() {
		var trial = jQuery("#select_option option:selected").val();
		if(!trial) {
			alert("please select a value from drop down list");
		} else {
			var a = jQuery("input[name='comment[published][]']:checked").val();
			if(a == undefined) {
				alert("please select a value from checkbox");
			} else {
				jQuery("form").submit();
				return true;
			}
		}

	});

/*Code for static page when change dropdown list the action(href) chane to anchor tag*/  
	jQuery("#select_article_section_id").change(function(){
	    var get_value = jQuery(this).attr("value");
	    if(get_value == "static-page"){
	        jQuery("#static_page_link").attr("href","/admin/static_page/new?section_type=static-page")
	    }
	    else if(get_value == "static-fragment"){
	        jQuery("#static_page_link").attr("href","/admin/static_page/new?section_type=static-fragment")
	    }
	});
	
/*Code for Ajax pagination for collections*/	
	jQuery('.needAjax div.pagination a').live('click', function() {  
            var url = jQuery(this).attr("href");  
            var update_div = jQuery(this).parents('.update_pagination_block').attr("id")  ;
            jQuery("#"+update_div).load(url);
            jQuery("div#loading").show();
            return false;  
     });

 $("#ranklist_navmenu-h li a").click(function(){
        $("div#loading").hide();
  }); 
	
/*code for Advance search panel ToggleDown and ToggleUp*/
/*
	jQuery(".advance_search_panel").live("click", function() {
		jQuery.ajax({
			url : '/admin/articles/advance_search_view',
			type : 'POST',
			data : 'advance_search',
			dataType : 'html',
			success : function(advance_search) {
				jQuery("#search_form").html(advance_search);
			}
		});
		jQuery(this).attr("class", "advance_search_panel_hide");
	});

	jQuery(".advance_search_panel_hide").live("click", function() {
		jQuery("#search_form").html(" ");
		jQuery(this).attr("class", "advance_search_panel");
	});*/


//jQuery(document).ready(function(){
	jQuery("#assets_upload").live("click",function(){
	  var flag = jQuery(this).data("flag");
	  var pars = "upload=" + "upload"+"&article_doc_upload=" +flag;
	  jQuery.ajax({
	    type:'GET',
	    url:'/admin/digital_assets/upload',
	    data:pars,
            beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
	    dataType:'html',
	    success:function(upload_data){
	      jQuery("#assets_information_upload").html(upload_data);
	    }
	  });
	});
//});


	jQuery("#submit_document a").live("click", function() {

		var digital_asset_names = jQuery(this).data("assestname");
		// alert(digital_asset_names);
		alert(jQuery('#digital_asset_document_path').attr("value"));
		if(digital_asset_names.split(',').indexOf(jQuery('#digital_asset_document_path').attr("value").replace(' ', '_')) != -1) {
			alert('Document already exists.');
		} else if(jQuery('#digital_asset_document_path').val().match(/xls|xlt|pdf|docx|pptx|xlsx|odt|doc|ppt/)) {
			jQuery('form#asset').submit();
		} else {
			alert('You can only upload Word, Excel, PowerPoint and PDF documents.');
		}
	});

//ajax call not registering the responce
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
                        success: function(msg) {
                        $("#"+update_id).html(msg);
                                 
                        }
                });
};
jQuery(".ajax_call_").click(image_click_info);

var ajax_form_serialize_method = jQuery.fn.ajax_post = function(){
	
	var id = $(this).attr('id');
	var data_url=$('#'+id).data('url');
	var data_fname=$('#'+id).data('fname_id');
	var update_id=$('#'+id).data('update');
      $.ajax({
                    url: data_url,
                    type : 'POST',
                    data: $("form").serialize(),
                    beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
                    error: function() {alert('eerrrr');},
                    beforeSend:function(){
                          jQuery("#load_indicatior").show();
                         },
                    success: function(msg) {
                    	    	jQuery("#load_indicatior").hide();
                    	$("#"+update_id).html(msg);
                    },
                     complete:function(){
                    window.location.reload();
                    }
            });
}
jQuery(".ajax_call_tag_form").die("click");
jQuery(".ajax_call_tag_form").live("click",ajax_form_serialize_method);

var ajax_search_form_serialize_method = jQuery.fn.ajax_post = function(){
	var id = $(this).attr('id');
	var data_url=$('#'+id).data('url');
	var data_fname=$('#'+id).data('fname_id');
	var update_id=$('#'+id).data('update');
      $.ajax({
                    url: data_url,
                    type : 'POST',
                    data: $("form").serialize(),
                    beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
                    error: function() {alert('eerrrr');},
                    beforeSend:function(){
                          jQuery("#load_indicatior").show();
                         },
                    success: function(msg) {
                    	    	jQuery("#load_indicatior").hide();
                    	$("#"+update_id).html(msg);
                    },
            });
}
jQuery(".ajax_call_search_form").die("click");
jQuery(".ajax_call_search_form").live("click",ajax_search_form_serialize_method);

/*jQuery method for static page for jquery functionality*/
var ajax_call_static=jQuery.fn.ajax_post = function() { 
              var id=$(this).attr("id");
var data_url=$('#'+id).data('url');
 var new_data_url=data_url+jQuery("#select_article_section_id option:selected").attr("value");
 var data_param=$('#'+id).data('param');
 var update_id=$('#'+id).data('update');
        $.ajax({
                      url: new_data_url,
                      data:  data_param,
                      beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
                      error: function() {alert('Name should not be blank.');},
                       beforeSend:function(){
                          jQuery("#load_indicatior").show();
                         },
                      success: function(msg) {
                      	jQuery("#load_indicatior").hide();
                      $("#"+update_id).html(msg);
                                                    
                      }
              });
};
jQuery(".ajax_call_static").live("click",ajax_call_static);   


/*Code for static fragment select radio button and Checkbox*/
jQuery("#format_static input,#inline_static input").click(function(){
  var format = jQuery("#format_static input:checked");
  var radio_text=jQuery("input:radio:checked").val();
  var url = window.location.pathname;
  var article_id = parseInt(url.split('/')[url.split('/').length - 1]);
  var col="",text_all="";
  jQuery("#inline_static input:checked").each(function(){
      var value = jQuery(this).attr("value");
      var text = jQuery(this).next("span").text();
      col = value + col;
      text_all+=text;
  });
  jQuery.ajax({
    type:'POST',
   data:"radio_text="+radio_text+";"+"checkbox_text="+text_all+";"+"article_id="+article_id,
    dataType:'html',
    url:'/admin/static_page/select_fragment',
    success:function(update_data){
      jQuery("#static_update").html(update_data);
         jQuery("#static_hide").hide();
          execute_tinymce();
    }
  });
});
//call_tinymce();
/*code for sharecast*/
	jQuery(".newsfeed_colorbox").click(function(event){
	    var article_id = jQuery(this).data("id");
	    var href = jQuery(this).data("url");
	    var set_url = href+"/"+article_id;
	    jQuery(this).attr("href",set_url);
	    $.colorbox({href:set_url,iframe:true,width:"90%", height:"90%"});
	    event.preventDefault();
	});

}); 


/*code for advance search panel article*/

jQuery(".advance_search_panel").live("click",function(){
    jQuery.ajax({
        url:'/admin/articles/advance_search_view',
        type:'POST',
        data:'advance_search',
        beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
        dataType:'html',
        success:function(advance_search){
        	jQuery("#search_form").html(advance_search);
        }
    });
     jQuery(this).attr("class","advance_search_panel_hide");
     jQuery(this).addClass("advance_active");
});



/*code for advance search panel article*/
/*jQuery(".advance_search_panel").live("click",function(){
//	$('#search_form').html('');
//$('.ui-dialog').remove()
    jQuery.ajax({
        url:'/admin/articles/advance_search_view',
        type:'POST',
        beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
        data:'advance_search',
        dataType:'html',
        success:function(advance_search){
        	//jQuery("#search_form").html(advance_search);
        	 jQuery("#search_form").html(advance_search).dialog({
		      model:true,
		      title:'Advance Search',
		      position: "center",
		      draggable: false,
		      width: '600px',
		      closeText: ' ',
		      /*beforeclose: function (){
		                      if(!confirm('Do u want close the dialog?')){
		                           return false;
		                      }        
		                       else {
		                               $('.ui-overlay').removeClass('ui-widget-overlay');
		                               $("body").css("overflow", "auto");
		                       }
		                    },
		                    buttons: {
		       "Submit": function() {
		        kreatioAddEdit.existing_component_form_submit($(this).find('form').attr('action'),$(this).find('form').attr('id'),$(this).find('#component_id').attr('value'))
		       },
		        }*/
		    
		 
   
   //	  jQuery(this).attr("class","advance_search_panel_hide");


/*for menu*/
$(document).ready(function () {
        $('#second_level_slider').css({'left':'0px','position':'relative','overflow':'hidden'});
                $('.right_mark').click(function () {
                    $('#second_level_slider').css({'left':'-700px','position':'relative','overflow':'hidden'});
                    $('.submenu').css('overflow','hidden');
                });
                $('.left_mark').click(function () {
                    $('#second_level_slider').css({'left':'0px','position':'relative','overflow':'hidden'});
                    $('.submenu').css('overflow','hidden');
                });
$('#second_level_slider li').hover(function(){
$(this).parent().css('overflow','');
$('.submenu').css('overflow','');
});
});



/*code for advance search panel static page*/
jQuery(".advance_search_panel_static").live("click",function(){
    jQuery.ajax({
        url:'/admin/static_page/advance_search_view',
        type:'POST',
        data:'advance_search',
        beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
        dataType:'html',
        success:function(advance_search){
        	jQuery("#search_form").html(advance_search);
        }
    });
     jQuery(this).attr("class","advance_search_panel_hide");
     jQuery(this).addClass("advance_active");
});
jQuery(".advance_search_panel_hide").live("click",function(){
    jQuery("#search_form").html(" ");
    jQuery(this).attr("class","advance_search_panel");
    jQuery(this).removeClass("advance_active");
});

/*jQuery(".advance_search_panel_static").live("click",function(){
    jQuery.ajax({
        url:'/admin/static_page/advance_search_view',
        type:'POST',
        beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
        data:'advance_search',
        dataType:'html',
        success:function(advance_search){
        	//jQuery("#search_form").html(advance_search);
        	 jQuery("#search_form").html(advance_search).dialog({
		      model:true,
		      title:'Advance Search',
		      position: "center",
		      draggable: false,
		      width: '600px',
		      closeText: ' ',
		      /*beforeclose: function (){
		                      if(!confirm('Do u want close the dialog?')){
		                           return false;
		                      }        
		                       else {
		                               $('.ui-overlay').removeClass('ui-widget-overlay');
		                               $("body").css("overflow", "auto");
		                       }
		                    },
		                    buttons: {
		       "Submit": function() {
		        kreatioAddEdit.existing_component_form_submit($(this).find('form').attr('action'),$(this).find('form').attr('id'),$(this).find('#component_id').attr('value'))
		       },
		        }*/
		     
        
    
     /*jQuery(this).attr("class","advance_search_panel_hide");
});*/

/*Advance Search for blogs*/

jQuery(".advance_search_panel_blog").live("click",function(){
    jQuery.ajax({
        url:'/admin/blogs/advance_search_view',
        type:'POST',
        beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
        data:'advance_search',
        beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
        dataType:'html',
        success:function(advance_search){
        	jQuery("#search_form").html(advance_search);
        	/* jQuery("#search_form").html(advance_search).dialog({
		      model:true,
		      title:'Advance Search',
		      position: "center",
		      draggable: false,
		      width: '600px',
		      closeText: ' ',
		      /*beforeclose: function (){
		                      if(!confirm('Do u want close the dialog?')){
		                           return false;
		                      }        
		                       else {
		                               $('.ui-overlay').removeClass('ui-widget-overlay');
		                               $("body").css("overflow", "auto");
		                       }
		                    },
		                    buttons: {
		       "Submit": function() {
		        kreatioAddEdit.existing_component_form_submit($(this).find('form').attr('action'),$(this).find('form').attr('id'),$(this).find('#component_id').attr('value'))
		       },
		        }*/
		     
        }
    });
     jQuery(this).attr("class","advance_search_panel_hide");
});

/*$(document).on('click','.advance_search_panel_login',function(){
	 jQuery("#search_form").dialog({
			      model:true,
			      title:'Advance Search',
			      position: "center",
			      draggable: false,
			      width: '600px',
			      closeText: ' ',
			      close:function (event,ui) {
			      	$('.holder li').not('.holder li.bit-input').remove();
			      }
	});
	});

*/
//jQuery(".advance_search_panel_login").live("click",function(){


/*$(document).on('click','.advance_search_panel_login',function(){
$('.ui-dialog').remove();
    jQuery.ajax({
        url:'/admin/articles/advance_search_view?value=login',
        type:'POST',
	beforeSend : function(xhr) {
				xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
	},
        data:'advance_search',
        dataType:'html',
        success:function(advance_search){
        	//jQuery("#search_form").html(advance_search);
        	 jQuery("#search_form").html(advance_search).dialog({
         	 //jQuery("#search_form").dialog({
		      model:true,
		      title:'Advance Search',
		      position: "center",
		      draggable: false,
		      width: '600px',
		      
		     });
		 }
    });
   //	  jQuery(this).attr("class","advance_search_panel_hide");
});

*/


/*jQuery(".advance_search_panel_hide").live("click",function(){
    jQuery("#search_form").html(" ");
    jQuery(this).attr("class","advance_search_panel");
});*/

function select_document(document_name,document_path,document_image_path,document_id)
{
      confirmed = window.confirm("Do you want to make this Document as title document");
if (confirmed)
{
//    var img_pre='<table><tr><td><img src='+document_image_path+' '+' alt= /></td><td>Caption:<br/>'+document_name+'</td></tr></table>'
    var img_pre='<table><tr><td><img src='+document_image_path+' '+' alt= /></td><td></td></tr></table>'
    opener.$('#no_digital_asset').hide();
    opener.$('#digital_asset_change_link').hide();
    opener.$('#Add_dig_asset').hide();
    opener.$('#digital_asset_caption').show();
    opener.$('#digital_asset_change_link123').show();
    opener.$('#prev_document').show();
     if (opener.$('#gen_digital_asset')!=null)
    {
    opener.$('#gen_digital_asset').hide();
   
    }    
    opener.$('#prev_document').html(img_pre); 
    opener.$('#digital_asset_property_digital_asset_id').attr("value",document_id);    
	parent.close();
} 
else 
{
  
}
}







 //End of Document ready






