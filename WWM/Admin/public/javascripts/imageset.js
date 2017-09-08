/*Code for Toolbox color change*/
jQuery(function() {
    jQuery(".image_toolbox span").mouseover(function() {
        jQuery(this).css("color", "red");
    });
    jQuery(".image_toolbox span").mouseout(function() {
        jQuery(this).css("color", "#000");
    });
});

/*Take Image from click to Crop div*/
// $(function() {
    // $(".crop").live("click", function() {
        // // //  jQuery('html, body').animate({ scrollTop: jQuery('#crop_image').offset().top }, 'slow');
        // // var get_image_name = jQuery(this).parent().parent().children("img").attr("src").split("/");
        // // var image_id = get_image_name[1];
        // // var set_image_id = get_image_name[1].split(".");
        // // var set_image_id_gal = set_image_id[0];
        // // var image_src = "images/" + image_id;
        // // jQuery(".image_crop_style").attr("src", image_src);
        // // jQuery(".image_crop_style").attr("id", set_image_id_gal);
        // var img_id_arr = $(this).parent().attr("id").split("_");
        // var image_id = img_id_arr[img_id_arr.length - 1];
        // $.ajax({
            // type : 'GET',
            // url : "/admin/image_details/crop_imageset/" + image_id,
            // dataType : "html",
            // success : function(data) {
                // $("#overlay_div").html(data)
                // $("#overlay_div").dialog({
                    // modal : true,
                    // title : "Image Crop"
                // });
            // }
        // });
    // });
// });




$(function() {
    $(".img-crop").live("click", function() {
        // //  jQuery('html, body').animate({ scrollTop: jQuery('#crop_image').offset().top }, 'slow');
        // var get_image_name = jQuery(this).parent().parent().children("img").attr("src").split("/");
        // var image_id = get_image_name[1];
        // var set_image_id = get_image_name[1].split(".");
        // var set_image_id_gal = set_image_id[0];
        // var image_src = "images/" + image_id;
        // jQuery(".image_crop_style").attr("src", image_src);
        // jQuery(".image_crop_style").attr("id", set_image_id_gal);
        var img_id_arr = $(this).parents(".image_details_list").attr('id').split("_");
        var image_id = img_id_arr[img_id_arr.length - 1];
        $.ajax({
            type : 'GET',
            url : "/admin/image_details/crop_imageset/" + image_id,
            dataType : "html",
            success : function(data) {
                $("#overlay_div").html(data)
                $("#overlay_div").dialog({
                    modal : true,
                    title : "Image Crop"
                });
            }
        });
    });
});


/*Take Image from click to edit (Show preview details)*/
/*jQuery(function(){
 jQuery(".edit").click(function(){
 var get_image_name = jQuery(this).parent().parent().find("img").attr("src").split("/");
 var image_id = get_image_name[1];
 var set_image_id = get_image_name[1].split(".");
 var set_image_id_gal = set_image_id[0];
 var get_title_name = jQuery(this).parent().parent().children("img").attr("title");
 jQuery(".img_id").val(set_image_id_gal);
 jQuery(".image_name").val(get_title_name);

 jQuery("#preview_image").dialog({
 modal: true,
 title:'Edit Image Deatils'
 });
 });
 });*/

/*jQuery(document).ready(function(){
 jQuery('#slides').slides({
 preload: false,
 generateNextPrev: true
 });
 });*/

jQuery(function() {
    jQuery('.image_crop_style').Jcrop();
});

jQuery(function() {
    jQuery(".save_crop").click(function() {
        window.location.reload()
    });
});

/*change image div border style when mouse hover */
jQuery(function() {
    jQuery(".image_content_sub div").mouseover(function() {
        jQuery(this).css("border", "1.5px solid red");
    });
    jQuery(".image_content_sub div").mouseout(function() {
        jQuery(this).css("border", "1px solid #DAA520");
    });
});

