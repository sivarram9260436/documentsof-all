jQuery(document).ready(function(){
jQuery("#add_article_tiny").click(function(){
	start();
});
});

jQuery(document).ready(function(){
 //start();
});

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
    jQuery("#parent_"+tinyid).append('<div class="tiny_handler button"></div>');
    jQuery("#parent_"+tinyid+" .tiny_handler").append('<input type="button" value="Delete" class="handle" onclick="tinymceDelete('+tinyid+')"/>')
    tinyMCEOnDemand(tinyid);
}

function tinyMCEOnDemand(tinyid){
  tinyMCE.init({
	    elements:""+tinyid,
	    mode : "specific_textareas",
	    editor_selector : "mceEditor",
	    theme : "advanced",
	    width : 640,
	    plugins : "autolink,lists,spellchecker,pagebreak,style,layer,table,save,advhr,advimage,advlink,emotions,iespell,inlinepopups,insertdatetime,preview,media,searchreplace,print,contextmenu,paste,directionality,fullscreen,noneditable,visualchars,nonbreaking,xhtmlxtras,template",

	    // Theme options
	    theme_advanced_buttons1 : "bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull,|,styleselect,formatselect,fontselect,fontsizeselect",
	    theme_advanced_buttons2 : "cut,copy,paste,pastetext,pasteword,|,search,replace,|,bullist,numlist,|,outdent,indent,blockquote,|,undo,redo,|,link,unlink,anchor,image,cleanup,help,code,|,insertdate,inserttime,preview",
	   // theme_advanced_buttons3 : "tablecontrols,|,hr,removeformat,visualaid,|,sub,sup,|,charmap,emotions,iespell,media,advhr,|,print,|,ltr,rtl,|,fullscreen,|,forecolor,backcolor",
	    theme_advanced_buttons4 : "insertlayer,moveforward,movebackward,absolute,|,styleprops,spellchecker,|,cite,abbr,acronym,del,ins,attribs,|,visualchars,nonbreaking,template,blockquote,pagebreak,|,insertfile,insertimage",
	    theme_advanced_toolbar_location : "top",
	    theme_advanced_toolbar_align : "left",
	    theme_advanced_statusbar_location : "bottom",
	    theme_advanced_resizing : true,

	    // Skin options
	    skin : "o2k7",
	    skin_variant : "silver",

	    content_css : "/javascripts/tinymce/jscripts/tiny_mce/themes/advanced/skins/default/dialog.css",

	    // Drop lists for link/image/media/template dialogs
	    template_external_list_url : "js/template_list.js",
	    external_link_list_url : "js/link_list.js",
	    external_image_list_url : "",
	    media_external_list_url : "js/media_list.js",

	    // Replace values for the template plugin
	    template_replace_values : {
		    username : "Some User",
		    staffid : "991234"
	    },
	    setup: function(ed){
		      var timeoutID;
		      ed.onInit.add(function(ed, e){ txt = tinyMCE.activeEditor.getContent();count.setup(txt);});
		      ed.onKeyUp.add(function(ed, e){txt = tinyMCE.activeEditor.getContent();count.setup(txt); });
		      //ed.onMouseDown.add(function(ed, e){txt = tinyMCE.activeEditor.getContent();count.setup(txt); });
	    }

  });
	mceRemoveControlWithoutFirst(); 
	show_hide_handler();
};

//for word count

var count = {
remind: function(txtOrg){
   var word = 0;
   tinyid=tinyMCE.activeEditor.id
   txtLength = txtOrg.replace(/(<([^>]+)>)/ig,"");
   txtLengthW = txtOrg.replace(/<.[^<>]*?>/g, ' ').replace(/&nbsp;/gi, ' ');
   txtLengthW.replace(/\S\s+/g, function(){word++;});
   jQuery("#word_"+tinyid).attr("value",word);
   this.cancel();
   },
   
setup: function(txt){
     this.cancel();
     var self = this;
     this.timeoutID = setTimeout(function(){self.remind(txt);}, 500);
     },
     
cancel: function(){
   if(typeof this.timeoutID == 'number')
   {
    clearTimeout(this.timeoutID);
   }
 }
};


function mceRemoveControl(){
   jQuery(".tinyclass").each(function(){
     var id = jQuery(this).attr("id");
     if(tinyMCE.getInstanceById(id)){
       tinyMCE.execCommand("mceRemoveControl", true, id);
       var get_html = jQuery(this).attr("value").substr(350);
       jQuery(this).next(".inactive_tiny_holder").children(".text_holder").html(get_html);
	  jQuery(".text_holder img").each(function(){
	    jQuery(this).remove();
	  });
       jQuery(this).hide();
       jQuery(this).prev(".title_container").hide();
       jQuery(this).next(".inactive_tiny_holder").show();
    }
  });
}

