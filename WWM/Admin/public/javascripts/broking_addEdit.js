//Broking.html.erb
//Dynamically Generate for Edit,Delete & Collepse Html Tags
jQuery(function(){
var a = [];
      jQuery(".rearrange_div").each(function(index) {
      var chk = jQuery(this).attr('id').split("_");
     var id= chk[1];
       a.push(id);
    
     });
     var b = [];
     a.forEach(function(value) {
            if ( b.indexOf(value) == -1) {
                b.push(value);
            }
        });

         jQuery.each(b, function(k, v){
           jQuery("#component_"+v+" .content_title").prepend("<p id=expand_"+v+" class='expand_on'></p>");
           jQuery("#component_"+v+" .content_title").append("<div id=edit_button_"+v+" class='edit_but' title='Component Edit'><form method='post' action='/category/broker?title=component+edit' class='button-to'><div><input class='submit_style' type='submit' value=' ' /></div></form></div><p class='itemDelete' title='close'></p>");
         
           
 });
});
function load(){
	
}
jQuery(function() {
		jQuery( ".comp_tabs" ).tabs();
});
//code for add pallete (Expand and collepse top panel) 
jQuery(document).ready(function () {
	jQuery(".add_palatte, .palatte_close").click(function(){
		jQuery(".palette").slideToggle(1000);
	});
});

//Drag and Drop image from Top to Container
jQuery(document).ready(function() {
	jQuery( ".pal_img" ).draggable({connectToSortable: ".align_left,.align_right",helper: "clone",revert: "invalid",
		stop: function(event, ui) {
				var ind = ui.helper.attr('id');
				var container = jQuery(".two_block_section .pal_img").parent().attr("id");
				//alert(container);
				var new_id = ui.helper.attr('id');
				//alert(new_id);
                var b = new_id.slice(1);
                //alert(b);
				var s = new Array();
				jQuery("#"+container+ " .inner_content_block").each(function()
				{
						if(jQuery(this).attr('id'))
						{
							s.push(jQuery(this).attr('id'));
						}		
						
				});
				s.push(b)
				alert(s);
					jQuery("#main_div .pal_img .pal_img1").attr("src", "/images/palete_images/Component_loader1.gif").attr('id', 'img_load');
						
						jQuery.ajax({
						  type: "POST",
						  url: "/admin/components/get_component/?id="+new_id+"&container_id="+container+"&components="+s+b+"",
						  dataType: "text",
						  success: function(con){
						  				var t = jQuery("#main_div .pal_img").parent().html(con);
						  				//we can call this by function also
						  				var d = [];
      jQuery("#"+container+ " .rearrange_div").each(function(index) {
      var chk = jQuery(this).attr('id').split("_");
     var id= chk[1];
       d.push(id);
    
     });
    
     var e = [];
     d.forEach(function(value) {
            if ( e.indexOf(value) == -1) {
                e.push(value);
            }
        });

         jQuery.each(e, function(k, v){
         	alert(v);
           jQuery("#"+container+" #component_"+v+" .content_title").prepend("<p id=expand_"+v+" class='expand_on'></p>");
           jQuery("#"+container+" #component_"+v+" .content_title").append("<div id=edit_button_"+v+" class='edit_but' title='Component Edit'><form method='post' action='/category/broker?title=component+edit' class='button-to'><div><input class='submit_style' type='submit' value=' ' /></div></form></div><p class='itemDelete' title='close'></p>");
         
           
 });
						  			//code ends	
						  			}
						});
					} 
			}); 
});


