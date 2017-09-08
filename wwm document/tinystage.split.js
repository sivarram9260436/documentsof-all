jQuery(document).ready(function() {
    jQuery("#add_article_tiny").click(function() {
            start();
        $('.hide_control').unbind('click');
            $('.tiny_contaner .hide_control').on('click',function(){
                var parent_tiny_id = $(this).data('tiny_parentid');
                var hide_ele = $('#'+parent_tiny_id+' .tiny_subcontaner');
                if(hide_ele.is(':visible')){
                    $(this).text('Expand')
                    hide_ele.slideUp();
                }
                else{
                    $(this).text('Collapse')
                    hide_ele.slideDown();
                }
            });
    });
});

jQuery(document).ready(function() {
        //start();
});
/*
 function start(){
 mceRemoveControl();
 var idholder=[];
 jQuery(".tinyclass").each(function(){
 Array.max = function( array ){ return Math.max.apply( Math, array );};
 var len=jQuery(this).attr("id").length;
 var index=jQuery(this).attr("id").indexOf("_");
 idholder.push(jQuery(this).attr("id").slice(index+1,len));
 });
 var maxId = (Number(Array.max(idholder))+1);
 var tinyid="tinyid_"+(Number(Array.max(idholder))+1);
 jQuery("#tinymceholder").wrapInner('<div class="tiny_contaner" id="parent_'+tinyid+'"></div>');
 jQuery("#parent_"+tinyid).wrapInner('<fieldset style="float:left;width:455px"></fieldset>');
 jQuery("#parent_"+tinyid+" fieldset").append('<legend></legend>');
 jQuery("#parent_"+tinyid+" fieldset legend").html("Page"+maxId);
 jQuery("#parent_"+tinyid+" fieldset").wrapInner('<div class="tiny_subcontaner" style="float:none;"></div>');
 jQuery("#parent_"+tinyid+" .tiny_subcontaner").append('<div class="title_container"></div>');
 jQuery("#parent_"+tinyid+" .tiny_subcontaner .title_container").append('<label class="tiny_title_label"></label>').html("Page Title * : ");
 jQuery("#parent_"+tinyid+" .tiny_subcontaner .title_container").append('<input class="tinytitle_input" type="text" name="article[pages_content][][title]" value="Page '+maxId+'" />');
 jQuery("#parent_"+tinyid+" .tiny_subcontaner").append('<div class="word_counter_holder" style="margin-top:6px;"></div>');
 jQuery("#parent_"+tinyid+" .tiny_subcontaner .word_counter_holder").append('<label class="tiny_word_label"></label>').html("word count : ");
 jQuery("#parent_"+tinyid+" .tiny_subcontaner .word_counter_holder").append('<input class="tiny_word_input" id="word_'+tinyid+'" readonly="readonly" />');
 jQuery("#parent_"+tinyid+" .tiny_subcontaner").append('<textarea name="article[pages_content][][content]" id="'+tinyid+'" class="tinyclass" rows="35" cols="30" style="width:100%;"></textarea>');
 jQuery("#parent_"+tinyid+" .tiny_subcontaner").append('<div class="inactive_tiny_holder" style="display:none;padding:5px;">');
 jQuery("#parent_"+tinyid+" .tiny_subcontaner .inactive_tiny_holder").append('<div class="text_holder"></div>');
 jQuery("#parent_"+tinyid+" .tiny_subcontaner .inactive_tiny_holder").append('<input type="button" value="Expand" style="color:#92B2D6;font-size:1.2em;margin-top:10px;float:right;" onclick="expand('+tinyid+')" />');
 jQuery("#parent_"+tinyid).append('<div class="tiny_handler"></div>');
 jQuery("#parent_"+tinyid+" .tiny_handler").append('<input type="button" value="Delete" class="handle" onclick="tinymceDelete('+tinyid+')"/>')
 tinyMCEOnDemand(tinyid);
 }
 */

