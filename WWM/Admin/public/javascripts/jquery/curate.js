function highlite(element){

    var firstChild = $(element + "_parent").children("div.inner_block:first")
    $.each(updated_heighlightedSources, function(i){
        if ($(firstChild).hasClass(i) == true) {
            setInterval(function(){
                $(firstChild).toggleClass(updated_heighlightedSources[i])
            }, 1000);
        }
    });
    common_mouseEffect();
}

function delete_update_msg(ele){
    $(ele).closest("p").fadeTo("slow", 0.01, function(){ //fade
        $(this).slideUp("slow", function(){ //slide up
            $(this).remove(); //then remove from the DOM
        });
    });
}

function submit_form(name){

    var form_id = ("#" + name);
    var ul_id = name.replace('_form', '')
    
    before_submit_form('#' + ul_id)
    
    $.ajax({
        type: "POST",
        url: $(form_id).attr("action"),
        data: $(form_id).serialize() + '&component_name=' + name,
        dataType: "text",
        beforeSend: function(){
            $(form_id + " .success_message").remove();
            $(form_id + " div.inner_block").after("<p class='success_message'>Saving...</p>")
        },
        error: function(){
            $(form_id + " p.success_message").html("error in saving<a href='#' onclick='delete_update_msg(this)' class='update_msg_close'></a>");
        },
        
        success: function(update_data){
        
            $(form_id).find(".reset_button").hide();
            $(form_id).find(".save_button").hide();
            
            $(form_id.replace(/_form$/, '')).html(update_data);
            
            reg_close_event(form_id + ' .close')

            $(form_id + " p.success_message").fadeTo("slow", 5, function(){ //fade
                $(this).slideUp("slow", function(){ //slide up
                    $(this).remove(); //then remove from the DOM
                });
            });
            
        }
    });
}

function before_submit_form(ul_id){

    var name;
    
    var count = 0;
    
    $(ul_id + ' li').each(function(){
    
        $(this).find('input').each(function(){
            name = this.name
            name = name.replace(/ranked_list\[\d*\]/, 'ranked_list[' + count + ']')
            this.name = name
        })
        
        count = count + 1
        
    })
}


function reset(id){

    var ul_id = "#" + id;
    var form_id = ul_id + '_form'
    
    $.ajax({
        type: "POST",
        url: "/admin/curate/reload_component",
        data: {
            component_name: id
        },
        dataType: "text",
        beforeSend: function(){
            $(form_id + " .success_message").remove();
            $(form_id + " div.inner_block").after("<p class='success_message'>Reloading...</p>")
        },
        error: function(){
            $(form_id + " p.success_message").html("error in saving<a href='#' onclick='delete_update_msg(this)' class='update_msg_close'></a>");
        },
        
        success: function(update_data){
            $(form_id).find(".reset_button").hide();
            $(form_id).find(".save_button").hide();
            $(ul_id).html(update_data);
            
            $(form_id + " p.success_message").fadeTo("slow", 5, function(){ //fade
                $(this).slideUp("slow", function(){ //slide up
                    $(this).remove(); //then remove from the DOM
                });
            });
            reg_close_event(ul_id + ' .close')
        }
    });
    
}


/* BELLOW METHOD IS USED TO REGISTER THE EVENT OF CLOSE BUTTON */

function reg_close_event(str){
    $(str).click(function(){
    
        $(this).closest("li").addClass("deleted");
        $(this).siblings("input[type='hidden']").remove();
        $(this).closest("form").find(".reset_button").show();
        $(this).closest("form").find(".save_button").show()
    });
    
}


function reg_scarp_close_event(str){
    $(str).click(function(){
        $(this).closest("li").addClass("deleted");
        $(this).siblings("input[type='hidden']").remove();
        scrap_book_save('scrap_delete')
    });
}


/* BELLOW METHOD IS USED TO MAKE THE ELEMENT(S) SORTABLE */
/* make_sortable(["#destination_id_element","#destination_id_element"]) */
function make_sortable(values){
    $(values.toString()).sortable({
        revert: true,
        forcePlaceholderSize: true,
        placeholder: 'place_holder',
        
        update: function(event, ui){
            var container_id = $(this).attr("id");
            $("#" + container_id).closest("form").find(".reset_button").show();
            $("#" + container_id).closest("form").find(".save_button").show()
            var values = [];
            
			// Don't know why the following each has been written. By manoj and bipin
            $("#" + container_id + ">li>input.value").each(function(i, el){
                values[i] = $(el).val();
                return values;
            })
            
            if ($.protify(values, true).uniq().size() != $.protify(values, true).size()) {
                alert("Duplicate Entry Found");
                $(ui.item).effect("shake");
                $(ui.item).effect("explode", {}, 500, function(){
                    $(ui.item).remove(); //then remove from the DOM
                });
            }
            else {
                $(ui.item).effect("bounce");
                $(ui.item).removeClass("class4 class3 class2 class1")
                $(ui.item).addClass("newly_added");
                reg_close_event($(ui.item).children(".close"));
            }
            
        }
    });
    
}