//To Drag and Drop for Empty components
jQuery(document).ready(function() {
	jQuery( ".pal_img_empty" ).draggable({connectToSortable: ".align_left,.align_right",helper: "clone",revert: "invalid",
		start:function(event, ui){
						jQuery(".header_advertisement").hide();
					 },
		stop: function(event, ui) {
				var ind = ui.helper.attr('id');
				var container = jQuery(".two_block_section .pal_img_empty").parent().attr("id");
				var new_id = ui.helper.attr('id');
				var s = new Array();
				jQuery("#"+container+ " .inner_content_block").each(function()
				{
						if(jQuery(this).attr('id'))
						{
							s.push(jQuery(this).attr('id'));
						}		
				});
				jQuery("#con_id").val(container);
				jQuery("#com_ids").val(s);
					jQuery("#main_div .pal_img_empty .pal_img_empty1").attr("src", "/images/palete_images/Component_loader1.gif").attr('id', 'img_load1');
							jQuery(function() {
								jQuery( ".dialog:ui-dialog" ).dialog( "destroy" );
								jQuery( "#emp_dialog" ).dialog({
									height: 140,
									modal: true,
									
									show: "slide",
									hide: "fold",
									overlay : {
										        background: '#000',
										        opacity: '0.1'
									          }
									
									 }).dialog("open");
							});
		            alert(s);
					jQuery.ajax({
						  type: "POST",
						  url: "/admin/components/get_component/?id="+new_id+"&container_id="+container+"&components="+s+"",
						  dataType: "text",
						  success: function(con){
						  				var t = jQuery("#main_div .pal_img_empty").parent().html(con);
									}
						});
							//To hide and show top advertisment
							jQuery(".ui-dialog-titlebar-close,#emp_submit").click(function(){
		   							jQuery(".header_advertisement").show();
		   							jQuery("#main_div img_load").hide();
							});
			}
	}); 
});



//code for Tabs
jQuery(document).ready(function() {
		jQuery( "#emp_tabs" ).tabs();
});
//To hide pagination block in Components
jQuery(document).ready(function (){
	jQuery(".pagination_block").hide();
});

//To hide over data in component123
jQuery(document).ready(function (){
	jQuery("#main_div #component_div123 .common_inner_content .float_fix").slice(5,30).hide(); 
});

//to edit image to change article title
jQuery(document).ready(function(){
	jQuery(".list_block ul li, .img_desc,.category_block").mouseover(function(){
    		jQuery(this).find(".art_edit_img").css("display","block");
   	});
   	jQuery(".list_block, .img_desc,.category_block").mouseout(function(){
    		jQuery(this).find(".art_edit_img").css("display","none");
	});
});

//Validation for Empty form
function validateForm()
{
var x=document.forms["my_form"]["component[name]"].value //component name
		if (x==null || x=="")
		  {
		  alert("Component field is Required");
		  return false;
		  }
var x=document.forms["my_form"]["component[title]"].value //component title
		if (x==null || x=="")
		  {
		  alert("Component Title field is Required");
		  return false;
		  }
var x=document.forms["my_form"]["componentproperty[data_string]"].value //componenet datastring
		if (x==null || x=="")
		  {
		  alert("Component DataString field is Required");
		  return false;
		  }
/*var x=document.forms["my_form"]["componentproperty[partial]"].value   //componenet partial
		if (x==null || x=="")
		  {
		  alert("Component Partial field is Required");
		  return false;
		  }*/
var x=document.forms["my_form"]["componentproperty[xhtml_id]"].value  //component Xhtml
if (x==null || x=="")
		  {
		  alert("Component Xhtml field is Required");
		  return false;
		  }

var x=document.forms["my_form"]["componentproperty[empty_message]"].value   //componenet empty message
		if (x==null || x=="")
		  {
		  alert("Component Empty Message field is Required");
		  return false;
		  }
var x=document.forms["my_form"]["componentproperty[error_message]"].value   //component error message
		if (x==null || x=="")
		  {
		  alert("Component Error Message field is Required");
		  return false;
		  }
}

//code for press ESC key to hide loader and Dialog window
jQuery(document).keyup(function(e) {
        if (e.keyCode == 27) 
        { 
                jQuery(".header_advertisement").show();
                jQuery("#main_div .pal_img_empty1").remove();
               // jQuery("#main_div .img_load").remove();

        }  
});

