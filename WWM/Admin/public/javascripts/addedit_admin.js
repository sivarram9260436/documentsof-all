//component -- > ajaxsave_tree.html.erb
var already_exists = function () {
	jQuery("#component_name").attr("value","");	
}

//component -- > component_new.html.erb 
jQuery(document).ready(function($) {
	//check the component name already exists or not
		jQuery("#component_name").blur(function() {
			var text_value = jQuery(this).val();
			jQuery.ajax({
				type : "POST",
				url : "component_name?name=" + text_value,
				datatype : "html",
				beforeSend : function() {
					jQuery(".com_validate").html("checking...");
				},
				success : function(data) {
					jQuery(".com_validate").html(data);
					var text_already = "Name already exists";
					var text_get = jQuery.trim(jQuery(".com_validate").text());
					if(text_already == text_get) {
						jQuery("#component_name").attr("value", "");
					}
				}
			});
		});
});


$(function(){
	$(document).on('blur','#component_name',function () {
		$.ajax({
			 type:'POST',
			 url:"component_name?name="+$(this).val(),
			 dataType:'html',
			 success: function (data) {
			 	jQuery(".com_validate").html(data);
			 	if( "Name already exists" == jQuery.trim(jQuery(".com_validate").text()) ){
			 		jQuery("#component_name").attr("value", "");
			 	}
			 }
		});
	});
});

function validateForm() {
		var x = document.forms["my_form"]["component[name]"].value//component name
		if(x == null || x == "") {
			alert("Component field is Required");
			return false;
		}
		var x = document.forms["my_form"]["component[title]"].value//component title
		if(x == null || x == "") {
			alert("Component Title field is Required");
			return false;
		}
		var x = document.forms["my_form"]["componentproperty[xhtml_id]"].value//component Xhtml
		if(x == null || x == "") {
			alert("Component Xhtml field is Required");
			return false;
		}

		var x = document.forms["my_form"]["componentproperty[empty_message]"].value//componenet empty message
		if(x == null || x == "") {
			alert("Component Empty Message field is Required");
			return false;
		}
		var x = document.forms["my_form"]["componentproperty[error_message]"].value//component error message
		if(x == null || x == "") {
			alert("Component Error Message field is Required");
			return false;
		}
}


jQuery('.data_string_preview').click(function(event) {
		var a = jQuery(this).parents('form').serialize();
		window.open("/admin/components/preview?" + a, "mywindow", "menubar=1,resizable=1,width=800,height=600");
		event.preventDefault();
});

jQuery("#component_entity_type").live("change", function() {
		var entry_type = jQuery(this).val();
        var id = jQuery("#component_id").val();
		jQuery.ajax({
			type : 'POST',
			dataType : 'html',
			url : '/admin/components/entity_type?entry_value='+entry_type+'&id='+id+'&hide=',
			success : function(data) {
				jQuery("#component_type").html(data);
			}
		});
});

jQuery(function () {
	component_new_record();
});

function component_new_record () {
	var list_type =jQuery("#component_entity_type").val();
    var id = jQuery("#component_id").val();
 	jQuery.ajax({
                    type:'POST',
                    dataType:'html',
                    url:'/admin/components/entity_type?entry_value='+list_type+'&id='+id,
                    success:function(update_data){
                                 jQuery("#component_type").html(update_data);
          			}
    });
}

//component -- > component_search_new.html.erb and 

function drag_drop_listSearch(){
       jQuery("#list_latest,#listTaken").sortable({
         connectWith:'#listTaken'
       });
}