/* Scrap book sortable */

function scrap_book_sortable(){
    $("#scrap_book").sortable({
        revert: true,
        connectWith: '#destination_right_ul ul',                             //=========== New design implementation
//        connectWith: '#destination_right_ul ul, #destination_left_ul ul',    =========== New design implementation		
        forcePlaceholderSize: true,
        placeholder: 'place_holder',
        update: function(event, ui){
            var container_id = $(this).attr("id");
            $("#" + container_id).closest("form").find(".reset_button").show();
            $("#" + container_id).closest("form").find(".save_button").show()
            var values = [];
            $("#" + container_id + ">li>input.value").each(function(i, el){
                values[i] = $(el).val();
                return values;
            })
            
            if ($.protify(values, true).uniq().size() != $.protify(values, true).size()) {
                alert("Duplicate Entry Found");
                $(ui.item).effect("shake");
                $(ui.item).effect("explode", {}, 500, function(){
                    $(ui.item).remove(); //then remove from the DOM
                });
            }
            else {
                $(ui.item).effect("bounce");
                $(ui.item).removeClass("class4 class3 class2 class1")
                $(ui.item).addClass("newly_added");
                reg_close_event($(ui.item).children(".close"));
            }
            
        }
        
    });
    
    
}


/* BELLOW METHOD IS USED TO MAKE THE ELEMENT(S) DRAGGABLE */
/* make_draggable("#source_id_element",["#destination_id_element","#destination_id_element"])   each key and values are ul ids of components */
function make_draggable(key, values){

    $(key + ">li").draggable({
        connectToSortable: values.toString(),
        helper: 'clone',
        drag: function(event, ui){
            $.each(values, function(i){
                var parent_class = $(this + ":first").closest("div.inner_block")
                $.each(heighlightedSources, function(i){
                    if ($(parent_class).hasClass(i) == true) {
                        $(parent_class).addClass(heighlightedSources[i]);
                    }
                });
            })
        },
        stop: function(event, ui){
            $.each(values, function(i){
                var parent_class = $(this + ":first").closest("div.inner_block")
                $.each(heighlightedSources, function(i){
                    if ($(parent_class).hasClass(i) == true) {
                        $(parent_class).removeClass(heighlightedSources[i]);
                    }
                });
            })
        }
    });
}


var regexp = /<("[^"]*"|'[^']*'|[^'">])*>/gi;

// Source components has to be refreshed  in a particular interval. 
// By default it is 30seconds. 
// We can change this seconds by editing the component or while creating the component itself we can in dialog box. 
// Once component is loaded in the browser, in background a script will always running to reload the component.
function request(url, update, values){
    $.post(url, {
        name: update,
        dest: values.toString()
    }, function(data){
        var arrayVal = jQuery.trim($(update + "_parent ul").html().replace(regexp, "")).split("\n")
        arr1 = $.protify(arrayVal, true).grep(/\S+/).collect(function(val){
            return $.trim(val)
        })
        
        var check_expand_collapse = $(update + "_parent").find(".block-expand").hasClass("collapsed");
        $(update + "_parent").html(data);
        
        make_draggable(update, values);
        common_mouseEffect();
        
        $("ul, li").disableSelection();
        
        var arrayVal = jQuery.trim($(update + "_parent ul").html().replace(regexp, "")).split("\n")
        
        arr2 = $.protify(arrayVal, true).grep(/\S+/).collect(function(val){
            return $.trim(val)
        })
        
        $.each($.richArray.diffIndex(arr2, arr1), function(index, indexValue){
            $(update + "_parent ul li:nth-child(" + (indexValue + 1) + ")").addClass("class4")
        });
        
        var countableArray = $.richArray.diffIndex(arr2, arr1);
        
        if (countableArray.length > 0) {
            var title_content = $(update + "_parent .inner_block_title_section p span").html() + " (" + countableArray.length + ")";
            $(update + "_parent .inner_block_title_section p span").html(title_content);
        }
        
        var elem = $(update + "_parent").find(".block-expand");
        
        if (check_expand_collapse) {
            $(update + "_parent").find("div.inner_block_content").hide();
            $(elem).addClass("collapsed");
        }
        
        high(update + "_parent");
		
		$(update).closest('li').find('.block-remove').click(function(){
			common_delete_function( this );
		})

    });
}