jQuery(function() {
    jQuery(".image_content_sub div.option_crop").mouseover(function() {
        jQuery(this).css("border", "0px solid #fff");
    });
    jQuery(".image_content_sub div.option_crop").mouseout(function() {
        jQuery(this).css("border", "0px solid #fff");
    });
});

//code for new crop window
function crop_popup(id) {
    // alert(id);
    var t = id;
    var width = 1150;
    var height = 900;
    var url = "imageset_crop.html?" + t;
    var left = parseInt((screen.availWidth / 2) - (width / 2));
    var top = parseInt((screen.availHeight / 2) - (height / 2));
    // var windowFeatures = "width=" + width + ",height=" + height + ",status,resizable,left=" + left + ",top=" + top + "screenX=" + left + ",screenY=" + top;
    var windowFeatures = "width=" + width + ",height=" + height + ",status,resizable";
    window.open(url, "mywindow", windowFeatures);
}

//code for new resize window
function resize_popup(id) {
    var t = id;
    var width = 1150;
    var height = 600;
    var url = "imageset_resize.html?" + t;
    var left = parseInt((screen.availWidth / 2) - (width / 2));
    var top = parseInt((screen.availHeight / 2) - (height / 2));
    // var windowFeatures = "width=" + width + ",height=" + height + ",status,resizable,left=" + left + ",top=" + top + "screenX=" + left + ",screenY=" + top;
    var windowFeatures = "width=" + width + ",height=" + height + ",status,resizable";
    window.open(url, "mywindow", windowFeatures);
}

jQuery(function() {
    jQuery(".advan_search").mouseover(function() {
        jQuery(this).css("color", "red");
    });
    jQuery(".advan_search").mouseout(function() {
        jQuery(this).css("color", "");
    });
});

jQuery(function() {
    jQuery(".advan_search").click(function() {
        jQuery(".advanced_search-content").slideDown("slow");
    });
    jQuery(".advan_search_close").click(function() {
        jQuery(".advanced_search-content").slideUp("slow");
    });
});

//code for crop tooltip div open and close
jQuery(function() {
    jQuery(".crop_opt").click(function() {
        var crop_div_id = jQuery(this).parent().parent().next(".option_crop").attr("id");
        jQuery("#" + crop_div_id).slideDown("fast");
    });
    jQuery(".close_crop_div").click(function() {
        var crop_div_id = jQuery(this).parent().parent().attr("id");
        jQuery("#" + crop_div_id).slideUp("fast");
        jQuery("#" + crop_div_id).find("input[name='crop_resize']").attr('checked', false);
    });
});

/*jQuery(function(){
Tipped.create('.function-example', function(element) {
// the return value of this function sets a string as content
return jQuery(element).data('related-id');
}, {
inline: true ,
hook: 'rightmiddle'// turns the string into the ID of the element to pull into the tooltip
});
});*/

//code for dynamically generate margin-left for crop option div(tooltip)
jQuery(function() {
    var left = 0;
    jQuery(".image_content_sub .option_crop").each(function() {
        var m_left = left + "px";
        jQuery(this).css("left", m_left);
        left = left + 160;
    });
});

/* js added by selva start for imageset redesign */


 $(function() {
 $(".img-edit").live("click", function() {
	var img_id_arr = $(this).parents(".image_details_list").attr('id').split("_");
	var image_id = img_id_arr[img_id_arr.length - 1];
	//var params = "?from=image_redesign";
	$.ajax({
	type : 'GET',
	url : "/admin/image_details/edit_imageset/" + image_id,
	dataType : "html",
	success : function(data) {
	$("#overlay_div").html(data).dialog({
	modal : true,
	title : 'Edit Image Details'
	});
      }
   });
 });
});