//code for dialog close button
jQuery(function(){
		jQuery(".ui-dialog-titlebar-close").click(function(){
				jQuery(".header_advertisement").show();
				jQuery("#main_div .pal_img_empty1").remove();
				//jQuery("#main_div .img_load").remove();
		});
});
//Category common richlist page.html.erb
//code for drag and drop component from top pallete to main container(create new component)
jQuery(function() {
                  jQuery( ".small_section,.large_section,#palette_div" ).sortable({ cursor: "move",
                                connectWith: ".small_section,.large_section,.col1",
                      		handle:"",forcePlaceholderSize: true}).sortable("option", "revert", 150);
                  jQuery( ".small_section,.large_section,.col1" ).disableSelection();
});

//code for delete component
jQuery('.itemDelete').live('click', function() {
  		jQuery(this).closest('.inner_content_block,.right_common_block').remove();
});

jQuery(function(){
   	jQuery(".common_inner_content .blog_left").hide();
	jQuery(".common_inner_content .blog_right").css("margin-right","90px");
});

//code for expand and collepse component
jQuery(document).ready(function() {
     jQuery(".expand_on").click(function(){
	   jQuery(this).toggleClass('expand_off');
	   jQuery(this).toggleClass('expand_on');
	   jQuery(this).parent().next().slideToggle('slow');
     });
});

//code for Expand and collepse all componenets
jQuery(function() {
   jQuery('.expand_all').click(function(){
		   jQuery(".expand_on").parent().next().show(1000);
		   jQuery(".expand_on").toggleClass('expand_off')
    });
   jQuery('.collapse_all').click(function(){
		   jQuery(".expand_on").parent().next().hide(1000);
		   jQuery(".expand_on").toggleClass('expand_off');
   });

});


//code for component position save when click save button
jQuery(function(){
   jQuery(".submit_style").click(function(){
	   var comp_posi='';
	   jQuery("#main_div .sub_div").each(function(){
	       var sub_div_id = jQuery("#main_div #"+jQuery(this).attr('id')). attr('id');
	       var value = []
	       jQuery("#main_div #"+jQuery(this).attr('id')+" .rearrange_div").each(function(){
	          value.push(jQuery(this).attr('id'));                   
	       });
	         var o_name = "component_container_"+sub_div_id;
	         comp_posi = comp_posi + '<input type="hidden" name='+o_name+' id='+o_name+' value='+value.join(',')+' >'            
	   });
	   jQuery('.hiddenfields').html(comp_posi);
	  // alert(comp_posi);
     });
});


/*add class for container-width size*/
jQuery(function(){
   jQuery("#1").addClass("small_section");
});
jQuery(function(){
   jQuery("#3").addClass("small_section_right");
});

/* code for Expand and Collapse button*/
jQuery(function(){
	jQuery(".col_but p.exp_col").css({"color":"#492424","font-size":"1.5em","font-weight":"bold","margin-right":"50px","float":"right","padding-top":"2px"});
});


//code for open dialog box when click component edit button

/*    jQuery(".submit_style").click(function(){
        s  = jQuery(this).parent("div").parent().parent().attr("id");
        var chk = s.split("_");
        var id= chk[2];
   	   jQuery(function() {
		    jQuery( "#edit_dialog_box_"+id ).dialog({
		        autoOpen: false,
		        show: "slide",
		        hide: "explode",
		        modal: true,
		        overlay : {
		                    background: '#000',
		                    opacity: '0.8'
		                  }
		    }).dialog( "option", "resizable", false );

		    jQuery("#edit_button_"+id ).click(function() {
		        jQuery(".header_advertisement").hide();
		        jQuery("#edit_dialog_box_"+id).dialog( "open" );
		        return false;
		    });       
	    });
   
    });
}); */
//code for to open Dialog box
jQuery(function() {
    jQuery(".edit_but .submit_style").click(function(){
    	alert('hi');
        s  = jQuery(this).parent("div").parent().parent().attr("id");
        alert(s);
        var chk = s.split("_");
        var id= chk[2];
        alert(id);
        /*Radio Button Check whether Global or None*/ //start
        if (jQuery('#edit_dialog_box_'+id+' .comp_tabs .ui-tabs-panel #opt_glo').is(':checked')) {
				alert('This is global component,Do you want to edit');
   		 }//end
   		 
   	   jQuery(function() {
		    jQuery( "#edit_dialog_box_"+id ).dialog({
		        autoOpen: false,
		        show: "slide",
		        hide: "explode",
		        modal: true,
		        overlay : {
		                    background: '#000',
		                    opacity: '0.8'
		                  }
		    }).dialog( "option", "resizable", false );
		   jQuery("#edit_button_"+id ).click(function() {
		        jQuery(".header_advertisement").hide();
		        jQuery("#edit_dialog_box_"+id).dialog( "open" );
		        return false;
		    });       
	    });
   
    });
}); 