function click_submit(){
    $(".submit").click(function(i, ele){
        submit_form($(this).closest("form")[0].id)
    });
}

function edit_dialog_response(dialog_id, data){

    li_id = dialog_id.replace('_dialog_form', '_parent')
    $(dialog_id).dialog("close");
    //$(dialog_id).dialog("destroy");
    $(dialog_id).remove();
    $(li_id).html(data);
    
    
    // ===================== This is common script to reload the component
    
    //dialog_initialization_new(dialog_id, 'Save', 'Cancel');
    
    common_mouseEffect();
    
    $("ul, li").disableSelection();
    
    ul_id = dialog_id.replace('_dialog_form', '') //Get the ul id

    high(li_id);
    
    click_submit()
    
    $('li.remove').remove();
    // ===================== This is common script to reload the component		
}

function tweet_dialog_response(dialog_id, data){

}

function retweet_dialog_response(dialog_id, data){

}

function action_dialog_response(dialog_id, data){

}

function curate_dialog_response(dialog_id, data){

}

function create_component_dialog_response(dialog_id, data){

    var new_component_ref
    
    if ($('.sortable_ul .new_component').length != 0) {
        new_component_ref = '.sortable_ul .new_component'
    }
    else 
        if ($('#destination_left_ul .new_component').length != 0) {
            new_component_ref = '#destination_left_ul .new_component'
        }
        else 
            if ($('#destination_right_ul .new_component').length != 0) {
                new_component_ref = '#destination_right_ul .new_component'
            }
            else {
                alert('Some thing went wrong...')
            }
    //    $(new_component_ref).parent().html(data)
    $(new_component_ref).closest('li').html(data)
    var ul_id = $(new_component_ref + ' ul').attr('id') // get the new component ul id
    $(new_component_ref).closest('li').attr('id', ul_id + '_parent') // set the id of new component as per db data
    $(new_component_ref).closest('li').attr('class', 'content_block_holder')
    dialog_id = '#' + ul_id + '_dialog_form'
    
    replace_class = $(new_component_ref).attr('class').replace('new_component ', '')
    $(new_component_ref).attr('class', replace_class)
    
    
    // ===================== This is common script to reload the the component
    
    var li_id = dialog_id.replace('_dialog_form', '_parent')
    
    common_mouseEffect();
    
    $("ul, li").disableSelection();
    
    ul_id = dialog_id.replace('_dialog_form', '') //Get the ul id
    dialog_initialization_new(dialog_id, 'Save', 'Cancel')
    
    high(li_id);
    $(ul_id).addClass("common_new");
    reg_close_event(ul_id + ' .close')
    click_submit()
    // ===================== This is common script to reload the component
    
    position_class = $(ul_id).closest('div.outer_common_block').parent().attr('class')
    if (position_class == 'content') {
        save_sequence();
    }
    else 

//      ========================== New Design Change ========================
		
        if (position_class == 'contentRight') {
            save_destination_sequence('destination_right_ul')
        }
        else {
            alert('Error in save sequence mehtod call ...');
        }


//        if (position_class == 'contentRight') {
//            save_destination_sequence('destination_right_ul')
//        }
//        else 
//            if (position_class == 'contentLeft') {
//                save_destination_sequence('destination_left_ul')
//            }
//            else {
//                alert('Error in save sequence mehtod call ...');
//            }
    
}

function create_new_twitter(dialog_id, data){
    $('.inner_block li.twitter_account').replaceWith(data);
    //new_twitter = $('#right div.twitter_holder_parent').last()
    common_twitter_logic($(data))
}

function edit_twitter(dialog_id, data){
    var id = dialog_id.replace('_twitter_edit', '')
    var twitter_parent = $(id).closest('.twitter_holder_parent')
    twitter_parent.replaceWith(data)
    common_twitter_logic($(data))
}