// $(function() {
    // $(".edit").live("click", function() {
        // var img_id_arr = $(this).parent().attr("id").split("_");
        // var image_id = img_id_arr[img_id_arr.length - 1];
        // //var params = "?from=image_redesign";
        // $.ajax({
            // type : 'GET',
            // url : "/admin/image_details/edit_imageset/" + image_id,
            // dataType : "html",
            // success : function(data) {
                // $("#overlay_div").html(data).dialog({
                    // modal : true,
                    // title : 'Edit Image Details'
                // });
            // }
        // });
    // });
// });

/*Take Image from click to preview (Show preview image)*/

$(function() {
    $(".img-search").live("click", function() {
        var img_id_arr = $(this).parents(".image_details_list").attr('id').split("_");
        var image_id = img_id_arr[img_id_arr.length - 1];
        $.ajax({
            type : 'GET',
            url : "/admin/image_details/show_preview_imageset/" + image_id,
            dataType : "html",
            success : function(data) {
                $("#overlay_div").html(data)
                $("#overlay_div").dialog({
                    modal : true,
                    title : 'Preview Image',
		    open:function(event,ui){
			$('.ui-dialog').css("top","140px");
		    }
                });
            }
        });
    });
});






// $(function() {
    // $(".preview").live("click", function() {
        // var img_id_arr = $(this).parent().attr("id").split("_");
        // var image_id = img_id_arr[img_id_arr.length - 1];
        // $.ajax({
            // type : 'GET',
            // url : "/admin/image_details/show_preview_imageset/" + image_id,
            // dataType : "html",
            // success : function(data) {
                // $("#overlay_div").html(data)
                // $("#overlay_div").dialog({
                    // modal : true,
                    // title : 'Preview Image',
		    // open:function(event,ui){
			// $('.ui-dialog').css("top","140px");
		    // }
                // });
            // }
        // });
    // });
// });

$(function() {
    $("#next").live("click", function() {
        var next_page = $(".active_page #next_page").val();
        if($("#image_list").find("#page_" + next_page) .length > 0){
            $(".image_pagination").each(function(){
                $(this).removeClass("active_page");
                $(this).hide();
            });
            $("#page_" + next_page).addClass("active_page");
            $("#page_" + next_page).show();
        }else{
            var search_page = $(".active_page #search_page").val();
            var popup = $(".active_page #popup").val();
            var type = $(".active_page #type").val();
            if (search_page == "true") {
                var licence_type = $(".active_page #licence_type").val();
                var to = $(".active_page #to").val();
                var site_id = $(".active_page #site_id").val();
                //var order_by = $(".active_page #order_by").val();
                var created_by = $(".active_page #created_by").val();
                var name = $(".active_page #name").val();
                var from = $(".active_page #from").val();
                params = "image_detail_search[licence_type]=" + licence_type + "&image_detail_search[to]=" + to + "&image_detail_search[site_id]=" + site_id + "&image_detail_search[created_by]=" + created_by + "&image_detail_search[name]=" + name + "&image_detail_search[from]=" + from + "&page=" + next_page;
                url = "/admin/image_details/imagset_search?" + params + "&popup=" + popup + "&type=" + type;
            } else {
                url = "/admin/image_details/imagset_search?page=" + next_page + "&popup=" + popup + "&type=" + type;
            }
            $.ajax({
                type : 'GET',
                url : url,
                beforeSend : function(xhr) {
                    xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
                },
                dataType : "html",
                success : function(data) {
                    var append_string = "<div class='image_pagination active_page' id='page_"+ next_page +"'></div>"
                    $(".image_pagination").each(function(){
                        $(this).removeClass("active_page");
                        $(this).hide();
                    });
                    $('#image_list').append(append_string);
                    $("#image_list #page_" + next_page).html(data);
                }
            });
        }
    });
});