//code for dialog save button
jQuery(function(){
	jQuery(".componenet_submit_button").click(function(){
		s  = jQuery(this).attr("id");
		var chk = s.split("_");
		var id= chk[1];
		alert(id);
                    //var c =jQuery("#component_title").val();//(this).find("#component_title").val();
                    //var k =jQuery("#componentproperty_data_string").val(); //(this).find("#componentproperty_data_string").val();
                  
      		jQuery.ajax({
                            type:"POST",
                            dataType: 'html',
                            url:"/admin/components/component_update/"+id,
                            data: jQuery("#form_component_"+id).serialize(),
                            success: function(result){    
                            	jQuery("#edit_dialog_box_"+id).dialog( "close" );
                            	  jQuery("#component_"+id).html(result);
						        //alert("#edit_dialog_box_"+id);
							 	//jQuery(".ui-dialog").dialog( "close" );
							 	var  c= jQuery("#component_"+id+" .content_title").prepend("<p id=expand_"+id+" class='expand_on'></p>");
           						var  d= jQuery("#component_"+id+" .content_title").append("<div id=edit_button_"+id+" class='edit_but' title='Component Edit'><form method='post' action='/category/broker?title=component+edit' class='button-to'><div><input class='submit_style' type='submit' value=' ' /></div></form></div><p class='itemDelete' title='close'></p>");
							 	
						     }
			});
	});
	
});   

//ui-dialog-box
jQuery( function() {
	jQuery(".ui-dialog").css("width","558px");
});


jQuery( function() {
		jQuery("#component_511 .edit_but").css("margin-top","-9px");
});

//code for edit ranked list button(To open new window)
function rank_list(url) {
			var win_options = "toolbar=no,addressbars=yes,scrollbars=yes,width=1050px,height=700,resizable=yes ";
			window.open(url, "terms", win_options).focus();
			}

function fragment_edit(url) {
			var win_options = "toolbar=no,addressbars=yes,scrollbars=yes,width=1050px,height=700,resizable=yes ";
			window.open(url, "terms", win_options).focus();
			}

function article_preview25(url){
    var win_options = "toolbar=no,addressbars=yes,scrollbars=yes,width=1050px,height=700,resizable=yes ";
    parent_url= window.location.href
    window.open(url, "terms", win_options,parent_url).focus();
	
}

function article_preview22(){
	//self.close();
	location.href = 'javascript:history.go(-1)'
}


function get_city_by_country(value)
{

if (value =="object")
{
jQuery("#object_partial").css("display","block");
jQuery("#partial").css("display","none");
jQuery("#collection_partial").css("display","none");
jQuery("#object_partial #componentpropert_partial").change(function(){
var str1 = jQuery("#object_partial #componentpropert_partial option:selected").val();
jQuery("#pass_val").attr("value",str1);

});
}
else
{
if (value =="collection")
{

jQuery("#collection_partial").css("display","block");
jQuery("#partial").css("display","none");
jQuery("#object_partial").css("display","none");
jQuery("#collection_partial #componentpropert_partial").change(function(){
        var str = jQuery("#collection_partial #componentpropert_partial option:selected").val();

        jQuery("#pass_val").attr("value",str);
});
}
}
}