function common_twitter_logic(new_twitter){

    var name = new_twitter.find('div.twitter_text').attr('id')
    
    name = '#' + name
    
    dialog_initialization_new(name + '_dialog_form_tweet', 'Save', 'Cancel')
    dialog_initialization_new(name + '_dialog_form_retweet', 'Save', 'Cancel')
    dialog_initialization_new(name + '_twitter_edit', 'Save', 'Cancel')
    
    twitter_edit_link = $(name).closest('.twitter_holder_parent').find('a.twitter_edit')
    
    var source_component = src_comp_ul_ids()
    twitter_droppable(source_component)
    
    twitter_edit_link.click(function(){
        $(name + '_twitter_edit').dialog('open')
    });
    
    twitter_image_text = $(name).closest('.twitter_holder_parent').find('.twitter_account')
    
    twitter_image_text.click(function(){
        $(name + '_dialog_form_tweet').dialog('open');
    });

}


function create_new_article_workflow(dialog_id, data){
    $('.inner_block .default_curate_action').replaceWith(data);
    //	var new_article_workflow = $('#right div.curate_action').last()
    //	var id = new_article_workflow.find( '.curate_action_name' ).attr('id')
    common_article_workflow_logic($(data))
}

function edit_article_workflow(dialog_id, data){
    var id = dialog_id.replace('_article_workflow_edit', '')
    var editor_parent = $(id).closest('.curate_action')
    editor_parent.replaceWith(data)
    common_article_workflow_logic($(data))
}

function common_article_workflow_logic(article_workflow){

    var id = article_workflow.find('.curate_action_name').attr('id')
    id = '#' + id
    
    dialog_initialization_new(id + '_dialog_form', 'Save', 'Cancel')
    dialog_initialization_new(id + '_article_workflow_edit', 'Save', 'Cancel')
    
    var edit_link = $(id).closest('.curate_action').find('.action_edit')
    
    //	var edit_link = $(id).closest('.curate_action_parent').find('.action_edit')
    
    edit_link.click(function(){
        $(id + '_article_workflow_edit').dialog('open')
    });
    
    var source_component = src_comp_ul_ids()
    article_workflow_droppable(source_component)

}