$(function() {
    $("#previous").live("click", function() {
        var previous_page = $(".active_page #previous_page").val();
        if($("#image_list").find("#page_" + previous_page) .length > 0){
            $(".image_pagination").each(function(){
                $(this).removeClass("active_page");
                $(this).hide();
            });
            $("#page_" + previous_page).addClass("active_page");
            $("#page_" + previous_page).show();
        }else{
            var search_page = $(".active_page #search_page").val();
            var popup = $(".active_page #popup").val();
            var type = $(".active_page #type").val();
            if (search_page == "true") {
                var licence_type = $(".active_page #licence_type").val();
                var to = $(".active_page #to").val();
                var site_id = $(".active_page #site_id").val();
                //var order_by = $(".active_page #order_by").val();
                var created_by = $(".active_page #created_by").val();
                var name = $(".active_page #name").val();
                var from = $(".active_page #from").val();
                params = "image_detail_search[licence_type]=" + licence_type + "&image_detail_search[to]=" + to + "&image_detail_search[site_id]=" + site_id + "&image_detail_search[created_by]=" + created_by + "&image_detail_search[name]=" + name + "&image_detail_search[from]=" + from + "&page=" + previous_page;
                url = "/admin/image_details/imagset_search?" + params + "&popup=" + popup + "&type=" + type;
            } else {
                url = "/admin/image_details/imagset_search?page=" + previous_page + "&popup=" + popup + "&type=" + type;
            }
            $.ajax({
                type : 'GET',
                url : url,
                beforeSend : function(xhr) {
                    xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
                },
                dataType : "html",
                success : function(data) {
                    var append_string = "<div class='image_pagination active_page' id='page_"+ previous_page +"'></div>"
                    $(".image_pagination").each(function(){
                        $(this).removeClass("active_page");
                        $(this).hide();
                    });
                    $('#image_list').append(append_string);
                    $("#image_list #page_" + previous_page).html(data);
                }
            });
        }
    });
});

$(function() {
    $("#image_upload").live("click", function() {
        $("#upload_multiple_image_overlay").dialog({
            modal : true,
            width : "auto",
            height : "auto",
            title : 'Multiple Image Upload'
        });
    });
});

$(function() {
    $("#image_crop_form_submit").click(function() {
        var id = $('#id').val();
        var params = $("#croped_image").serialize();
        $.ajax({
            type : 'POST',
            url : "/admin/image_details/cropped_imageset_value/" + id + "?" + params,
            beforeSend : function(xhr) {
                xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
            },
            dataType : "html",
            success : function(data) {
                $("#image_list").html(data);
            }
        });
        return false;
    });
});

function insert_to_article(image_path, thumbnail_path, image_id, title, caption){
    confirmed = window.confirm("Do you want to make this image as title image");
    if(confirmed){
        var visitorName = " ";
        var myOldString = caption
        cap = myOldString.replace(/\+/g, visitorName);
        capt = unescape(cap)
        if($('#no_image', window.parent.document).length > 0){

            var img_pre="<table class='title_image_table'><tr><td><img src="+thumbnail_path+" "+" alt= /></td><td></td></tr></table>"
            if(arguments.length > 5 && arguments[5] == "author_logo"){
                $('#no_image_company_logo', window.parent.document).hide();
                $('#change_link_company_logo', window.parent.document).hide();
                $('#gen_image_company_logo', window.parent.document).hide();
                $('#change_link123_company_logo', window.parent.document).show();
                $('#company_logo_image_id', window.parent.document).val(image_id);
                $('#prev_company_logo', window.parent.document).html(img_pre);
                $('#prev_company_logo', window.parent.document).show();
            }else{
                $('#no_image', window.parent.document).hide();
                $('#change_link', window.parent.document).hide();
                $('#change_link_add_image', window.parent.document).hide();
                $('#imageset_caption', window.parent.document).show();
                $('#change_link123', window.parent.document).show();
/*                if($('#set_preference', window.parent.document) != null) {
                	$('#set_preference', window.parent.document).show();
            	}*/
            	$('#prev', window.parent.document).show();
            	if($('#gen_image', window.parent.document) != null){
                	$('#gen_image', window.parent.document).hide();
            	}
                $('#prev', window.parent.document).html(img_pre);
                $('#image_property_image_id', window.parent.document).val(image_id);
 $('#image_property_caption', window.parent.document).val(caption);
            }
            parent.$.fn.colorbox.close();
        }else{
            
            var img_pre='<table><tr><td><img src='+image_path+' '+' alt= /></td></tr></table>'
            $('#image_property_width', window.parent.document).val('80');
            $('#image_property_height', window.parent.document).val('80');
            $('#image_property_image_id', window.parent.document).val(image_id);  
            $('#add_image_to_gallery', window.parent.document).html(img_pre);
            parent.$.fn.colorbox.close();
        }
        
    }else{
        
    }
}