jQuery(function(){
	
	drag_drop_listSearch();
	
 jQuery("#collection_search").click(function(){
   var widget = jQuery("#widget").val();
   var id=jQuery("#component_id").val();
   var name = jQuery('#component_name').val();
   var params ='&component[name]=' + name + '&component[id]=' + id + '&widget[widget]=' + widget;
      jQuery.ajax({
        type:'GET',
        url:'/admin/components/component_search_collection',
        data:params,
        success: function(data){
        	//jQuery(".content_table #list").html(data);
             jQuery("#article_list").html(data);
                drag_drop_listSearch();
        }
    });

 });


//This code for collection search for site and portal
	jQuery("div.source_search").click(function(){
	        var button_id = jQuery(this).attr("id");
	        var site_id = jQuery(this).find("a").data("siteid");
	        if(button_id=='all_source_site'){
	                var pars = "site_id=" +site_id+"&status=site";
	                jQuery.ajax({
	                        type:'POST',
	                        url:'/admin/ranked_list/get_source',
	                        data:pars,
	                        dataType:'html',
	                        success:function(update_portal){
	                                jQuery("#test").html(update_portal);
	                        }
	                });
	        }
	        else if(button_id=='all_source_portal'){
	                var pars = "site_id=" +site_id+"&status=portal";
	                jQuery.ajax({
	                        type:'POST',
	                        url:'/admin/ranked_list/get_source',
	                        data:pars,
	                        dataType:'html',
	                        success:function(update_portal){
	                                jQuery("#test").html(update_portal);
	                        }
	                });
	        }
	});

	jQuery("#main_search").click(function(){
        var section_id = jQuery('#search_data_section_id option:selected').val();
        var title = jQuery('#search_data_title').val();
        var sources = jQuery('select[name="search_data[source_ids][]"] option');
        var categories = jQuery('select[name="search_data[category_ids][]"] option');
        var site_type = jQuery('#search_data_article_type').val();
        var primary_medium = jQuery('select[name="search_data[primary_medium][]"] option');
        var source_ids=[];
        jQuery(sources).each(function(){
                source_ids.push(jQuery(this).val());
        });
        //source_ids=source_ids.not(-1);
        var category_ids=[];
        jQuery(categories).each(function(){
                category_ids.push(jQuery(this).val());
        });
        //category_ids=category_ids.not(-1)
        var primary_mediums=[];
        jQuery(primary_medium).each(function(){
                primary_mediums.push(jQuery(this).val());
        });
        //primary_mediums=primary_mediums.not(-1)
        primary_mediums = [primary_mediums];
        var params = "search_data[section_id]=" + section_id + "&search_data[title]=" + title + "&flag=feature" + "&search_data[source_ids]=" + source_ids+ "&search_data[category_ids]=" + category_ids  + "&article_type=" + site_type + "&search_data[primary_medium]=" + primary_mediums;
        jQuery.ajax({
          type:'GET',
          url:'/admin/articles/advance_search',
          data:params,
          beforeSend:function(){
	      	    jQuery("#load_indicatior").show();
	      },
          success: function(search_data){
          	   jQuery("#load_indicatior").hide();
               jQuery("#article_list").html(search_data);
               drag_drop_listSearch();
          }
        });
	});

});

//component --> component_search.html.erb 
jQuery(function () {
	jQuery("#component_search").click(function(){
		var id = jQuery("#component_id").val();
		var name = jQuery("#component_name").val();
		jQuery.ajax({
			url:'/admin/components/component_search',
			data:'&component[name]=' + name + '&component[id]=' + id,
			dataType:'html',
			success:function(search_data){
				jQuery("#component").html(search_data);
				funcRegister();
			}
		});
	});
});	

//component --> entity_type.html.erb
jQuery(function () {
	jQuery(".data_list_entry").click(function() {
        var id = jQuery("#component_id").val();
		var entry_type = jQuery(this).val();
		jQuery.ajax({
			type : 'POST',
			data : "entry_type=" + entry_type,
			url : '/admin/components/action?entry_type='+entry_type+'&id='+id,
			success : function(update_data) {
				jQuery("#entry_type").html(update_data);
			}
		});
	});
});

//component-->new_widget.html.erb and edit_widget.html.erb
jQuery('.needAjax div.pagination a').live('click', function() {  
            var url = jQuery(this).attr("href");  
            var update_div = jQuery(this).parents('.update_pagination_block').attr("id")  ;
            jQuery("#"+update_div).load(url);
            return false;  
}); 