function dialog_initialization_new(dialog_id, save_label, cancel_label){

    var save_label = save_label || 'Save';
    var cancel_label = cancel_label || 'Cancel';
    
    var buttons = {};
    
    var class_name = $(dialog_id).attr('class');
    
    var ul_id = dialog_id.replace('_dialog_form', '');
    
    
//    if (class_name.match(/^(edit|article_workflow_edit|twitter_edit)/) != null) {     
    if (class_name.match(/^(article_workflow_edit|twitter_edit)/) != null) {

        buttons['Remove'] = function(){
        
            var action;
            var data;
            
  //          if (class_name.match(/^edit/)) {
  //              action = 'deactivate_component';
  //              data = {
  //                  'component_name': ul_id.replace(/^#/, '')
  //              }
  //          }
  //          else 

            if (class_name.match(/^article_workflow_edit/)) {
				action = 'article_workflow_remove';
				var div_id = ul_id.replace('_article_workflow_edit', '')
				data = {
					'component_name': $(div_id).html().trim()
				}
			}
			else {
				if (class_name.match(/^twitter_edit/)) {
					action = 'twitter_account_remove';
					var div_id = ul_id.replace('_twitter_edit', '')
					data = {
						'component_name': $(div_id).html().trim()
					}
				}
				else {
					alert('Error in remove...')
				}
			}
            
            if (confirm('Do you want to remove?')) {
                $.ajax({
                    type: "POST",
                    url: "/admin/curate/" + action,
                    dataType: "text",
                    data: data,
                    
                    beforeSend: function(){
                        $(dialog_id).find("p.validateTips .val_error_message").remove();
                        $(dialog_id).find("p.validateTips").append("<p class='loading' style='color:red;font-weight:normal;font-size:12px;'>loading...</p>");
                    },
                    error: function(){
                        $(dialog_id).find("p.loading").remove();
                        $(dialog_id).find("p.validateTips").append("<p class='loading' style='color:red;font-weight:normal;font-size:12px;'>Some thing went wrong...</p>");
                    },
                    success: function(data){
                        if (data.match(/^VALERROR/)) {
                            $(dialog_id).find("p.loading").remove();
                            $(dialog_id).find("p.validateTips").append(data.replace(/^VALERROR/, ''));
                        }
                        else {
                        
                            if (class_name.match(/^article_workflow_edit/)) {
								var div_id = ul_id.replace('_article_workflow_edit', '')
								$(div_id).closest(".curate_action").remove();
							}
							else {
								if (class_name.match(/^twitter_edit/)) {
									var div_id = ul_id.replace('_twitter_edit', '')
									$(div_id).closest(".twitter_holder_parent").remove();
								}
								else {
									alert('Error in remove...')
								}
							}
                            $(dialog_id).dialog('close');
                            $(dialog_id).remove();
                        }
                    }
                });
            }
            
        }

    }
	
    buttons[save_label] = function(){
    
        $.ajax({
            type: "POST",
            url: $(this).find('form')[0].action,
            data: $(this).find('form').serialize(),
            dataType: "text",
            beforeSend: function(){
                $(dialog_id).find("p.validateTips .val_error_message").remove();
                $(dialog_id).find("p.validateTips").append("<p class='loading' style='color:red;font-weight:normal;font-size:12px;'>loading...</p>");
            },
            error: function(){
                $(dialog_id).find("p.loading").remove();
                $(dialog_id).find("p.validateTips").append("<p class='loading' style='color:red;font-weight:normal;font-size:12px;'>Some thing went wrong...</p>");
            },
            success: function(data){
            
                data = $.trim(data);
                
                if (data.match(/^VALERROR/)) {
                
                    $(dialog_id).find("p.loading").remove();
                    $(dialog_id).find("p.validateTips").append(data.replace(/^VALERROR/, ''));
                }
                else {
                    if (class_name.match(/^edit/) != null) {
                        edit_dialog_response(dialog_id, data);
                        
                    }
                    else 
                        if (class_name.match(/^action/) != null) {
                            action_dialog_response(dialog_id, data)
                        }
                        else 
                            if (class_name.match(/^curate/) != null) {
                                curate_dialog_response(dialog_id, data)
                            }
                            else 
                                if (class_name.match(/^tweet/) != null) {
                                    tweet_dialog_response(dialog_id, data)
                                }
                                else 
                                    if (class_name.match(/^retweet/) != null) {
                                        retweet_dialog_response(dialog_id, data)
                                    }
                                    else 
                                        if (class_name.match(/^(new_article|new_twitter|new_rss|new_ranked_list)/) != null) {
                                            create_component_dialog_response(dialog_id, data)
                                        }
                                        else 
                                            if (class_name.match(/^twitter_new/) != null) {
                                                create_new_twitter(dialog_id, data)
                                            }
                                            else 
                                                if (class_name.match(/^article_workflow_new/) != null) {
                                                    create_new_article_workflow(dialog_id, data)
                                                }
                                                else 
                                                    if (class_name.match(/^twitter_edit/) != null) {
                                                        edit_twitter(dialog_id, data)
                                                    }
                                                    else 
                                                        if (class_name.match(/^article_workflow_edit/) != null) {
                                                            edit_article_workflow(dialog_id, data)
                                                        }
                                                        else {
                                                            alert('Error...');
                                                        }
                    
                    //					var title = $(ul_id).closest('.inner_block').find('p span').html()
                    //					var component_type = $(ul_id).closest('.outer_common_block').parent().attr('class')
                    //					dialog_ids = get_all_component_edit_dialog_id(component_type)
                    //					add_assign_component( dialog_ids, title )
                    
                    $(dialog_id).find("p.loading").remove();
                    flush_prefilling(dialog_id)
                    $(dialog_id).dialog('close');
                }
            }
        });
        
    }
    
    buttons[cancel_label] = function(){
    
        $(dialog_id).find("p.loading").remove();
        $(dialog_id).dialog('close');
        $('.source_column .new_component').closest('li').remove();
        $('.contentRight .new_component').closest('li').remove();

//        $('.contentLeft .new_component').closest('li').remove();    //      ========================== New Design Change ========================

        $('#right').find(".default_twitter").remove();
        $('#right').find(".default_curate_action").remove();
        $(this).dialog('close');
        // $('.source_column .new_component,.contentLeft .new_component,.contentRight .new_component').remove();
    }
    
    $(dialog_id).dialog({
        autoOpen: false,
        height: 'auto',
        width: 'auto',
        modal: true,
        buttons: buttons,
        close: function(){
            $(dialog_id).find("p.loading").remove();
            //$('.source_column .new_component').remove();
        }
    });
}