$(function() {
    $("#advanced_image_search").live("click", function() {
        $("#image_advance_search").dialog({
            modal : true,
            width : "auto",
            height : "auto",
            title : 'Advance Image Search'
        });
    });
});

$(function() {
    $(".image_search").live("click", function() {
    //    var licence_type = $("#image_detail_search_licence_type").val();
        var to = $("#image_detail_search_to_id").val();
        var site_id = $("#image_detail_search_site_id").val();
        var created_by = $("#image_detail_search_created_by").val();
        var name = $("#image_detail_search_name").val();
        var from = $("#image_detail_search_from_id").val();
        var params =  "image_detail_search[site_id]=" + site_id +  "&image_detail_search[name]=" + name ;
       // var params = "image_detail_search[to]=" + to + "&image_detail_search[site_id]=" + site_id + "&image_detail_search[created_by]=" + created_by + "&image_detail_search[name]=" + name + "&image_detail_search[from]=" + from;
        var popup = $(".active_page #popup").val();
        var type = $(".active_page #type").val();
        var url = "/admin/image_details/imagset_search?" + params + "&popup=" + popup + "&type=" + type;
        $.ajax({
            type : 'GET',
            url : url,
            beforeSend : function(xhr) {
            	$("#loading").show();
                xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
            },
            dataType : "html",
            success : function(data) {
            	 $("#image_advance_search").dialog('destroy');
                var append_string = "<div class='image_pagination active_page' id='page_1'></div>"
                $(".image_pagination").each(function(){
                	$("#loading").hide();
                    $(this).remove();
                });
                $('#image_list').append(append_string);
                $("#image_list #page_1").html(data);
               
            }
        });
    });
});


/*added by gurudath for thumblain image*/

function remove_image_as_thumbnail() {
        $('#prev_thumbnail_image', window.parent.document).hide();
        $('.thumbimageid', window.parent.document).attr("value", "");
        $('#exist_image', window.parent.document).hide();
        $('#img_block', window.parent.document).hide();
        $('#image_options', window.parent.document).hide();
        $('#thumb_img_block', window.parent.document).show();
        $('#change_link_add_image1', window.parent.document).show();
        $(".browse_comp", window.parent.document).show();
        parent.$.fn.colorbox.close();
}
function insert_to_article_as_thumbnail(image_path, thumbnail_path, image_id, title, caption) {
        confirmed = window.confirm("Do you want to make this image as tumbNail image");
        $('#thumbnail_image', window.parent.document).attr("value", image_id);
        var img_pre = "<table class='title_image_table'><tr><td><img src=" + thumbnail_path + " /></td><tr></table>"
        $('.newthumbnailimage', window.parent.document).hide();
        $('#exist_image', window.parent.document).hide();
        $('#change_link_add_image1', window.parent.document).hide();
        $('#prev_thumbnail_image', window.parent.document).html(img_pre);
        $('#prev_thumbnail_image', window.parent.document).show();
        $('#image_options', window.parent.document).show();
        $('#thumb_img_block', window.parent.document).attr("value", "");
        $('#img_block', window.parent.document).hide();
        $('.browse_comp', window.parent.document).hide();
       // $('#change_link_add_image2', window.parent.document).hide();
        parent.$.fn.colorbox.close();
}


