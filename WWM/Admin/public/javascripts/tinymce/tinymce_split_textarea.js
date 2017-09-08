
/*function start(){
    mceRemoveControl();
    var idholder=[];
    $$(".tinyclass").each(function(ele)
    {len=ele.id.length;index=ele.id.indexOf("_");idholder.push(ele.id.slice(index+1,len));});
    var maxId = (Number(idholder.max())+1);
    var tinyid="tinyid_"+(Number(idholder.max())+1);
    //var tinyid="tinyid_"+($$(".tinyclass").length+1);
    var parent = $("tinymceholder");
    var d =new Element("div",{className:"tiny_contaner",id:"parent_"+tinyid});
    var fieldSet = new Element("fieldset",{style:"float:left;width:455px;"});
    var legend = new Element("legend",{style:""}).update("Page"+maxId);; 
   
    var txtdiv= new Element("div",{className:"tiny_subcontaner",style:"float:none;"});
   
    var title_container = new Element("div",{className:"title_container"});
    var lbl=new Element("label",{className:"tiny_title_label"}).update("Page Title * : ");
    var tbox=new Element("input",{className:"tinytitle_input",type:"text",value:"Page "+maxId,name:"article[pages_content][][title]"})
    title_container.insert(lbl);  
      title_container.insert(tbox);
       
    var word_counter_holder = new Element("div",{className:"word_counter_holder",style:"margin-top:6px;"});

    var wlbl=new Element("label",{className:"tiny_word_label"}).update("word count : ");
    var wbox=new Element("input",{className:"tiny_word_input",id:'word_'+tinyid,readonly:true});
     word_counter_holder.insert(wlbl);   
     word_counter_holder.insert(wbox);
       
    var main_tarea=new Element("textarea",{name:"article[pages_content][][content]",id:""+tinyid,className:"tinyclass",rows:"35",cols:"30",style:"width:100%;"});
   
    var inactive_tiny_holder = new Element("div",{className:"inactive_tiny_holder",style:"display:none;padding:5px;"});
    var text_holder = new Element("div",{className:"text_holder"});
    var expandBtn = new Element("input",{onclick:"expand('"+tinyid+"')",type:"button",value:"Expand",style:"color:#92B2D6;font-size:1.2em;margin-top:10px;float:right;"});
   
    inactive_tiny_holder.insert(text_holder);
    inactive_tiny_holder.insert(expandBtn);
    
    txtdiv.insert(title_container);
    txtdiv.insert(main_tarea);
    txtdiv.insert(inactive_tiny_holder);
    txtdiv.insert(word_counter_holder);
   
    fieldSet.insert(legend);
    fieldSet.insert(txtdiv);
    d.insert(fieldSet);
   
    var handdiv= new Element("div",{className:"tiny_handler"});
    //var handle=new Element("img",{src:"/images/icon_2.png",className:"handle",onmousedown:"mouseDown('"+tinyid+"')",onmouseup:"mouseUp('"+tinyid+"')"});
   
   // dbutton=new Element("a",{href:"#",onclick:"tinymceDelete('"+tinyid+"')"}).update("Delete");
   
    dbutton=new Element("input",{onclick:"tinymceDelete('"+tinyid+"')",type:"button",value:"Delete",className:"handle"});
   
    //handdiv.insert(handle);
    handdiv.insert(dbutton);
    d.insert(handdiv);
    parent.insert(d);
    tinyMCEOnDemand(tinyid);

    //$$(".adminSplitButton").invoke('hide');
}*/
jQuery("#add_article_tiny").live("click",function(){
	start();
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
    //var tinyid="tinyid_"+($$(".tinyclass").length+1);
    //var parent = jQuery("#tinymceholder");
 
   jQuery("#tinymceholder").wrapInner('<div class="tiny_contaner" id="parent_'+tinyid+'"></div>');
   // var d = jQuery("div").attr({"class":"tiny_contaner","id":"parent_"+tinyid});
 //   var d = '<div class="tiny_contaner" id="parent_'+tinyid+'"></div>';
     
   // var fieldSet = jQuery("fieldset").attr({style:"float:left;width:455px;"});
   /* var fieldSet = "<fieldset style='float:left;width:455px'></fieldset>"
    var legend = jQuery("legend").attr("style","").html("Page"+maxId);;  
    var txtdiv= jQuery("div").attr({"class":"tiny_subcontaner","style":"float:none;"});
    var title_container = jQuery("div").attr("class","title_container");
    var lbl=jQuery("label").attr("class","tiny_title_label").html("Page Title * : ");
    var tbox=jQuery("input").attr({"class":"tinytitle_input","type":"text","value":"Page "+maxId,"name":"article[pages_content][][title]"});
    jQuery(title_container).append(lbl);   
    jQuery(title_container).append(tbox); 
    var word_counter_holder = jQuery("div").attr({"class":"word_counter_holder","style":"margin-top:6px;"});
    var wlbl=jQuery("label").attr("class","tiny_word_label").html("word count : ");
    var wbox=jQuery("input").attr({className:"tiny_word_input",id:'word_'+tinyid,readonly:"readonly"});
    jQuery(word_counter_holder).append(wlbl);    
    jQuery(word_counter_holder).append(wbox); 
    var main_tarea=jQuery("textarea").attr({name:"article[pages_content][][content]",id:""+tinyid,className:"tinyclass",rows:"35",cols:"30",style:"width:100%;"});
    var inactive_tiny_holder = jQuery("div").attr({className:"inactive_tiny_holder",style:"display:none;padding:5px;"});
    var text_holder = jQuery("div").attr("className","text_holder");
    var expandBtn = jQuery("input").attr({onclick:"expand('"+tinyid+"')",type:"button",value:"Expand",style:"color:#92B2D6;font-size:1.2em;margin-top:10px;float:right;"}); 
    jQuery(inactive_tiny_holder).append(text_holder);
    jQuery(inactive_tiny_holder).append(expandBtn);
    jQuery(txtdiv).append(title_container);
    jQuery(txtdiv).append(main_tarea);
    jQuery(txtdiv).append(inactive_tiny_holder);
    jQuery(txtdiv).append(word_counter_holder);
    jQuery(fieldSet).append(legend);
    jQuery(fieldSet).append(txtdiv);
    jQuery(d).append(fieldSet);
    var handdiv= jQuery("div").attr("class","tiny_handler");
    var dbutton=jQuery("input").attr({onclick:"tinymceDelete('"+tinyid+"')",type:"button",value:"Delete",className:"handle"}); 
    jQuery(handdiv).append(dbutton);
    jQuery(d).append(handdiv);*/
   
    tinyMCEOnDemand(tinyid);
}

//for creating the tiny mce dynamicly for each text area

function tinyMCEOnDemand(tinyid){
tinyMCE.init({elements:""+tinyid,
      //auto_resize:true,
    //  external_link_list_url : "/public/javascripts/tiny_mce/myexternallist.js",
   //   extended_valid_elements: 'iframe[src|width|height|frameborder|scrolling],a[name|href|target|title|onclick],img[class|src|style|title|alt| hspacevspace|width|height|align|onmouseover|onmouseout|name],hr[class|width|size|noshade],span[class|align|style],font[]',
      mode: 'exact',
      entity_encoding : "raw",
      paste_auto_cleanup_on_paste: true,
      plugins: 'table,spellchecker,contextmenu,paste,advimage,style,fullscreen,advlink,template,example,pagebreak',theme: 'advanced',theme_advanced_buttons1:'spellchecker,bold,italic,underline,strikethrough,formatselect,separator,justifyleft,justifycenter,justifyright,separator,sub,sup,separator,indent,outdent,separator,bullist,numlist',
      theme_advanced_buttons2:'blockquote,template,image,separator,code,separator,styleprops,link,unlink,separator,undo,redo,separator,fullscreen,example,pagebreak',
      theme_advanced_buttons3: 'tablecontrols',
      theme_advanced_resize_horizontal: false,
      theme_advanced_resizing: true,
      theme_advanced_toolbar_align: 'left',
      spellchecker_rpc_url: '/spellchecker',
      theme_advanced_toolbar_location: 'top',
      setup: function(ed){
      var timeoutID;
      ed.onInit.add(function(ed, e){ txt = tinyMCE.activeEditor.getContent();count.setup(txt);});
      ed.onKeyUp.add(function(ed, e){txt = tinyMCE.activeEditor.getContent();count.setup(txt); });
      //ed.onMouseDown.add(function(ed, e){txt = tinyMCE.activeEditor.getContent();count.setup(txt); });
      }
 });
mceRemoveControlWithoutFirst();
show_hide_handler();
//tinymce_sorting();

};


//for word count

var count = {remind: function(txtOrg){
   var word = 0;
   tinyid=tinyMCE.activeEditor.id
   txtLength = txtOrg.replace(/(<([^>]+)>)/ig,"");
   txtLengthW = txtOrg.replace(/<.[^<>]*?>/g, ' ').replace(/&nbsp;/gi, ' ');
   txtLengthW.replace(/\S\s+/g, function(){word++;});
   document.getElementById('word_'+tinyid).value = word;
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

/*function mceRemoveControl(){
    $$(".tinyclass").each(function(ele){
     if(tinyMCE.getInstanceById(ele.id)){
     tinyMCE.execCommand("mceRemoveControl", true, ele.id);
      $(ele).next(".inactive_tiny_holder").down(".text_holder").innerHTML = $(ele).value.truncate("350");
      $$(".text_holder img").each (function (ele){ele.remove();})
      $(ele).hide();
      $(ele).previous(".title_container").hide();
      $(ele).next(".inactive_tiny_holder").show();
     } 
     
    });
}*/
 
 function mceRemoveControl(){
   jQuery(".tinyclass").each(function(){
     var id = jQuery(this).attr("id");
     if(tinyMCE.t){
        tinyMCE.execCommand("mceRemoveControl", true, id);
    var get_html = jQuery(this).attr("value").substr(350);
    jQuery(this).next(".inactive_tiny_holder").find(".text_holder").html(get_html);
      jQuery(".text_holder img").each(function(){
        jQuery(this).remove();
      });
    jQuery(this).hide();
    jQuery(this).prev(".title_container").hide();
    jQuery(this).next(".inactive_tiny_holder").show();
    }
  });
}

/*function mceRemoveControlWithoutFirst(){
  full_array=$$(".tinyclass");
  if (full_array.length <=1){final_array=full_array;}
  else {final_array=full_array.without(full_array.first());}
  final_array.each(function(ele){
     if(tinyMCE.getInstanceById(ele.id)){
     tinyMCE.execCommand("mceRemoveControl", true, ele.id);
      $(ele).next(".inactive_tiny_holder").down(".text_holder").innerHTML = $(ele).value.truncate("350");
      $$(".text_holder img").each (function (ele){ele.remove();})
      $(ele).hide();
      $(ele).previous(".title_container").hide();
      $(ele).next(".inactive_tiny_holder").show();
     } 
     
    });
}*/

function mceRemoveControlWithoutFirst(){
  var full_array = jQuery(".tinyclass");
    if(full_array.size() <=1 ){
      var final_array = jQuery(full_array);
    }
    else{
      var final_array= jQuery(full_array).not(jQuery(full_array).eq(0));
    }
    jQuery(final_array).each(function(){
    var id = jQuery(this).attr("id");
      if(tinyMCE.id){
         tinyMCE.execCommand("mceRemoveControl", true, id);
         var get_html = jQuery(this).attr("value").substr(350);
        jQuery(this).next(".inactive_tiny_holder").find(".text_holder").html(get_html);
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
  $(id).next(".inactive_tiny_holder").hide();
  $(id).previous(".title_container").show();
  $(id).show();
  $($$(".title_container").first()).hide();
  $($$(".tinytitle_input").first()).disabled=true;
  tinyMCE.execCommand("mceAddControl", false, id);
}

jQuery(".expand_tinymce").click(function(){
  var tinymce_id = jQuery(this).data("tinyid");
  mceRemoveControl();
  jQuery(tinymce_id).next(".inactive_tiny_holder").hide();
  jQuery(tinymce_id).prev(".title_container").show();
  jQuery(tinymce_id).show();
  jQuery(".title_container:eq(0)").hide();
  jQuery(".tinytitle_input:eq(0)").attr("disabled","disabled");
   tinyMCE.execCommand("mceAddControl", false, tinymce_id);
});
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
     $("parent_"+id).remove();
     show_hide_handler();
  }
}
//for showing and hiding the draging handler and making sortable
function show_hide_handler(){
 if($$(".tinyclass").length<=1){
   $$(".tiny_handler").invoke('hide');
   $($$(".title_container").first()).hide();
   $($$(".tinytitle_input").first()).disabled=true;
   //$$(".adminSplitButton").invoke('show');
  
 }
 else{
 $$(".tiny_handler").invoke('show');
 $$(".tiny_title_label").invoke('show');
 $$(".tinytitle_input").invoke('show');
 $$(".tinytitle_input").each(function(e){$(e).disabled=false});
 $($$(".title_container").first()).hide();
 $($$(".tinytitle_input").first()).disabled=true;
 }
 
}


// for making tiny mce sortable
function tinymce_sorting(){
if($$(".tinyclass").length<=1){
   $$(".tiny_handler").invoke('hide');
 }
 else{
 $$(".tiny_handler").invoke('show');
 Sortable.create('tinymceholder',{tag:'div',handle:'handle',onUpdate:function(){show_hide_handler();}});
 
 }
 }
 

//document.observe('dom:loaded', function() {tinymce_sorting()});


function getTinyMCE(tinyid){
    alert("test");
tinyMCE.init({elements:""+tinyid,
    //  external_link_list_url : "/public/javascripts/tiny_mce/myexternallist.js",
      extended_valid_elements: 'iframe[src|width|height|frameborder|scrolling],a[name|href|target|title|onclick],img[class|src|style|title|alt| hspacevspace|width|height|align|onmouseover|onmouseout|name],hr[class|width|size|noshade],span[class|align|style],font[],script[charset|defer|language|src|type],',
      mode: 'exact',
       entity_encoding : "raw",
      entities : "160,nbsp,38,amp,34,quot,162,cent,8364,euro,163,pound,165,yen,169,copy,174,reg,8482,trade,8240,permil,60,lt,62,gt,8804,le,8805,ge,176,deg,8722,minus",
      encoding : "xml",
    //  element_format : "html",
      paste_auto_cleanup_on_paste: true,
      plugins: 'table,spellchecker,contextmenu,paste,advimage,style,fullscreen,advlink,template,example,pagebreak',theme: 'advanced',
      theme_advanced_buttons1:'spellchecker,bold,italic,underline,strikethrough,formatselect,separator,justifyleft,justifycenter,justifyright,separator,sub,sup,separator,indent,outdent,separator,bullist,numlist',
      theme_advanced_buttons2:'blockquote,template,image,separator,code,separator,styleprops,link,unlink,separator,undo,redo,separator,fullscreen,example,pagebreak',
      theme_advanced_buttons3: 'tablecontrols',
      theme_advanced_resize_horizontal: false,
      theme_advanced_toolbar_align: 'left',
      spellchecker_rpc_url: '/spellchecker',
      theme_advanced_toolbar_location: 'top'
  });
jQuery('#tinyid_1_ifr').contents().find('body').find(".center").css({"display":"block","margin":"opx auto"});
 };

/*Split article*/
/*function split_article(article_id)
{
    var content= tinyMCE.activeEditor.getContent();
	if 	(content=="")
	{
	 alert("Content should not be blank");
	}
	else
	{		
	  var anch=document.getElementsByTagName('a');	  
      $A(anch).each(function(element){element.writeAttribute("onclick","return false;"); });	  
	  document.multi.action = "/admin/articles/split_article_into_pages?id="+article_id;	  
      document.multi.submit();
	}

}*/
jQuery(function(){
jQuery(".split_article").click(function(){
   var form_id = jQuery(this).parents("form.formtastic").attr("id");

	var article_id = jQuery(this).data("articleid");
		alert(article_id);
	var content= tinyMCE.activeEditor.getContent();
	if 	(content == " ")
	{
	 alert("Content should not be blank");
	}
	else
	{		
	  var anch=jQuery('a');	  
      jQuery(anch).each(function(){jQuery(this).attr("onclick","return false;"); });	  
	  var set_action  = "/admin/articles/split_article_into_pages?id="+article_id;	 
	  jQuery("#"+form_id).attr("action",set_action); 
      jQuery("#"+form_id).submit();
	}
	
	
});
});