function get_all_component_edit_dialog_id(component_type){

    var array1 = [];
    var array = []
    
    if (component_type == 'content') {
    
        array = []
        
        $('#destination_right_ul ul, #destination_left_ul ul').each(function(i, ele){
            dialog_id = '#' + $(ele).attr('id') + '_dialog_form'
            array = array.concat(dialog_id)
        })
        array = $.protify(array).without('#scrap_book_dialog_form')
        array = array.concat(['#new_ranked_list_dialog_form'])
    }
    else {
    
        $(".source_column td ul.sortable_ul").each(function(index, value){
            $(value).children("li.content_block_holder").each(function(){
                dialog_id = '#' + $(this).attr("id").replace("_parent", "") + '_dialog_form'
                array1.push(dialog_id)
            });
            array = array.concat(array1)
            array1 = []
        });
        array = array.concat(['#new_article_dialog_form', '#new_twitter_dialog_form', '#new_rss_dialog_form'])
    }
    return (array)
}

function remove_assign_component(dialog_ids, name){

    $(dialog_ids).each(function(i, id){
        $(id).find('select option').each(function(){
            ($(this).html() == name) ? $(this).remove() : ''
        });
    });
    
}

function add_assign_component(dialog_ids, name){

    $(dialog_ids).each(function(i, id){
        $(id).find('select').html()
    });
    
}

function flush_prefilling(dialog_id){

    input_tags = $(dialog_id).find('input.password_style, input.text_style, textarea')
    input_tags.each(function(){
        this.value = ($(this).attr('id') == 'component_interval') ? 30 : ''
    })
    
    select_tags = $(dialog_id).find('select')
    select_tags.each(function(){
        $(this.options).each(function(){
            this.selected = false
        })
    })
    
}

/* Mouse hovering styles */
function common_mouseEffect(){
    $(".content .inner_block_content>ul>li").mousedown(function(){
        var wd = $(this).width();
        $(this).css("width", wd + "px");
    }).mouseup(function(){
        $(this).removeAttr("style")
    }).mouseout(function(){
        $(this).removeAttr("style")
    });

    $(".inner_block_content>ul>li").mouseover(function(){
        $(this).addClass("li_over")
    }).mouseout(function(){
        $(this).removeClass("li_over")
    });
}

	function high(arg){
	    $(arg).stopTime()
	    $(arg).everyTime(20000, arg, function(){
	        $(arg + " li.class1").removeClass('class1')
	        $(arg + " li.class2").addClass('class1').removeClass('class2')
	        $(arg + " li.class3").addClass('class2').removeClass('class3')
	        $(arg + " li.class4").addClass('class3').removeClass('class4')
	        if ($(arg + " li.class1," + arg + " li.class2," + arg + " li.class3," + arg + " li.class4").size() == 0) {
	            $(arg + " .inner_block_title_section p span").text($(arg + " .inner_block_title_section p span").text().replace(/\(\d+\)$/, ""))
	        }
	    });
	}


function save_destination_sequence(position){

    var component_list = []
    
    $('#' + position + ' ul').each(function(i, ele){
        component_list.push($(ele).attr('id'))
    })
    component_list = $.protify(component_list).without('scrap_book')
    //	hash = ( position == 'destination_left_ul' ) ? { '0': component_list } : { '1': component_list }
    
    component_list = (position == 'destination_left_ul') ? [component_list] : [[], component_list]
    
    reorder_ajax_call(component_list)
}

function save_sequence(){
    var array = [];
    var array1 = [];
    
    $(".source_column td ul.sortable_ul").each(function(index, value){
        $(value).children("li").each(function(){
            array1.push($(this).attr("id").replace("_parent", ""))
        });
        array.push(array1)
        array1 = []
    });
    
    reorder_ajax_call(array)
}


function reorder_ajax_call(components){
    $.ajax({
        type: "POST",
        url: "/admin/curate/save_sequence",
        data: {
            "component_sequences": components
        },
        dataType: "text"
    });
}

/*
 $(function(){
 $(".default_dest").hide();
 $(".default_source").show();
 
 $(".show_sources,.show_destinations").click(function(event){
 event.preventDefault();
 if ($(this).attr("class") == "show_destinations") {
 $(".default_source").hide();
 $(".default_dest").show();
 }
 else {
 $(".default_dest").hide();
 $(".default_source").show();
 }
 
 });
 
 });
 */
$(function(){
    $("#tab ul.tab_holder li:last-child a").css("border", "none");
});

$(function(){
    $("#tabs").tabs();
})