/*function remove_image_as_thumbnail() {
        $('#prev_thumbnail_image', window.parent.document).hide();
        $('.thumbimageid', window.parent.document).attr("value", "");
        $('#exist_image', window.parent.document).hide();
        $('#img_block', window.parent.document).hide();
        $('#image_options', window.parent.document).hide();
        $('#thumb_img_block', window.parent.document).show();
        parent.$.fn.colorbox.close();
}
*/

/*nction remove_image_as_thumbnail() {
        $('#prev_thumbnail_image', window.parent.document).hide();
        $('.thumbimageid', window.parent.document).attr("value", "");
        $('#exist_image', window.parent.document).hide();
        $('#img_block', window.parent.document).hide();
        $('#image_options', window.parent.document).hide();
        $('#thumb_img_block', window.parent.document).show();
$('#change_link_add_image1', window.parent.document).show();
        parent.$.fn.colorbox.close();
}*/

/*function insert_to_article_as_thumbnail(image_path, thumbnail_path, image_id, title, caption) {
        confirmed = window.confirm("Do you want to make this image as ThumbNail image");
        $('#thumbnail_image', window.parent.document).attr("value", image_id);
        var img_pre = "<table class='title_image_table'><tr><td><img src=" + thumbnail_path + " /></td><tr></table>"
        $('.newthumbnailimage', window.parent.document).hide();
        $('#exist_image', window.parent.document).hide();
        $('#prev_thumbnail_image', window.parent.document).html(img_pre);
        $('#prev_thumbnail_image', window.parent.document).show();
        $('#image_options', window.parent.document).show();
        $('#thumb_img_block', window.parent.document).attr("value", "");
        $('#img_block', window.parent.document).hide();
        parent.$.fn.colorbox.close();
}*/

/*function insert_to_article_as_thumbnail(image_path, thumbnail_path, image_id, title, caption) {
        confirmed = window.confirm("Do you want to make this image as tumbNail image");
        $('#thumbnail_image', window.parent.document).attr("value", image_id);
        var img_pre = "<table class='title_image_table'><tr><td><img src=" + thumbnail_path + " /></td><tr></table>"
        $('.newthumbnailimage', window.parent.document).hide();
        $('#exist_image', window.parent.document).hide();
        $('#change_link_add_image', window.parent.document).hide();
        $('#prev_thumbnail_image', window.parent.document).html(img_pre);
        $('#prev_thumbnail_image', window.parent.document).show();
        $('#image_options', window.parent.document).show();
        $('#thumb_img_block', window.parent.document).attr("value", "");
        $('#img_block', window.parent.document).hide();
        $('#change_link_add_image1', window.parent.document).hide();
       // $('#change_link_add_image2', window.parent.document).hide();
        parent.$.fn.colorbox.close();
}*/

/*function insert_to_article_as_thumbnail(image_path, thumbnail_path, image_id, title, caption) {
        confirmed = window.confirm("Do you want to make this image as tumbNail image");
        $('#thumbnail_image', window.parent.document).attr("value", image_id);
        var img_pre = "<table class='title_image_table'><tr><td><img src=" + thumbnail_path + " /></td><tr></table>"
        $('.newthumbnailimage', window.parent.document).hide();
        $('#exist_image', window.parent.document).hide();
        $('#change_link_add_image1', window.parent.document).hide();
        $('#prev_thumbnail_image', window.parent.document).html(img_pre);
        $('#prev_thumbnail_image', window.parent.document).show();
        $('#image_options', window.parent.document).show();
        $('#thumb_img_block', window.parent.document).attr("value", "");
        $('#img_block', window.parent.document).hide();
        $('.browse_comp', window.parent.document).hide();
       // $('#change_link_add_image2', window.parent.document).hide();
        parent.$.fn.colorbox.close();
}*/


/*end of thumblain image*/



/* js added by selva end for imageset redesign */