function mceRemoveControlWithoutFirst(){
  var full_array = jQuery(".tinyclass");
  if (full_array.length <=1){
   var final_array=full_array;
  }
  else{
   var final_array = full_array.not(jQuery(full_array).eq(0));
  }
  final_array.each(function(){
    var id = jQuery(this).attr("id");
    if(tinyMCE.getInstanceById(id)){
       tinyMCE.execCommand("mceRemoveControl", true, id);
       var get_html = jQuery(this).attr("value").substr(350);
       jQuery(this).next(".inactive_tiny_holder").children(".text_holder").html(get_html);
	  jQuery(".text_holder img").each(function(){
	    jQuery(this).remove();
	  });
       jQuery(this).hide();
       jQuery(this).prev(".title_container").hide();
       jQuery(this).next(".inactive_tiny_holder").show();
    }
  });
}


function expand(id){
  mceRemoveControl();
  jQuery("#"+id).next(".inactive_tiny_holder").hide();
  jQuery("#"+id).prev(".title_container").show();
  jQuery("#"+id).show();
  jQuery(".title_container:eq(0)").css("display","none");
  jQuery(".tinytitle_input:eq(0)").css("disabled","disabled");
  tinyMCE.execCommand("mceAddControl", false, id); 
}

//on mouse down inactivating the tiny mce

function mouseDown(id){
 if(tinyMCE.getInstanceById(id)){
 tinyMCE.execCommand("mceRemoveControl", false, id);
 }
}

//on mouse up reactivating the inactive tiny mce

function mouseUp(id){
expand(id);
tinyMCE.execCommand("mceAddControl", false, id);
}

//for deleting the tinymce
function tinymceDelete(id){
 if (confirm("This page will be deleted and all the information will be lost on the page !!!"))
  {
    if(tinyMCE.getInstanceById(id)){
      tinyMCE.execCommand("mceRemoveControl", false, id);
    }
     jQuery("parent_"+id).remove();
     show_hide_handler();
  }
}
//for showing and hiding the draging handler and making sortable
function show_hide_handler(){
 if(jQuery(".tinyclass").length<=1){
   jQuery(".tiny_handler").hide();
   jQuery(".title_container:eq(0)").css("display","none");
   jQuery(".tinytitle_input:eq(0)").attr("disabled","disabled")
 }
 else{
 jQuery(".tiny_handler").show();
 jQuery(".tiny_title_label").show();
 jQuery(".tinytitle_input").show();
 jQuery(".tinytitle_input").each(function(){
    jQuery(this).css("disabled","disabled")
 });
 jQuery(".title_container:eq(0)").css("display","none");
 jQuery(".tinytitle_input:eq(0)").attr("disabled","disabled");
 }
 
}

function getTinyMCE(tinyid){
  tinyMCE.init({
	    elements:""+tinyid,
	    mode : "specific_textareas",
	    editor_selector : "mceEditor",
	    theme : "advanced",
	    width : 640,
	    plugins : "autolink,lists,spellchecker,pagebreak,style,layer,table,save,advhr,advimage,advlink,emotions,iespell,inlinepopups,insertdatetime,preview,media,searchreplace,print,contextmenu,paste,directionality,fullscreen,noneditable,visualchars,nonbreaking,xhtmlxtras,template",

	    // Theme options
	    theme_advanced_buttons1 : "bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull,|,styleselect,formatselect,fontselect,fontsizeselect",
	    theme_advanced_buttons2 : "cut,copy,paste,pastetext,pasteword,|,search,replace,|,bullist,numlist,|,outdent,indent,blockquote,|,undo,redo,|,link,unlink,anchor,image,cleanup,help,code,|,insertdate,inserttime,preview,|,forecolor,backcolor",
	    theme_advanced_buttons3 : "tablecontrols,|,hr,removeformat,visualaid,|,sub,sup,|,charmap,emotions,iespell,media,advhr,|,print,|,ltr,rtl,|,fullscreen",
	    theme_advanced_buttons4 : "insertlayer,moveforward,movebackward,absolute,|,styleprops,spellchecker,|,cite,abbr,acronym,del,ins,attribs,|,visualchars,nonbreaking,template,blockquote,pagebreak,|,insertfile,insertimage",
	    theme_advanced_toolbar_location : "top",
	    theme_advanced_toolbar_align : "left",
	    theme_advanced_statusbar_location : "bottom",
	    theme_advanced_resizing : true,

	    // Skin options
	    skin : "o2k7",
	    skin_variant : "silver",

	    content_css : "/javascripts/tinymce/jscripts/tiny_mce/themes/advanced/skins/default/dialog.css",

	    // Drop lists for link/image/media/template dialogs
	    template_external_list_url : "js/template_list.js",
	    external_link_list_url : "js/link_list.js",
	    external_image_list_url : "",
	    media_external_list_url : "js/media_list.js",

	    // Replace values for the template plugin
	    template_replace_values : {
		    username : "Some User",
		    staffid : "991234"
	    }
  });
}