$(function(){
    $(".ui-icon-closethick").click(function(event){
        $('.source_column .new_component').closest('li').remove();
        $('.contentRight .new_component').closest('li').remove();

//        $('.contentLeft .new_component').closest('li').remove();    //      ========================== New Design Change ========================

        $('#right').find(".default_twitter").remove();
        $('#right').find(".default_curate_action").remove();
        // $('.source_column .new_component,.contentLeft .new_component,.contentRight .new_component').remove();
    });
});

$(document).keydown(function(ev){
    if (ev.which == 27) {
        $('.source_column .new_component').closest('li').remove();
        $('.contentRight .new_component').closest('li').remove();

//        $('.contentLeft .new_component').closest('li').remove();   //      ========================== New Design Change ========================

        $('#right').find(".default_twitter").remove();
        $('#right').find(".default_curate_action").remove();
    };
    });



function src_comp_ul_ids(){
    var comp_ids = []
    $('.source_column .inner_block_content ul').each(function(i, e){
        comp_ids.push('#' + e.id + ' li')
    })
    return comp_ids.toString() + ', .common_new li'
}


function twitter_droppable(source_components){

    $("div.twitter_account").droppable({
        accept: source_components + ",#scrap_book li",
        hoverClass: 'drophover',
        activeClass: 'ui-state-highlight',
        drop: function(ev, ui){
        
            if ($(ev.originalTarget).parent().attr('class') == 'default_dest') {
            
                $('#twitter_new').dialog('open');
            }
            else {
            
                var dialog_form_div = $(this).find('div')[0].id;
                dragged_element = ev.originalTarget.offsetParent; // dragged element - li
                li_text = $(dragged_element).find('span').html(); // dragged element - text - avail in span
                input_link = $(dragged_element).find('.link')[0]; // dragged element - link - avail in hidden input
                url = input_link ? input_link.value : '';

				// Here we are shortening the url and then updating that in 

		        class_name = $(dragged_element).attr('class');
		        if (class_name.match(/^twitter/) == null) {

					$.ajax({
					    type: "POST",
					    url: "/admin/curate/short_url",
					    data: {
					        url: url
					    },
					    dataType: "text",
					    error: function(){
					        alert('something went wrong...')
					    },
					    success: function(url){
				            $('#' + dialog_form_div + '_dialog_form_tweet').find('textarea').val(li_text + ' ' + url);
				            $('#' + dialog_form_div + '_dialog_form_tweet').dialog('open');
					    }
					});

		        }
		        else {
		            var twitter_id = $(dragged_element).find('.twitter_id').attr('value');
		            $('#' + dialog_form_div + '_dialog_form_retweet').find('.twitter_id').attr('value', twitter_id);
		            $('#' + dialog_form_div + '_dialog_form_retweet').dialog('open');
		        }
		        $(this).children("li").remove();

            }
        }
    });
    
}

function article_workflow_droppable(source_components){

    $("div.curate_action").droppable({
        accept: source_components + ",#scrap_book li",
        hoverClass: 'drophover',
        activeClass: 'ui-state-highlight',
        drop: function(ev, ui){
            var dialog_form_div = $(this).find('div')[0].id
            dragged_element = ev.originalTarget.offsetParent // dragged element - li
            li_text = $(dragged_element).find('span').html() // dragged element - text - avail in span
            input_link = $(dragged_element).find('#external_long_url')[0] // dragged element - link - avail in hidden input
            url = input_link ? input_link.value : ''
            class_name = $(dragged_element).attr('class')
            copy_paste_dragged_element_to_dialog(dragged_element, dialog_form_div)
            before_submit_form('#' + dialog_form_div + '_display_none')
            if (class_name.match(/^twitter/) == null) {
                $('#' + dialog_form_div + '_dialog_form').find('#article_content').val(li_text + ' ' + url)
                $('#' + dialog_form_div + '_dialog_form').dialog('open')
            }
            else {
                $('#' + dialog_form_div + '_dialog_form').find('#article_content').val(li_text)
                $('#' + dialog_form_div + '_dialog_form').dialog('open')
            }
        }
    });
    
}

function copy_paste_dragged_element_to_dialog(dragged_element, dialog_form_div){
    $('#' + dialog_form_div + '_display_none li').html(dragged_element.innerHTML)
}

function get_params(dragged_element){
    custom_form = "<form action='/admin/curate/request_for_approval'>" + dragged_element.innerHTML + "</form>"
    $(custom_form).serialize()
}