function start() {
        //mceRemoveControl();
        var idholder = [];
        jQuery(".tinyclass").each(function() {
                Array.max = function(array) {
                        return Math.max.apply(Math, array);
                };
                var len = jQuery(this).attr("id").length;
                var index = jQuery(this).attr("id").indexOf("_");
                idholder.push(jQuery(this).attr("id").slice(index + 1, len));
		
        });
        var tinu_id_int = (Number(Array.max(idholder)) + 1);
        var maxId = (Number(Array.max(idholder)) + 1);
        var tinyid = "tinyid_" + (Number(Array.max(idholder)) + 1);
        jQuery("#tinymceholder").append('<div class="tiny_contaner" id="parent_' + tinyid + '"></div>');
        jQuery("#parent_" + tinyid).append('<fieldset style="float:left;width:522px"></fieldset>');
        jQuery("#parent_" + tinyid + " fieldset").append('<legend></legend>');
        jQuery("#parent_" + tinyid + " fieldset legend").html("Page " + maxId);
    	jQuery("#parent_" + tinyid + " fieldset legend").after('<a href="javascript:void(0)" class="hide_control" data-tiny_parentID="parent_'+tinyid+'">Collapse</a>');
        jQuery("#parent_" + tinyid + " fieldset").append('<div class="tiny_subcontaner" style="float:none;"></div>');
        jQuery("#parent_" + tinyid + " .tiny_subcontaner").append('<div class="title_container" style="display:none;"></div>');
        jQuery("#parent_" + tinyid + " .tiny_subcontaner .title_container").append('<label class="tiny_title_label"></label>').html("Page Title * : ");
        jQuery("#parent_" + tinyid + " .tiny_subcontaner .title_container").append('<input class="tinytitle_input" type="text" name="article[pages_content][][title]" value="Page ' + maxId + '" />');
        jQuery("#parent_" + tinyid + " .tiny_subcontaner").append('<textarea name="article[pages_content][][content]" id="' + tinyid + '" class="tinyclass" rows="35" cols="30" style="width:100%;display:none;"></textarea>');
        jQuery("#parent_" + tinyid + " .tiny_subcontaner").append('<div class="inactive_tiny_holder" style="padding:5px;">');
        jQuery("#parent_" + tinyid + " .tiny_subcontaner .inactive_tiny_holder").append('<div class="text_holder"></div>');
       // jQuery("#parent_" + tinyid + " .tiny_subcontaner .inactive_tiny_holder").append('<input type="button" class="expand_tinymce" value="Expand" style="color:#92B2D6;font-size:1.2em;float:right;" data-id="'+tinu_id_int+'" onclick=expand("' + tinyid + '") />');
    jQuery("#parent_" + tinyid + " .tiny_subcontaner .inactive_tiny_holder").append('<input type="button" class="expand_tinymce" value="Expand" style="color: #ffffff;font-size:1.2em;float:right;background:#6a8b92;margin: 1px 3px; padding: 5px; width: auto;font-family: arial;border-style: solid !important;border-radius:5px;background: rgb(106, 139, 146) none repeat scroll 0% 0%;" data-id="'+tinu_id_int+'" onclick=expand("' + tinyid + '") />');
/*
    jQuery("#parent_" + tinyid + " .tiny_subcontaner").append('<div class="'+tinyid+'_wordCount" style="margin-top:6px;"></div>');
    jQuery("#parent_" + tinyid + " .tiny_subcontaner  ."+tinyid+"_wordCount" ).append('<label class="tiny_word_label"></label>').html("Word Count_1 : ");
    jQuery("#parent_" + tinyid + " .tiny_subcontaner  ."+tinyid+"_wordCount" ).append('<input class="tiny_word_input" id="word_' + tinyid + '" readonly="readonly" />');
   jQuery("#parent_" + tinyid + " .tiny_subcontaner  ."+tinyid+"_wordCount" ).html("Word Count_1 : ");
*/
      //  jQuery("#parent_" + tinyid + " .tiny_subcontaner").append('<div class="word_counter_holder" style="margin-top:12px;"></div>');
       // jQuery("#parent_" + tinyid + " .tiny_subcontaner .word_counter_holder").append('<label class="tiny_word_label"></label>').html('<label class="tiny_word_label">Word Count :</label>');
       // jQuery("#parent_" + tinyid + " .tiny_subcontaner .word_counter_holder").append('<input class="tiny_word_input" id="word_' + tinyid + '" readonly="readonly" />');
        jQuery("#parent_" + tinyid).append('<div class="tiny_handler"></div>');
        jQuery("#parent_" + tinyid + " .tiny_handler").append('<input type="button" value="Delete" class="handle" onclick=tinymceDelete("' + tinyid + '")  />')
         tinymce.execCommand('mceAddEditor', true, tinyid);
//    setTimeout(tinyMCEOnDemand(tinyid), 1000)
	   $('.inactive_tiny_holder .expand_tinymce').click();
        
}

function tinyMCEOnDemand(tinyid, width, height) {
tinymce.init({
  selector: "#"+ tinyid,  
  width : width || 515,
  mode : "exact",
  editor_selector : "mceEditor",
  height: height || 500,
  importcss_append:true,
  importcss_file_filter: "/javascripts/tinymce/jscripts/tiny_mce/themes/advanced/skins/default/dialog.css",
  powerpaste_allow_local_images: true,    
  plugins: [
    "powerpaste kreimage textcolor kredigitalassets advlist autolink autosave link lists charmap preview hr anchor image image imagetools",
    "wordcount visualblocks visualchars code fullscreen insertdatetime media nonbreaking",
    "table contextmenu directionality emoticons template textcolor textcolor colorpicker textpattern searchreplace"
  ],   
  toolbar1: "bold italic underline strikethrough pastetext searchreplace styleselect formatselect | bullist numlist | blockquote  undo redo table | media kredigitalassets kreimage code | autolink link unlink fullscreen | preview tinymcespellchecker hr charmap removeformat visualchars | subscript superscript outdent indent | alignleft aligncenter alignright alignjustify | forecolor backcolor",
  menubar: false,
    content_style: "img.left{float:left;}img.right{float:right;}img.center{text-align:center;display: block;margin: 0 auto;}",
  toolbar_items_size: 'small',
  imagetools_proxy: 'http://tinymce.kreatio.com/ephox-image-proxy/image'
                /*,setup : function(ed) {
                        var timeoutID;
                        ed.on('init',function(ed, e) {
                                txt = ed.target.getContent();
                                count.setup(txt);
                        });
                        ed.on('keydown',function(ed, e) {
                                txt = ed.target.getContent();
                                count.setup(txt);
                        });
                }*/
});
        
        mceRemoveControlWithoutFirst();
        show_hide_handler();

     if($(".inactive_tiny_holder").is(':visible')){
        $('.inactive_tiny_holder .expand_tinymce').click();
        var scroll_tinymce = 'parent_tinyid_'+$('.inactive_tiny_holder .expand_tinymce:last').data('id');
        $('html, body').animate({ scrollTop: $('#'+scroll_tinymce).offset().top }, 'slow');
     }
};