//component--> component_tree_view.html.erb
jQuery(document).ready( function() {
		jQuery("#save_tree").click( function() {
			var comp_posi='';
			var tab_posi='';
			jQuery("#mytree [rel='placeholder']").each( function() {
				var sub_div_id = jQuery("#mytree #"+jQuery(this).attr('id')). attr('id');
				var value = [];
				var tab_value=[];
				var sub_div_id_num = sub_div_id.split('_');
				jQuery("#mytree #"+sub_div_id+" .menuchildnavlist").children().each( function() {
					var inn_div=jQuery(this).attr('id');
					// alert(inn_div);
					jQuery("#mytree #"+sub_div_id+" .menuchildnavlist_sub").children().each( function() {

						var a=jQuery(this).attr('id');
						// alert(a);
						tab_value.push(a);
					});
					tab_posi = tab_posi + '<input type="hidden" name='+inn_div+' id='+inn_div+' value='+tab_value.join(',')+' >'

					value.push(inn_div);
				});
				var o_name = "container_"+sub_div_id_num[1];
				comp_posi = comp_posi + '<input type="hidden" name='+o_name+' id='+o_name+' value='+value.join(',')+' >' ;

				jQuery(".test_field").attr("value",value);
			});
			jQuery('.hiddenfields').html(comp_posi);
			jQuery('.tabfields').html(tab_posi);
		});
		
		jQuery("#page_id").change(function(){
				var page_id = jQuery("#page_id").val();
				jQuery.ajax({
					type : 'GET',
					url : '/admin/components/select_page',
					data : "page_id="+page_id,
					dataType : 'html',
					success : function(data) {
						jQuery(".component_tree").html(data);
					}
				});
		})

});

jQuery(document).ready( function($) {
		$("#demo2").jstree({
			"dnd": {
				"drop_finish": function() {
					alert("DROP");
				},
				"drag_finish": function() {
					alert("DRAG OK");
				}
			},
			"types": {
				"max_depth": -2,
				"max_children": -2,
				"valid_children": ["left_menu"],
				"types": {
					"left_menu": {
						"valid_children": ["tab","submenu", "placeholder"],
						"max_depth": -3,
						"hover_node": false,
						"start_drag": false,
						"move_node": false,
						"delete_node": false,
						"remove": false,
						"select_node": function() {
							return false;
						}
					},
					"placeholder": {
						"valid_children": ["submenu","tab"]
					},
					"submenu": {
						"valid_children": ["submenu","tab"]
					},
					"tab": {
						"valid_children": "none"
					}
				}
			},
			"plugins": ["themes", "html_data", "dnd", "ui", "types", "crrm", "json_data"]
		});

		var data_string = "";
		function parseTree(ul) {
			var tags = [];
			ul.children("li").each( function() {
				var subtree = $(this).children("ul");
				var data = {};
				data['id'] = $(this).attr("id")
				data['parent_id'] = $(this).parent().closest("li").attr("id")
				data['previous_id'] = $(this).prev("li").attr("id")
				p_id = $(this).attr("id");
				parent_id = ($(this).parent().closest("li").attr("id") != undefined) ? $(this).parent().closest("li").attr("id") : "";
				previous_id = ($(this).prev("li").attr("id") != undefined) ? $(this).prev("li").attr("id") : "";
				data_string += "data[MenuItems][" + p_id + "][id]=" + $(this).attr("id");
				data_string += "&data[MenuItems][" + p_id + "][parent_id]=" + parent_id;
				data_string += "&data[MenuItems][" + p_id + "][previous_id]=" + previous_id;
				data_string += "&";
				if (subtree.size() > 0) {
					tags.push(parseTree(subtree));
				} else {
					tags.push(data);
				}
			});
			return data_string;
		}
		$("#demo2").jstree("get_json", -1);
});

//component -- >container_form.html.erb
jQuery(document).ready( function($) {
		jQuery("#container_name").blur( function() {
			var text_value = jQuery(this).val();
			jQuery.ajax({
				type : "post",
				url : "/admin/components/container_name?name=" + text_value,
				datatype : "html",
				beforeSend : function() {
					jQuery(".com_validate").html("checking...");
				},
				success : function(data) {
					//alert("test1");
					jQuery(".com_validate").html(data);
					var text_already = "Name already exists";
					var t = jQuery(".com_validate").text();
					var text_get = jQuery.trim(t);
					if(text_already == text_get) {
						jQuery("#container_name").attr("value", "");
					}
				}
			});
		});
});

//component -- > widget_form.html.erb
$(document).ready(function() {
	jQuery('#new_latest,#listTaken').sortable({connectWith:'#listTaken'});
	jQuery('#edit_latest,#listTaken').sortable({connectWith:'#listTaken'});
	jQuery('#new_latest,#listTaken').sortable({
			connectWith:'#listTaken'
	});
	jQuery('#edit_latest,#listTaken').sortable({
			connectWith:'#listTaken'
	});
});

	