function scrap_book_save(option){

    before_submit_form("#scrap_book")
    
    $.ajax({
        type: "POST",
        url: "/admin/curate/save_scrap_book",
        dataType: "text",
        data: $('#scrap_book_form').serialize(),
        error: function(){
            alert('Some thing went wrong...');
        },
        success: function(data){
        
            if (option == 'scrap_delete') 
                $('#scrap_book').find('.deleted').remove()
            else 
                $('#scrap_book').find('li').removeClass("newly_added")
            
        }
    });
}

$(function(){
    $(".tab_holder li a").click(function(){
		
        if ($(this).attr("title") == "Source Components") {
            var source_text = 'To add source components, please drag and drop these to the source panel in center'
            $("#available_component_message").text(source_text);
        }
        else {
            var dest_text = 'To add new destination components, please drag and drop these to the left and right destination panels'
            $("#available_component_message").text(dest_text);
        }
		
    });
});


function common_delete(){
	
	$('.block-remove').each(function(i, ele){
		$(ele).click( function(){  
			common_delete_function( ele );
		} )
	})

}

function common_delete_function( ele ){

		var action;
		var data;
		
		dialog_id = $(ele).closest('li').attr('id').replace('parent', 'dialog_form')
		
		dialog_id = '#' + dialog_id
	
		class_name = $(dialog_id).attr('class');
		
		ul_id = dialog_id.replace('_dialog_form', '');
		
		action = 'deactivate_component';
		data = {
			'component_name': ul_id.replace(/^#/, '')
		}
		
		if (confirm('Do you want to remove?')) {
			$.ajax({
				type: "POST",
				url: "/admin/curate/" + action,
				dataType: "text",
				data: data,
				
				beforeSend: function(){
					$(dialog_id).find("p.validateTips .val_error_message").remove();
					$(dialog_id).find("p.validateTips").append("<p class='loading' style='color:red;font-weight:normal;font-size:12px;'>loading...</p>");
				},
				error: function(){
					$(dialog_id).find("p.loading").remove();
					$(dialog_id).find("p.validateTips").append("<p class='loading' style='color:red;font-weight:normal;font-size:12px;'>Some thing went wrong...</p>");
				},
				success: function(data){
					if (data.match(/^VALERROR/)) {
						$(dialog_id).find("p.loading").remove();
						$(dialog_id).find("p.validateTips").append(data.replace(/^VALERROR/, ''));
					}
					else {
					
						if (class_name.match(/^edit/)) {
						
							var title = $(ul_id).closest('.inner_block').find('p span').html()
							var component_type = $(ul_id).closest('.outer_common_block').parent().attr('class')
							
							$(dialog_id.replace('_dialog_form', '_parent')).remove()
							dialog_ids = get_all_component_edit_dialog_id(component_type)
							remove_assign_component(dialog_ids, title)
							
							$(dialog_id).dialog('close');
							$(dialog_id).remove();
						}
						else {
							alert('Error in remove...')
						}
						
					}
				}
			});
		}	

}

$(".block-edit").live('click', function(){

    var parent_li_id = $(this).closest('li')[0].id //.find('div.dialog_form')[0].id
    var new_dialog_id = '#' + parent_li_id.replace(/_parent$/, '_dialog_form');
    dialog_initialization_new(new_dialog_id, 'Save', 'Cancel');
    $(new_dialog_id).dialog('open');

});

$('.block-expand,.collapsed').live('click', function(event){ // Collapse & Expand

    event.preventDefault();
    $(this).closest(".inner_block").find("div.inner_block_content").slideToggle();
    $(this).toggleClass("collapsed");
    var title = $(this).hasClass("collapsed") ? "Maximize Component" : "Minimize Component"
    $(this).attr("title", title)
    
});

$('.inner_block_title_section').live('mouseover mouseout', function(event){

    if (event.type == 'mouseover') 
        $(this).find('a.com_edit').addClass("com_edit_hover");
    else 
        $(this).find('a.com_edit').removeClass("com_edit_hover");
    
});

$('.inner_box .curate_action.action').live('mouseover mouseout', function(event){

    if (event.type == 'mouseover') 
        $(this).find('.action_edit').addClass("com_edit_hover");
    else 
        $(this).find('.action_edit').removeClass("com_edit_hover");
    
});

$('.inner_box .twitter_holder_parent').live('mouseover mouseout', function(event){

    if (event.type == 'mouseover') 
        $(this).find('.twitter_edit').addClass("com_edit_hover");
    else 
        $(this).find('.twitter_edit').removeClass("com_edit_hover");
    
});