//for word count

var count = {
        remind : function(txtOrg) {
                var word = 0;
                tinyid = tinyMCE.activeEditor.id
                txtLength = txtOrg.replace(/(<([^>]+)>)/ig, "");
                txtLengthW = txtOrg.replace(/<.[^<>]*?>/g, ' ').replace(/&nbsp;/gi, ' ');
                txtLengthW.replace(/\S\s+/g, function() {
                        word++;
                });
                jQuery("#word_" + tinyid).attr("value", word);
                this.cancel();
        },
        setup : function(txt) {
                this.cancel();
                var self = this;
                this.timeoutID = setTimeout(function() {
                        self.remind(txt);
                }, 500);
        },
        cancel : function() {
                if( typeof this.timeoutID == 'number') {
                        clearTimeout(this.timeoutID);
                }
        }
};

function mceRemoveControl() {
	    jQuery(".tinyclass").each(function() {
                var id = jQuery(this).attr("id");
                if(tinyMCE.get(id)) {
                        tinyMCE.execCommand("mceRemoveEditor", true, id);
                        var get_html = jQuery(this).attr("value").substr(350);
                        jQuery(this).next(".inactive_tiny_holder").children(".text_holder").html(get_html);
                        jQuery(".text_holder img").each(function() {
                                jQuery(this).remove();
                        });
                        jQuery(this).hide();
                        jQuery(this).prev(".title_container").hide();
                        jQuery(this).next(".inactive_tiny_holder").show();
                }
        });
}

function mceRemoveControlWithoutFirst() {
        var full_array = jQuery(".tinyclass:not(:first)");
        full_array.each(function() {
                var id = jQuery(this).attr("id");
                if(tinyMCE.get(id)) {
                        tinymce.execCommand("mceRemoveEditor", true, id);
                        var get_html = jQuery(this).attr("value").substr(350);
                        jQuery(this).next(".inactive_tiny_holder").children(".text_holder").html(get_html);
                        jQuery(".text_holder img").each(function() {
                                jQuery(this).remove();
                        });
                        jQuery(this).hide();
                        jQuery(this).prev(".title_container").hide();
                        jQuery(this).next(".inactive_tiny_holder").show();
                }
        });
}

function expand(id) {
        mceRemoveControl();
        jQuery("#" + id).next(".inactive_tiny_holder").hide();
        jQuery("#" + id).prev(".title_container").show();
        jQuery("#" + id).show();
        jQuery(".title_container:eq(0)").css("display", "none");
        jQuery(".tinytitle_input:eq(0)").css("disabled", "disabled");
        tinyMCE.execCommand("mceAddEditor", false, id);
}

//on mouse down inactivating the tiny mce

function mouseDown(id) {
	    if(tinyMCE.get(id)) {
                tinyMCE.execCommand("mceRemoveEditor", false, id);
        }
}

//on mouse up reactivating the inactive tiny mce

function mouseUp(id) {
        expand(id);
        tinyMCE.execCommand("mceAddEditor", false, id);
}

//for deleting the tinymce
function tinymceDelete(id) {
        if(confirm("This page will be deleted and all the information will be lost on the page !!!")) {
                if(tinyMCE.get(id)) {
                        tinyMCE.execCommand("mceRemoveEditor", false, id);
                }
                jQuery("#parent_" + id).remove();
                show_hide_handler();
        }
}

//for showing and hiding the draging handler and making sortable
function show_hide_handler() {
        if(jQuery(".tinyclass").length <= 1) {
                jQuery(".tiny_handler").hide();
                jQuery(".title_container:eq(0)").css("display", "none");
                jQuery(".tinytitle_input:eq(0)").attr("disabled", "disabled")
        } else {
                jQuery(".tiny_handler").show();
                jQuery(".tiny_title_label").show();
                jQuery(".tinytitle_input").show();
                jQuery(".tinytitle_input").each(function() {
                        jQuery(this).css("disabled", "disabled")
                });
                jQuery(".title_container:eq(0)").css("display", "none");
                jQuery(".tinytitle_input:eq(0)").attr("disabled", "disabled");
        }

}

function getTinyMCE(tinyid) {
    tinyMCEOnDemand(tinyid);
}

