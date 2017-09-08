 
Ajax.Responders.register({
  onCreate: function() {
    $('ajax-indicator').setStyle({display:"block"})
  },
  onComplete: function() {
   $('ajax-indicator').setStyle({display:"none"})
  }
});

/*function backsp() 
{ 
allow_backspace = true; 
}*/


 function website(){

    document.site.action = "/admin/login/change_website"
    document.site.submit();
}
/*function default_images()
{	
		document.image.submit();	
}
function search_plugin(){

	
    new Ajax.Updater('dynamic_images_list', '/admin/image_details/search_from_plugin', {
        asynchronous: true,
        evalScripts: true,
        method: 'post',		
        parameters: Form.serialize('image_upload_form')
    });
}*/

function menu_tree(){

   x = $('mytree').serializeTree('data[MenuItems]');
    
    // pars = "menu_id=" + x;
    //document.multi2.method="post"
    //document.multi2.action = "/admin/menus/reorder_menu?" + x;
    //document.multi2.submit();
    var myajax = new Ajax.Request('/admin/menus/reorder_menu', {
        method: 'post',
        evalScripts: true,
        parameters: x
    });
}

function category_tree(){
    x = $('mytree').serializeTree('data[MenuItems]');
    
   // pars = "menu_id=" + x;
    //document.multi1.action = "/admin/categories/reorder_category?" + x;
    //document.multi1.submit();
    var myajax = new Ajax.Request('/admin/categories/reorder_category', {
        method: 'post',
        evalScripts: true,
        parameters: x
    });
}

function article_search(){
    document.multi1.submit();
}

/*function serch1(){

    document.multi10.submit();
}

function edit_site(){
    var x = document.getElementsByName("site[id]");
    for (var n = 0; n < x.length; n++) {
        if (x[n].checked == true) {
            document.multi.action = "/admin/sites/edit?id=" + x[n].value;
            document.multi.submit();
            
        }
        
    }
}

function destroy_site(){
    var x = document.getElementsByName("site[id]");
    for (var n = 0; n < x.length; n++) {
        if (x[n].checked == true) {
        
            document.multi.action = "/admin/sites/destroy?id=" + x[n].value;
            document.multi.submit();
            
        }
        
    }
}*/
function show_result(path,per_page){	
    document.location.href=path +  (path.match(/\?/) ? '':'?') +"&per_page="+per_page.value
//    document.multi_advance_search.action = "/admin/articles/list"
  //  document.multi_advance_search.submit()
	
}

/*function load_menu(){

    var site_id = document.getElementById("menu_site_id").value;
    pars = "site_id=" + site_id;
    var myAjax = new Ajax.Updater('site_menu', '/admin/menus/find_site_menu', {
        method: 'get',
        parameters: pars
    });
}*/

function submit_menu(){
        if ($('menu_name').value == "") {
            alert("Name field Should not be blank ");
                }
                else {
    				document.multi.submit();
                }
}

function submit_menu1(){
    document.multi5.action = "/admin/menus/update"
    document.multi5.submit();
}

/*function destroy_menu(){
    var x = document.getElementsByName("site[id]");
    for (var n = 0; n < x.length; n++) {
        if (x[n].checked == true) {
        
            document.multi.action = "/admin/menus/destroy?id=" + x[n].value;
            document.multi.submit();
            
        }
        
    }
}*/

function submit_article(commit,controller)
{
	    /* ************************************************** */ 
	    var value = " ";
        jQuery("#ul_article_related_company_alias_ids li.bit-input .smallinput").each(function(){
        var t = jQuery(this).attr("value");
        value = value + "<input type='hidden' name='rel_id[value_"+ t + "]' value='" + t + "' />";
        });
         jQuery("#get_releated_sub_list").html(value);
		 /* ************************************************** */
	var anch=document.getElementsByTagName('a');
       $A(anch).each(function(element){
                     element.writeAttribute("onclick","return false;");
       });
	if ($('act_path').value=='new')
	{
		document.multi.action= "/admin/"+controller+"/create?commit="+commit ;
	}
	else
	{
	
		document.multi.action= "/admin/"+controller+"/update?commit="+commit ;
	}
	
    document.multi.submit();
}

function article_unpublish(commit,controller)
{
	document.multi.action= "/admin/"+controller+"/update?commit="+commit ;
	document.multi.submit();
}
function save_as_draft(commit,controller)
{
	if (commit=='save_as_draft')
	{
		document.multi.action= "/admin/"+controller+"/create?commit="+commit ;
	}
	else
	{
	
		document.multi.action= "/admin/"+controller+"/update?commit="+commit ;
	}
	
    document.multi.submit();
}
function save_and_publish(path,controller)
{
	alert("value");
	 //code for get list id releated company
    var value = " ";
	jQuery("#ul_article_related_company_alias_ids li.bit-input .smallinput").each(function(){
		var t = jQuery(this).attr("value");
	value = value + "<input type='hidden' name='rel_id[value_"+ t + "]' value='" + t + "' />";
       });
     //   alert(value);
		 jQuery("#get_releated_sub_list").html(value);

		jQuery('#tinyid_1_ifr').contents().find('body').find(".center").css({"display":"block","margin":"opx auto"});
	
		var anch=document.getElementsByTagName('a');
       $A(anch).each(function(element){
                     element.writeAttribute("onclick","return false;");
       });
	if (path == "new") {
		document.multi.action = "/admin/"+controller+"/save_and_publish";
	}
	else
	{
		document.multi.action = "/admin/"+controller+"/update_and_publish";
	}
	document.multi.submit();
}

function save_and_publish_spotlight(path,controller)
{
    var publish_date= $('article[publish_date]').value;
	if 	(publish_date=="")
	{
	alert("Publish date should not be blank");
	}
	else
	{
		
		var anch=document.getElementsByTagName('a');
       $A(anch).each(function(element){
                     element.writeAttribute("onclick","return false;");
       });
	if (path == "new") {
		document.multi.action = "/admin/"+controller+"/save_and_publish";
	}
	else
	{
		document.multi.action = "/admin/"+controller+"/update_and_publish";
	}
	document.multi.submit();
	}
}

function submit_preview(action)
{
  var section_id=$('article_section_id').value;
  var source_id=$('article_source_id').value;
  if (section_id == "")
  {
  alert("Please select the content type to view the article")
  }
  else if (source_id == "")
  {
  alert("Please select the source to view the article")
  }
  else
   {
  	var target = document.getElementById("article_form");
  	target.setAttribute("target", "popup");
  	target.setAttribute("action", action);
  	OpenWin = this.open("preview", "popup", "toolbar=no,scrollbars=yes,width=1050px,height=700,resizable=yes ");
  	target.submit();	
  }
  
}
function submit_preview_static_page(action)
{
		var target = document.getElementById("article_form");
		target.setAttribute("target", "popup");
		target.setAttribute("action",action);
		OpenWin = this.open("page", "popup", "toolbar=no,scrollbars=yes,width=1050px,height=700,resizable=yes ");
		target.submit();
}
function remove_target()
{
	var target = document.getElementById("article_form");
	target.removeAttribute("target");
}

/*function edit_article(){
    var x = document.getElementsByName("article[id]");
    for (var n = 0; n < x.length; n++) {
        if (x[n].checked == true) {
            document.multi.action = "/admin/articles/edit?id=" + x[n].value;
            document.multi.submit();
        }
    }
}

function destroy_article(){

    var x = document.getElementsByName("article[id]");
    for (var n = 0; n < x.length; n++) {
        if (x[n].checked == true) {
            document.multi.action = "/admin/articles/destroy?id=" + x[n].value;
            document.multi.submit();
            
        }
        
    }
}*/

function submit_submenu(){
    document.multi.action = "/admin/menus/save_submenu"
    document.multi.submit();
}

function submit_subcategory(){
    document.multi.action = "/admin/categories/save_subcategory"
    document.multi.submit();
}

function submit_category(){

    if ($('category_name').value == "") {
        alert("Name field Should not be blank ");
    }
    else 
    {
	   document.multi.submit();
    }
}

/*
function edit_category(id){
    pars = "id=" + id;
    var myajax = new Ajax.Updater('edit_page', '/admin/categories/edit', {
        evalScripts:true,
        method: 'get',
        parameters: pars
    });
}
*/

function submit_subcategory(){
    document.multi.action = "/admin/categories/save_subcategory"
    document.multi.submit();
}

function destroy_category(){

    var x = document.getElementsByName("category[id]");
    for (var n = 0; n < x.length; n++) {
        if (x[n].checked == true) {
            document.multi.action = "/admin/categories/destroy?id=" + x[n].value;
            document.multi.submit();
            
        }
        
    }
}

/*function article_list(){
    var x = document.getElementById("article_title").value;
    document.multi.action = "/admin/articles/list?search=" + x;
    document.multi.submit();
}*/

function submit_user(){
    if ($('user_password').value == "") {
        alert("Enter Password");
    }
    else 
        if ($('user_password_confirmation').value == "") {
            alert("Enter Confirm Password");
        }
        else 
            if ($('user_password').value != "" && $('user_password_confirmation').value != "") {
                if ($('user_password').value != $('user_password_confirmation').value) {
                    alert("Your Password and Confirm Password are not matched");
                }
                else {
                    document.multi_user.submit();
                }
            }
}

function edit_user(){
    var x = document.getElementsByName("user[id]");
    for (var n = 0; n < x.length; n++) {
        if (x[n].checked == true) {
            document.multi.action = "/admin/users/edit?id=" + x[n].value;
            document.multi.submit();
            
        }
        
    }
}

/*function destroy_user(){

    var x = document.getElementsByName("user[id]");
    for (var n = 0; n < x.length; n++) {
        if (x[n].checked == true) {
            document.multi.action = "/admin/users/destroy?id=" + x[n].value;
            document.multi.submit();
            
        }
        
    }
    
}*/

function submit_feature(){
	rankedlistname=$('featured_set_name').value;
	 blankRE=/^\s/
	 if (rankedlistname.strip() == "")
	 {
		alert("Ranked List Name should not be blank.")
		return false;
	 }		
	 else if(blankRE.test(rankedlistname))
	 {
		alert("Ranked List Name should not start with a blank space.")
		return false;
	 }	
	
	list_value= Sortable.serialize($('listTaken'));
   	document.multi.action+="?"+list_value;
    document.multi.submit();
}

function save_featurelist(flag){
	rankedlistname=$('featured_set_name').value;
	 blankRE=/^\s/
	 if (rankedlistname.strip() == "")
	 {
		alert("Ranked List Name should not be blank.")
		return false;
	 }		
	 else if(blankRE.test(rankedlistname))
	 {
		alert("Ranked List Name should not start with a blank space.")
		return false;
	 }	
	
	list_value= Sortable.serialize($('listTaken'));
   	document.multi.action+="?"+list_value+'&flag='+flag;
    document.multi.submit();
}


function submit_image(){

    document.multi123.submit();
}

/*function submit_image123(){

    document.image.submit();
}
*/



function submit_document(digital_asset_names){
//	alert(digital_asset_names);
   if (digital_asset_names.split(',').indexOf(jQuery('#digital_asset_document_path').val().replace(' ','_')) !=-1){
          alert('Document already exists.')
          }
   else if (jQuery('#digital_asset_document_path').val().match(/xls|xlt|pdf|odt|doc|ppt/)){
    jQuery('#asset').submit();
   }
   else{
        alert('You can only upload Word, Excel, PowerPoint and PDF documents.')
   }
}

function article_preview(url){
    var win_options = "toolbar=no,addressbars=yes,scrollbars=yes,width=1050px,height=700,resizable=yes ";
    window.open(url, "terms", win_options).focus();
}

function newsletter_preview(url){
    var win_options = "toolbar=no,addressbars=yes,scrollbars=yes,width=1050px,height=700,resizable=yes ";
    window.open(url, "terms", win_options).focus();
}

/*function article_preview_static(id){
	pars = "article_id=" + id+'&static='+"true";
    var win_options = "toolbar=no,addressbars=yes,scrollbars=yes,width=1050px,height=700,resizable=yes ";
    window.open("/admin/articles/preview?" + pars, "terms", win_options).focus();
}


function submenu_toggle(menu_id){
    Element.toggle(menu_id)
}

function subcategory_toggle(category_id){
    Element.toggle(category_id)
}*/

function create_req(id){
    $(id).remove();
    // new Ajax.Updater('featured_list', '/admin/articles/save_featured',
    // {asynchronous:true, evalScripts:true, method:'post',
    //  parameters:Sortable.serialize('listTaken') +'&fetured_list_art_id='+id+'&authenticity_token='+window._token});
}

function make_active(ele){
    Sortable.create("listAvailable_rated", {
        constraint: false,
        containment: ['listAvailable'],
        dropOnEmpty: true,
        onUpdate: function(){
            return false
        }
    })
}

/*function most_latest(option){

    params = "value=" + option
    
    var myajax = new Ajax.Updater('latest_most_rated', '/admin/admin_home/latest', {
        method: 'get',
        evalScripts: true,
        parameters: params
    });
}*/

function search(id){
	var section_id = document.getElementById('advance_search_section_id').value;
    var title = document.getElementById('advance_search_title').value;
    var sources = document.getElementsByName('advance_search[source_ids][]');
    source_ids=[]
     for (var n = 0; n < sources.length; n++) {
              source_ids.push(sources[n].value)
     }
    source_ids=source_ids.without(-1)
    var flag = "feature"
    if (id != "") {
        var id = document.getElementById('advance_search_id').value;
        params = "advance_search[section_id]=" + section_id + "&advance_search[title]=" + title + "&flag=" + flag + "&advance_search[id]=" + id;
    }
    else {
        params = "advance_search[section_id]=" + section_id + "&advance_search[title]=" + title + "&flag=" + flag + "&advance_search[source_ids]=" + source_ids;
    }
    
    var myajax = new Ajax.Request('/admin/articles/article_search', {
        method: 'get',
        evalScripts: true,
        parameters: params
    });
}


function article_search_collection(value)
{
    if(value!='')
    {
        var site_type = document.getElementById('search_data_article_type').value;
        params = "search_data[id]=" + value + "&flag=feature" + "&article_type=" + site_type;
    }
    else
    {
    	var section_id = document.getElementById('search_data_section_id').value;
        var title = document.getElementById('search_data_title').value;
        var sources = document.getElementsByName('search_data[source_ids][]');
		var categories = document.getElementsByName('search_data[category_ids][]');
		var site_type = document.getElementById('search_data_article_type').value;
		var primary_medium = document.getElementsByName('search_data[primary_medium][]');
		
        source_ids=[]
        for(var n = 0; n < sources.length; n++) 
        {
            source_ids.push(sources[n].value)
        }
        source_ids=source_ids.without(-1)
		category_ids=[]
		for(var n = 0; n < categories.length; n++) 
        {
            category_ids.push(categories[n].value)
        }
        category_ids=category_ids.without(-1)
		primary_mediums=[]
		for(var n = 0; n < primary_medium.length; n++) 
        {
            primary_mediums.push(primary_medium[n].value)
        }
        primary_mediums=primary_mediums.without(-1)
		primary_mediums = [primary_mediums]
		params = "search_data[section_id]=" + section_id + "&search_data[title]=" + title + "&flag=feature" + "&search_data[source_ids]=" + source_ids + "&search_data[category_ids]=" + category_ids + "&article_type=" + site_type + "&search_data[primary_medium]=" + primary_mediums;
    }

    new Ajax.Request('/admin/articles/advance_search', {
        method: 'get',
        evalScripts: true,
        parameters: params
    });
}

function blog_article_search_collection(value)
{
    if(value!='')
    {
        params = "search_data[id]=" + value + "&flag=blog_feature"
    }
    else
    {
    	var section_id = document.getElementById('search_data_section_id').value;
        var title = document.getElementById('search_data_title').value;
        var sources = document.getElementsByName('search_data[source_ids][]');
		var categories = document.getElementsByName('search_data[category_ids][]');
		var site_type = document.getElementById('search_data_article_type').value;

        source_ids=[]
        for(var n = 0; n < sources.length; n++) 
        {
            source_ids.push(sources[n].value)
        }
        source_ids=source_ids.without(-1)
		category_ids=[]
		for(var n = 0; n < categories.length; n++) 
        {
            category_ids.push(categories[n].value)
        }
        category_ids=category_ids.without(-1)
        params = "search_data[section_id]=" + section_id + "&search_data[title]=" + title + "&flag=blog_feature" + "&search_data[source_ids]=" + source_ids + "&search_data[category_ids]=" + category_ids + "&article_type=" + site_type;
    }

    new Ajax.Request('/admin/articles/advance_search', {
        method: 'get',
        evalScripts: true,
        parameters: params
    });
}

function assets_upload(flag){
   pars = "upload=" + "upload"+"&article_doc_upload=" +flag;
   jQuery.ajax({
     type:'GET',
     url:'/admin/digital_assets/upload',
     data:pars,
     success: function(data){
       jQuery("#assets_information_upload").html(data);
    }
  });
}

function assets_image(image_id,flag){
    pars = "id=" + image_id +"&article_doc_update="+flag
      jQuery.ajax({
     type:'GET',
     url:'/admin/digital_assets/asset_details',
     data:pars,
     success: function(data){
       jQuery("#assets_information_upload").html(data);
    }
  });
}

function image_upload(){
    pars = "upload=" + "upload"
    var myajax = new Ajax.Updater('horizontal_carousel', '/admin/image_details/upload', {
        method: 'get',
        evalScripts: true,
        parameters: pars
    });
}

/*function image_toggle(image_id){
    pars = "id=" + image_id
    var myajax = new Ajax.Updater('images_information_upload', '/admin/image_details/image_information', {
        method: 'get',
        parameters: pars
    });
}*/

function media_upload(){
    pars = "upload=" + "upload"
    var myajax = new Ajax.Updater('media_information_upload', '/admin/media_details/media_upload', {
        method: 'get',
        parameters: pars
    });
}

/*function display_site_div(){

    document.getElementById('candy_nav_menu_explore').style.display = "block";
}

function open_hide_upload_page(){
	$('image_upload_form').writeAttribute("onsubmit","ts_onload(); return true;");
	$('ins_img_but').style.display="none";
    if (document.getElementById("image-upload").style.display == "block") {
        document.getElementById("image-upload").style.display = "none";
        document.getElementById("search").style.display = "none";
    }
    else {
        document.getElementById("image-upload").style.display = "block";
        document.getElementById("search").style.display = "none";
    }
    
}

function open_hide_search_page(){
$('image_upload_form').writeAttribute("onsubmit","ts_onload(); return true;");
$('ins_img_but').style.display="none";
    if (document.getElementById("search").style.display == "block") {
        document.getElementById("image-upload").style.display = "none";
        document.getElementById("search").style.display = "none";
    }
    else {
        document.getElementById("image-upload").style.display = "none";
        document.getElementById("search").style.display = "block";
    }
    
    
    
}*/

function image_set(){
    pars = "upload=" + "upload"
    var myajax = new Ajax.Updater('images_information_upload', '/admin/image_details/image_set', {
        method: 'get',
        parameters: pars
    });
}

/*function image_toggle(image_id){
    pars = "id=" + image_id
    var myajax = new Ajax.Updater('images_information_upload', '/admin/image_details/image_information', {
        method: 'get',
        parameters: pars
    });
}*/

function submit_poll(){
	(document.getElementsByName('poll[options][]').length < 1) ? alert('Please add at least one option') : document.multi.submit();
}

function reset_poll(id){
	var reset_poll_options= confirm("Do you really want to reset all the votes to zero?");
	if (reset_poll_options == true) {
		pars = "id=" + id;
		var myajax = new Ajax.Updater('pollresult','/admin/polls/reset_polls', {
			method: 'get',
			parameters: pars
		
		});
	}
}
/*function select_image_title(){
    window.open('/admin/image_details/show_title_image_list', 'mywindow', 'width=500,height=500');
}

function select_image_title_path(val){

    opener.$('article_title_image_url').value = val;
}*/

function submit_component(){
    document.multi.submit();
}

function edit_users_page(){
    document.multi_user.submit();
    
}

function submit_change_password(){
    if ($('user_password').value == "") {
        alert("Enter Password");
    }
    else 
        if ($('user_password_confirmation').value == "") {
            alert("Enter Confirm Password");
        }
        else 
            if ($('user_password').value != "" && $('user_password_confirmation').value != "") {
                if ($('user_password').value != $('user_password_confirmation').value) {
                    alert("Your Password and Confirm Password are not matched");
                }
                else {
                    document.changing_password.submit();
                }
            }
}



/*function submit_imageset(){
    document.image_set.submit();
}*/

function create_slideshow(){

    var dragged_image = $$('#droparea li img[name="image_drag"]')    
    var images = new Array();
    for (var i = 0; i < dragged_image.length; i++) {
        images[i] = dragged_image[i].id ;        
    } 
	name=$('image_sequence_name').value;   
    desc=$('image_sequence_description').value;   
	pars = "image_sequence[image_ids]=" + images+ '&image_sequence[name]='+ name+ '&&image_sequence[description]=' + desc;
	document.slideshow.action = "/admin/image_details/save_images_in_slideshow?" + pars;
    document.slideshow.submit();
}

function edit_slideshow(){

  var dragged_image = $$('#droparea li img[name="image_drag"]')    
    var images = new Array();
    for (var i = 0; i < dragged_image.length; i++) {
        images[i] = dragged_image[i].id ;  
		     
    } 
	id=$('sequence_id').value;
	name=$('image_sequence_name').value;   
    desc=$('image_sequence_description').value;   
	pars = "image_sequence[image_ids]=" + images+ '&image_sequence[name]='+ name+ '&image_sequence[description]=' + desc+'&id='+id;
	document.slideshow.action = "/admin/image_details/update_images_in_slideshow?" + pars;
    document.slideshow.submit();
}

/*function filter_for_article(){
    var filter_type = $('filter_by').value;
    if (filter_type == 1) {
    
        $("article").style.display = "block";
        $("author").style.display = "none";
        
    }
    if (filter_type == 2) {
    
        $('article').style.display = "none";
        $('author').style.display = "block";
    }
    if (filter_type == "") {
    
        $('article').style.display = "none";
        $('author').style.display = "none";
    }
}

function filter_by_article_active(){
    var active = $('article_active').value;
    pars = "active=" + active;
    var myajax = new Ajax.Request('/admin/articles/filter_by_article', {
        method: 'get',
        parameters: pars
    
    });
}

function filter_by_article_author_name(){
    var author_id = $('author_id').value;
    pars = "author_id=" + author_id;
    var myajax = new Ajax.Request('/admin/articles/filter_by_article', {
        method: 'get',
        parameters: pars
    
    });
}
*/
function submit_tags(){
    document.tag_form.submit();
}

function edit_tag(tag_id){
    pars = "id=" + tag_id;
    if (tag_id == nil) {
        var myajax = new Ajax.Updater('edittag_page', '/admin/tags/new', {
            method: 'get',
            parameters: pars
        });
    }
    else {
        var myajax = new Ajax.Updater('edittag_page', '/admin/tags/edit', {
            method: 'get',
            parameters: pars
        
        });
    }
}

function tag_search(){
    name = $('tag_name').value
    type = $('tag_entity_type').value
    params = '&tag[name]=' + name + '&tag[entity_type]=' + type
    var myajax = new Ajax.Request('/admin/tags/search', { evalScripts:true, method: 'get', parameters: params});
}

/*function add_tag(){
    new UI.Window({
        theme: "mac_os_x",
        shadow: true,
        width: 200,
        height: 150
    }).center().setContent("Hello World!").show();
}

function site_property_del_option(id){
    var new_id = id.split("_").last()
	$(id).remove();
	pars = "id=" + new_id + '&authenticity_token=' + window._token
    var myajax = new Ajax.Request('/admin/sites/remove_site_properties', {
        method: 'post',
        parameters: pars
    });
}*/
function del_poll_option(id){
	var new_id = id.split("_").last()
	 $('theValue').value = $('theValue').value -1;
	$(id).remove();
	pars = "id=" + new_id +'&authenticity_token=' + window._token
    var myajax = new Ajax.Request('/admin/polls/remove_poll_option', {
        method: 'post',
        parameters: pars
    });
}
/*function submit_survey(){
    document.multi_survey.submit();
}

function display_set(){
    $('fe_edit_sets').hide();
    $('fe_sets').show();
}

function close_fe_sets(){
    $('fe_sets').hide();
}

function showeditdiv(){
    $('fe_edit_sets').show();
}

function showdiv(name, id){
    pars = "id=" + id + '&authenticity_token=' + window._token
    var myajax = new Ajax.Updater('featured_list_new', '/admin/articles/new_featured_list', {
        method: 'get',
        evalScripts: true,
        parameters: pars
    });
    
}

function submit_featured_set(){
    document.multi1.submit();
}

function submit_edit_fe_sets(){
    document.multi11.submit();
}

function show_edit_div(id){

    pars = "id=" + id
    var myajax = new Ajax.Updater('fe_edit_sets', '/admin/articles/fe_edit_sets', {
        method: 'get',
        parameters: pars
    });
    $('fe_sets').hide();
    $('fe_edit_sets').show();
    
}

function close_fe_edit(){
    $('fe_edit_sets').hide();
}

function delete_set(id){
    var answer = confirm("Are u sure want to delete?")
    if (answer) {
        $(id).remove();
        pars = "id=" + id + '&authenticity_token=' + window._token
        var myajax = new Ajax.Request('/admin/articles/remove_fe_set', {
            method: 'post',
            parameters: pars
        });
    }
}


function showingquestionbox(){
    $('showquestion_box').style.display = "block";
}*/

function select_term(params,id){
    pars = "action_type=" + params.value +"&id="+id;
	    var myAjax = new Ajax.Updater('action_type', '/admin/menus/action_type', {
        method: 'get',
        parameters: pars
    });
}

/*function select_term(val){
    menu_type=$(val).value
     var a=["section_author","Blog","section_source","section_tag","category_tag","category_section","Static","Article","Category","Author","External","Section","template","Others","Tag","Categories"]
	 for (var n = 0; n < a.length; n++) {
          if (menu_type==a[n])
            {
            if (menu_type=="Others"){
            $("Others1").show();
            }
			if (menu_type=="Category-Tag"){
				$("Category").show();
				$("Tag").show();
			}
            $(a[n]).show();
            }
          else
        	{
            $(a[n]).hide();
            $("Others1").hide();            
            }
    }

}
*/


/*function new_slideshow_metadata(){
    pars = '&authenticity_token=' + window._token
    var myajax = new Ajax.Updater('new_slideshow', '/admin/image_details/new_slideshow', {
        method: 'post',
        parameters: pars
    });
}

function submit_slideshow(){
    document.slideshow.submit();
}

function edit_slideshow_metadata(id){

    pars = "id=" + id + '&authenticity_token=' + window._token
    var myajax = new Ajax.Updater('edit_slideshow', '/admin/image_details/edit_slideshow', {
        method: 'post',
        asynchronous: true,
        parameters: pars
    });
}*/

function create_box1(){
	var count=$('input_count').value;
    var opt = $('option');
    var ni = $('myfield');
    var numi = $('theValue');
    var num = ($('theValue').value - 1) + 2;	
    numi.value = num;
	cou=parseInt(count)+1
    id = "image_detail_"+cou+"_thumbnail" 
    name = "image_detail"+"["+cou+"]"+"[thumbnail]"
	id1 = "image_detail_"+cou+"_alt_tag"  
	name1 = "image_detail"+"["+cou+"]"+"[alt_tag]"
    value = ""
    var tr = new Element('tr');
    var td = new Element('td');
    td.update('Image Path');
    var td1 = new Element('td');
    var box = new Element('input', {id: id,name: name,type:"file",value: value,'size':'30','class':'file_style'});   
    tr.appendChild(td);
    tr.appendChild(td1);
    td1.appendChild(box);	
	 ni.appendChild(tr);
	var trr = new Element('tr');    
	var td2 = new Element('td');
    td2.update('Alt Tag');
    var td3 = new Element('td');
    var box1 = new Element('input', {id: id1,name: name1,type:"input",value: value,'size':'30','class':'file_style'});	   
    trr.appendChild(td2);
	trr.appendChild(td3);
    td3.appendChild(box1);
    ni.appendChild(trr);
	$('input_count').value=parseInt(count)+1
}

function view_image_information(id)
{
 $('view_image_infomation').show();
	if ($('popup_manager'))
	{
	pars = "id=" + id + '&authenticity_token=' + window._token+ '&popup_manager=' +$('popup_manager').value
    }
    else
    {
    pars = "id=" + id + '&authenticity_token=' + window._token
    }
    
    var myajax = new Ajax.Updater('view_image_infomation', '/admin/image_details/view_image_information', {
        method: 'post',
        asynchronous: true,		
        parameters: pars
		
    });
}

function view_author_image_information(id,title)
{
 $('view_image_infomation').show();
	if ($('popup_manager'))
	{
	pars = "id=" + id + '&title=' + title+ '&popup_manager=' +$('popup_manager').value
    }
    else
    {
    pars = "id=" + id + '&title=' + title
    }
     jQuery.ajax({
       type: 'POST',
 data: pars,
url: '/admin/image_details/view_image_information',
 success: function(data){
 	jQuery("#view_image_infomation").html(data);
 }
    });
}


/*function view_author_image_information(id,title)
{
 $('view_image_infomation').show();
	if ($('popup_manager'))
	{
	pars = "id=" + id + '&title=' + title+ '&popup_manager=' +$('popup_manager').value
    }
    else
    {
    pars = "id=" + id + '&title=' + title
    }
    
    var myajax = new Ajax.Updater('view_image_infomation', '/admin/image_details/view_image_information', {
        method: 'post',
        asynchronous: true,		
        parameters: pars
		
    });
}
*/


/*function update_image_information()
{
	var id=$("image_id").value;
	var title=$("image_title").value;
	var alt_tag=$("image_alt_tag").value;
	var tag_name=$("image_tag").value;
	var image_name=$("image_image_name").value;
	var licence_type=$("image_licence_type").value;
	pars = "id=" + id + '&image[title]=' + title+ '&image[tag]=' + tag_name+ '&image[alt_tag]=' + alt_tag+ '&image[image_name]=' + image_name+ '&image[licence_type]=' + licence_type+ '&authenticity_token=' + window._token
	
    var myajax = new Ajax.Request('/admin/image_details/update_image_information', {
        method: 'post',
        asynchronous: true,
		evalScripts: true,
        parameters: pars
		
    });
}
function load_coursol()
{
	
   
 
  
}
function cancel_image_information()
{
	

	pars =  '&authenticity_token=' + window._token
	
    var myajax = new Ajax.Request('/admin/image_details/image_library', {
        method: 'post',
        asynchronous: true,
		evalScripts: true,
        parameters: pars,
		onComplete:load_coursol
    });
}

function show_view_information(id)
{
	$("library_img_"+id).style.display="block"

}
function hide_view_information(id)
{
	
	$("library_img_"+id).style.display="none"

}*/

function image_search(order_by)
{
 var image_name=$("image_detail_search_name").value; 
 var created_by=$("image_detail_search_created_by").value;
 var site_id=$("image_detail_search_site_id").value;
 if (order_by=="date")
 {
 order_by="updated_at desc"
 }
 if (order_by=="name")
 {
 order_by="image_name"
 } 
 var site_id=$("image_detail_search_site_id").value;
 var from=$("image_detail_search[from]").value;	
 var to=$("image_detail_search[to]").value;
 var title=$("path_title").value;
  if ($("set_flag1")==null)
  {
  var flag=""
  }
  else
  {
  var flag=$("set_flag1").value;
  }
 var path=$("path_flag").value;
 pars =  '&image_detail_search[name]=' + image_name+ '&image_detail_search[created_by]=' + created_by+ '&flag=' + flag+ '&path=' + path+ '&image_detail_search[site_id]=' + site_id+ '&image_detail_search[from]=' + from+ '&image_detail_search[to]=' + to+ '&image_detail_search[order_by]=' + order_by+ '&title=' + title


	
	var myajax = new Ajax.Request('/admin/image_details/imageset_list', {
			method: 'get',
			asynchronous: true,
			evalScripts: true,			
			parameters: pars
		});
	
	
}

/*function search_by_size()
{
	{
	
	var image_size=$("image_detail_image_size").value;	
	pars = '&image_size=' + image_size+ '&authenticity_token=' + window._token	
    var myajax = new Ajax.Updater('view_image', '/admin/image_details/search_by_size', {
        method: 'post',
        asynchronous: true,
		evalScripts: true,
        parameters: pars,
		onComplete:load_coursol
    });
}
}*/

function crop_image(id)
{
    pars = "id=" + id + '&authenticity_token=' + window._token
    var myajax = new Ajax.Updater('view_image', '/admin/image_details/crop_image', {
        method: 'get',
		evalScripts: true,
        asynchronous: true,
        parameters: pars
    });
}

function crop_image_information()
{
	document.crop.submit();
}

function image_to_trash(obj)
{
	
	var x=obj.up('li');
    var y=$('trash_image');
    y.appendChild(x);
}

function slideshow_search()
{
	
	document.slideshow_search.submit();
}

function advanced_search()
{
$('advance_search').href="javascript:advance_search_showhide();"
   var myajax = new Ajax.Updater('search_form', '/admin/articles/advance_search_view', {
        method: 'get',
		evalScripts: true
    });
}
function indicator_hide() {
$('plus_img').hide();

$('indicator_as_show').hide();
}
function advance_search_showhide()
{
$('advance_search').href="javascript:advanced_search();"
$('search_form').update("");
}
function indicator_show(){
$('indicator_as_show').show();
}
function article_advanced_search()
{
    document.multi_advance_search.submit();
}
function submit_survey_option(){
    document.multi_edit_option.submit();
}
function submit_survey_analyze(){
    document.multi_survey_answer.submit();
}
function forgot_password(){
	    document.multi.submit();
 }

// jQuery('#login-submit').submit;

function create_pick_of_the_month(){
    var dragged_image = $$('#droparea li img[name="image_drag"]')    
    var images = new Array();
    for (var i = 0; i < dragged_image.length; i++) {
        images += dragged_image[i].id + ",";        
    }    
    pars = "image_id=" + images  + '&authenticity_token=' + window._token;
	document.pick_of_the_month.action = "/admin/image_details/save_pick_of_the_month?" + pars;
    document.pick_of_the_month.submit();
}
function show_search_page()
{
	
	pars ='authenticity_token=' + window._token;
	 var myajax = new Ajax.Updater('image_search_upload12', '/admin/image_details/show_search_page', {
        	method: 'post',
			asynchronous: true,			
			parameters: pars
    });
}
function show_upload_page(image_sequence_id,image_ids,action)
{
	
	var dragged_image = $$('#droparea li img[name="image_drag"]')    
    var images = new Array();
    for (var i = 0; i < dragged_image.length; i++) {
        images += dragged_image[i].id + ",";
		
    }  
	pars ='authenticity_token=' + window._token+'&image_sequence_id=' + image_sequence_id+'&image_ids=' + images+'&set[flag]=' + action;
	 var myajax = new Ajax.Updater('image_search_upload12', '/admin/image_details/show_upload_page', {
        	method: 'post',
			asynchronous: true,			
			parameters: pars
    });
}

function show_image_library()
{
	var dragged_image = $$('#droparea li img[name="image_drag"]')    
    var images = new Array();
    for (var i = 0; i < dragged_image.length; i++) {
        images += dragged_image[i].id + ",";        
    }    
	pars ='authenticity_token=' + window._token+'&image_ids=' + images+'&flagger=slideshow' 
	 var myajax = new Ajax.Request( '/admin/image_details/show_image_library', {
        	method: 'post',
			asynchronous: true,	
			evalScripts: true,		
			parameters: pars
    });
}
function add_image(obj,id)
{	    

	var x=obj.up('li');
    var y=$('droparea');
    y.appendChild(x);
	
	 Sortable.create('droparea', {containment: ['droparea'],
            dropOnEmpty: true,
            tag: 'li',
            overlap: 'horizontal',
            constraint: false
        }); 

}

function pick_of_the_day(obj,id)
{
	$("library_img_"+id).style.display="none"	 
	$('droparea').update(obj.up('li'));
}
function show_apply_button()
{
	document.getElementById('apply_button').style.display="block"	
}

function submit_role_assign(){
    document.role_assign.submit();	
}
function edit_role_assign(assigned_id){
    document.role_edit_assigned_id.submit();	
}

function search_role(){
    params = '&roles_search[name]=' + $('search_data_name').value
    new Ajax.Request('/admin/roles/search', { evalScripts:true, method: 'get', parameters: params});
}

function my_setting_changes(){
    document.multi_user.submit();
    
}
function creating_version_of_image(type,image_id)
{
 pars ='authenticity_token=' + window._token+'&logical_name='+type+'&image_id='+image_id
	 var myajax = new Ajax.Request('/admin/image_details/creating_version_of_image', {
        	method: 'post',
			asynchronous: true,	
			evalScripts: true,		
			parameters: pars
    });	

	
}
function upload_new_version_image(logical_name,image_id)
{
	pars = "logical_name=" + logical_name+"&image_id="+image_id
	document.upload_form.action = "/admin/image_details/upload_version_image?" + pars;
    document.upload_form.submit();
}
function select_default_version_image(id)
{
	document.upload_form.action = "/admin/image_details/select_default_version_image?id="+id;
    document.upload_form.submit();
}
function show_dashboard_result(id){	
    document.multi.action = "/admin/login/dashboard"
    document.multi.submit()
}

function anoncement_save(){
var formval = "";
formval += document.anouncement_creation.anouncement_topic.value;
formval += document.anouncement_creation.anouncement_message.value;
if (formval != "") {
	
var formdata = $('form').serialize();

$.ajax({
	url: '/admin/users/announcement_create',
	data: formdata,
	type: 'POST',
	datatype: 'text',
	success: function(msg){
		 $('.validation_box').text(msg);
		 setTimeout(function(){window.close()}, 2000);
	},
	error: function(msg){
		 $('.validation_box').text(msg);
	}
});
} else {
	alert("Please enter a topic or a message");
	}
}
function create_bookmark_box(){
    var numi = $('theValue');
    var num = ($('theValue').value - 1) + 2;
    numi.value = num;
    id = num
    name = "bookmark[bookmark_name][]"
    value = ""
    var tr = new Element('tr')
    var td = new Element('td')
    var label = new Element('label')
    var span= new Element('span',{'class':'left_label'})
	span.innerHTML = 'Bookmark' + num
	var span1= new Element('span',{'class':'right_label'})
	span1.innerHTML = ":"
	var td1 = new Element('td')
	var box = new Element('input', {
        id: id,
        name: name,
        value: value,
        'class': 'textBoxWidth'
    })
    var td2 = new Element('td')
    var label1 = new Element('label')
    id1 = num
    name1 = "bookmark[url_path][]"
    value1 = ""
    var box1 = new Element('input', {
        id: id1,
        name: name1,
        value: value1,
        'class': 'textBoxWidth'
    })
	var td3 = new Element('td')
	var span2= new Element('span',{'class':'left_label'})
	span2.innerHTML = 'Url Path' + num
	var span3= new Element('span',{'class':'right_label'})
	span3.innerHTML = ":"
	tr.appendChild(td)
    td.appendChild(label)
    label.appendChild(span)
	label.appendChild(span1)
	tr.appendChild(td1)
	td1.appendChild(box)
    tr.appendChild(td2)
    td2.appendChild(label1)
	label1.appendChild(span2)
	label1.appendChild(span3)
    tr.appendChild(td3)
	td3.appendChild(box1)
	Insertion.Bottom('myfield',tr); 
}

function bookmark_del_option(id){
    var new_id = id.split("_").last()
	$(id).remove();
	pars = "id=" + new_id + '&authenticity_token=' + window._token
    var myajax = new Ajax.Request('/admin/users/remove_bookmark', {
        method: 'post',
        parameters: pars
    });
}

function announcement_del_option(id){
	var new_id = id.split("_").last()
	$(id).remove();
	pars = "id=" + new_id + '&authenticity_token=' + window._token
    var myajax = new Ajax.Request('/admin/users/remove_anouncement', {
        method: 'post',
        parameters: pars
    })
}


function show_result_for_advance_search(id){
	document.multi_advance_search.action = "/admin/articles/advance_search"
	document.multi_advance_search.submit()
}

function load_image()
{
  var id=$('image_detail_id').value;
  pars = "image_id=" + id
  document.image.action = "/admin/image_details/load_image?"+ pars;
  document.image.submit();
}
function set_image_width()
{
  value=$('resize_width').value;
  value1=$('resize_height').value;	
  size="valid"
  if ((value == "" || !value.toString().match(/^[-]?\d*\.?\d*$/)) || (value1 == null || !value1.toString().match(/^[-]?\d*\.?\d*$/)))
  {
  	 size="not-valid"
  }
  if ((value1 == "" || !value1.toString().match(/^[-]?\d*\.?\d*$/)))
  {
  	 size="not-valid"
  }
  if (size=="valid")
  {
    document.image.action = "/admin/image_details/set_image";
    document.image.submit();
  }
  else
  {
  	alert("Entered Target size is not valid or empty");
  }
}

function save_size_image()
{
  value=$('resize_width').value;
  value1=$('resize_height').value;	
  size="valid"
  if ((value == "" || !value.toString().match(/^[-]?\d*\.?\d*$/)) || (value1 == null || !value1.toString().match(/^[-]?\d*\.?\d*$/)))
  {
  	 size="not-valid"
  }
  if ((value1 == "" || !value1.toString().match(/^[-]?\d*\.?\d*$/)))
  {
  	 size="not-valid"
  }
  if (size=="valid")
  {    
    document.image.submit();
	
  }
  else
  {
  	alert("Entered Target size is not valid or empty");
  }
}

function popup_image_copyto(id)
{
	 w='300'
	 h='300'
	 cl = screen.width/2- (w/2);
     ct = screen.height/2 - (w/2);	
	var win_options ="location=no,scrollbars=no,menubars=no,toolbars=no,resizable=yes" +",left=" + cl + ",top=" + ct + ",width=" + 300 + ",height=" + 300;
    window.open("/admin/image_details/copyto?id=" + id, "terms", win_options).focus();
}

function show_result_for_advance_search(id)
{
    document.multi_advance_search.submit()
}
function show_result_for_static(id)
{
	document.multi_advance_search.action = "/admin/articles/static_articles"
    document.multi_advance_search.submit()
}
function show_result_for_dynamic(id)
{
	document.multi_advance_search.action = "/admin/articles/dynamic_articles"
    document.multi_advance_search.submit()
}
function show_dashboard_search_result(id){	
    document.multi_advance_search.action = "/admin/login/dashboard/"+$(id).value+"/"
    document.multi_advance_search.submit()
}
function save_version_image()

{	
	document.image.submit();
	parent.location.reload();
}
function resize_image()
{
	
	$('image_width').value=$('res1').width;
	$('image_height').value=$('res1').height;
	document.resize_form.submit();	
	
}

function upload_alternate_image(upd,id,image_type)
{
	  pars = "id=" + id + '&image_type=' + image_type
	  new Ajax.Updater(upd, '/admin/image_details/upload_alternate_image', {
        asynchronous: true,
        evalScripts: true,
        method: 'post',
        parameters: pars
    });
}
function set_image_width_height()
{
	$('res1').style.width=$("image_width").value;
	$('res1').style.height=$("image_height").value;
}
function comment_status(id,status)
{
	 pars = "id=" + id + '&comment_status=' + status
	 new Ajax.Request('/admin/comments/update_comment_status', {
        asynchronous: true,
        evalScripts: true,
        method: 'post',
        parameters: pars
    });
}
function user_popup(id)
{
	
	newwindow=window.open('/admin/users/assign_role/'+id,'mywindow','width=700,height=500,');
	if (window.focus) {newwindow.focus()}
	return false;

}
function show_user_generated_result(id){	
    document.user_generated.action = "/admin/user_generated/user_generated/"
    document.user_generated.submit()
}
function show_comment_moderation_result(id){	
    document.user_generated.action = "/admin/user_generated/comment_moderation/"
    document.user_generated.submit()
}
function poll_perpage(){	
    document.multi.action = "/admin/polls/list"
    document.multi.submit()
}

function imageset_perpage(per_page,action){	
    if (action=="list")
    {
    document.multi.action = "/admin/image_details/imageset_list?per_page="+per_page.value
    }
    if (action=="tinymce")
    {
    document.multi.action = "/admin/image_details/show_image_list?per_page="+per_page.value
    }
    if (action=="popup_manager")
    {
    document.multi.action = "/admin/image_details/popup_image_manager?per_page="+per_page.value
    }
    
    document.multi.submit()
}
function ranked_perpage(){	
    document.multi.action = "/admin/ranked_list/list"
    document.multi.submit()
}
/*function image_popup()
{
    newwindow=window.open('/admin/image_details/popup_image_manager/','mywindow','width=967,height=580,scrollbars=yes');
	if (window.focus) {newwindow.focus()}
	return false;
}*/
function debate_image_popup()
{
    newwindow=window.open('/admin/image_details/popup_image_manager?title=debate','mywindow','width=967,height=580,scrollbars=yes');
	if (window.focus) {newwindow.focus()}
	return false;
}
function debate_contributor_image_popup()
{
    newwindow=window.open('/admin/image_details/popup_image_manager?title=debate_contributor','mywindow','width=967,height=580,scrollbars=yes');
	if (window.focus) {newwindow.focus()}
	return false;
}
function debate_sponsor_image_popup()
{
    newwindow=window.open('/admin/image_details/popup_image_manager?title=debate_sponsor','mywindow','width=967,height=580,scrollbars=yes');
	if (window.focus) {newwindow.focus()}
	return false;
}
function competition_image_popup()
{
    newwindow=window.open('/admin/image_details/popup_image_manager?title=Competition','mywindow','width=967,height=580,scrollbars=yes');
	if (window.focus) {newwindow.focus()}
	return false;
}

function edit_image_popup(id)
{
	
    newwindow=window.open('/admin/image_details/edit_imageset/?flag=popup&id='+id,'mywindow','width=1067,height=600,scrollbars=yes');
	if (window.focus) {newwindow.focus()}
	return false;
}

function author_image_popup()
{
    newwindow=window.open('/admin/image_details/popup_image_manager?title=author','mywindow','width=967,height=580,scrollbars=yes');
	if (window.focus) {newwindow.focus()}
	return false;
}

function company_logo_popup()
{
    newwindow=window.open('/admin/image_details/popup_image_manager?title=company_logo','mywindow','width=967,height=580,scrollbars=yes');
	if (window.focus) {newwindow.focus()}
	return false;
}


function digital_asset_popup()
{
    newwindow=window.open('/admin/digital_assets/popup_digital_asset_manager/','mywindow','width=967,height=580,scrollbars=yes');
	if (window.focus) {newwindow.focus()}
	return false;
}


function select_image(image,image_path,thumbnail_path,image_id,title,caption)

{
	
      confirmed = window.confirm("Do you want to make this image as title image");

if (confirmed)
{
	var visitorName = " ";
    var myOldString = caption
    cap=myOldString.replace(/\+/g, visitorName);	
	capt=unescape(cap)
    var img_pre="<table class='title_image_table'><tr><td><img src="+thumbnail_path+" "+" alt= /></td><td>Caption:<br/>"+capt+"</td></tr></table>"
    opener.$('no_image').hide();
    opener.$('change_link').hide();
    opener.$('imageset_caption').show();
    opener.$('change_link123').show();
	if (opener.$('set_preference') != null) {
		opener.$('set_preference').show();
	}
	opener.$('prev').show();
     if (opener.$('gen_image')!=null)
    {
    opener.$('gen_image').hide();
   
    }    
    opener.$('prev').update(img_pre); 
    opener.$('image_property_image_id').value=image_id;    
	parent.close();
} 
else 
{
  
}
}

function set_preference() {
$('preference_setup').show();
}

function customise_image(){
if ($('cust_img').checked == true){
$('image_customise').show();
}
else{
$('image_customise').hide();
}
$('dont_display').checked=false;
$('dont_display').name="rm"
$('cust_img').name="article[image_property][display_preference]"
}

function hide_customise_image(){
$('image_customise').hide();
$('dont_display').name="article[image_property][display_preference]"
$('cust_img').checked=false;
$('cust_img').name="rm"
}
function select_author_image(image,image_path,thumbnail_path,image_id,title,caption)

{
      confirmed = window.confirm("Do you want to make this image as title image");

if (confirmed)
{
    var img_pre='<table><tr><td><img src='+thumbnail_path+' '+' alt= /></td></tr></table>'
    opener.$('no_image').hide();
    opener.$('change_link').hide();
    
    opener.$('change_link123').show();
    opener.$('prev').show();
     if (opener.$('gen_image')!=null)
    {
    opener.$('gen_image').hide();
   
    }    
    opener.$('prev').update(img_pre); 
    opener.$('image_property_image_id').value=image_id;    
	parent.close();
} 
else 
{
  
}
}

function select_company_logo_image(image,image_path,thumbnail_path,image_id,title,caption)

{
      confirmed = window.confirm("Do you want to make this image as company logo image");

if (confirmed)
{
    var img_pre='<table><tr><td><img src='+thumbnail_path+' '+' alt= /></td></tr></table>'
    opener.$('no_image_company_logo').hide();
    opener.$('change_link_company_logo').hide();
    
    opener.$('change_link123_company_logo').show();
    opener.$('prev_company_logo').show();
     if (opener.$('gen_image_company_logo')!=null)
    {
    opener.$('gen_image_company_logo').hide();
   
    }    
    opener.$('prev_company_logo').update(img_pre); 
    opener.$('company_logo_image_id').value=image_id;    
	parent.close();
} 
else 
{
  
}
}


function select_audio(audio_id,audio_name)

{
opener.$('prev_audio').show();
     if (opener.$('gen_audio')!=null)
    {
    opener.$('gen_audio').hide();
   
    }    
    var img_pre='<table><tr><td><img src=/images/music.png alt= / width=60 height=60></td></tr><tr><td>'+audio_name+'</td></tr></table><a href="javascript:void(0);" onClick="remove_audio()">Remove</a>'
    opener.$('prev_audio').update(img_pre);
    opener.$('no_audio').hide();        
    opener.$('article_audio_id').value=audio_id;    
	parent.close();
} 



function remove_image()
{
$('prev').hide();
$('no_image').show();
$('change_link').show();
if ($('set_preference')!=null)
{
	$('set_preference').hide();
	$('preference_setup').hide();
    $('image_customise').hide();
}
 
if ($('imageset_caption') != null) {
	$('imageset_caption').hide();
}
 $('change_link123').hide();
 if ($('gen_image')!=null)
    {
   $('gen_image').hide();
   
    }   
$('image_property_image_id').value="";
if ($('imageset_caption') != null) {
	$('image_property_caption').value = "";
}
}

function remove_company_logo_image()
{
$('prev_company_logo').hide();
$('no_image_company_logo').show();
$('change_link_company_logo').show();

 $('change_link123_company_logo').hide();
 if ($('gen_image_company_logo')!=null)
    {
   $('gen_image_company_logo').hide();
   
    }   
$('image_property_image_id').value="";

}

/*function submit_media(){	
  video_path = $('media_detail_video_path').value

  if (video_path == undefined)
  {
      alert("Video path Can't be blank");
       return false;
  }
  
    // $("upload-indicator").show()
      document.media_multi.submit();
}
*/
function ranked_perpage(){	
 
    document.multi.submit()
}
function get_image_info(filename){
   //alert(filename);
   pars = "id=" + filename;
       var myajax = new Ajax.Updater('updated_image', '/admin/media_details/show_selected_image', {
           method: 'get',
           parameters: pars
       });
} 
function media_search(){
   $('media_search').style.display = "block";   } 
   
function video_popup()
{
    newwindow=window.open('/admin/media_details/popup_media_manager/','mywindow','width=970,height=630,resizable=yes');
	if (window.focus) {newwindow.focus()}
	return true;
}   

function audio_popup()
{
    newwindow=window.open('/admin/media_details/popup_audio_manager/','mywindow','width=870,height=830,resizable=yes');
	if (window.focus) {newwindow.focus()}
	return false;
}   

function play_video(id,name,video_path)
{
       pars =  '&id=' + id+ '&name=' + name+ '&value=' + video_path
       var myajax = new Ajax.Updater('video_ply', '/admin/media_details/media_videoplay', {
           method: 'get',
           parameters: pars
       });

}

function select_video(video_id,thumbnail_path)
{
   opener.$('prev_video').show();
    var img_pre='<img src='+thumbnail_path+' '+' alt= />&nbsp;&nbsp;<a href="javascript:void(0);" onClick="remove_video()">Remove</a>'
    if (opener.$('gen_video')!=null)
    {
    opener.$('gen_video').hide();
   
    }
     opener.$('no_video').hide();
    opener.$('prev_video').update(img_pre); 
    
    opener.$('article_media_detail_id').value=video_id;
	window.close();

}

function remove_video()
{
if ($('gen_video')!=null)
    {
    $('gen_video').hide();
   
    }
    $('article_media_detail_id').value=""
 $('prev_video').hide();
 $('no_video').show();
}

function remove_audio()
{
if ($('gen_audio')!=null)
    {
    $('gen_audio').hide();
   
    }
    $('article_audio_id').value=""
 $('prev_audio').hide();
 $('no_audio').show();
}

/*function show_diff_submit(default_version,article_id,from){
    var total_version=document.getElementsByClassName('article_diff_checkbox').length
    selected_versions=0;
    var selected_check_box_index = new Array;
    pars="article_id=" + article_id + "&"
    var win_options = "toolbar=no,addressbars=yes,scrollbars=yes,width=1050px,height=700,resizable=yes ";
    for (i = 0; i < total_version; i++) {
        if (document.getElementsByClassName('article_diff_checkbox')[i].checked) {
            pars =pars + "version_"+(selected_versions+1)+"="+document.getElementsByClassName('article_diff_checkbox')[i].value + "&"
            selected_check_box_index[selected_versions]= i
            selected_versions=selected_versions+1;

        }
    }
       if (selected_versions == 2 && total_version!=1)
        {
          window.open("/admin/articles/show_diff?"+ pars, win_options).focus();
         }
       else if (selected_versions == 1 && total_version!=1)
        {
            if (selected_check_box_index[0]==0 && from=="current")
             {  alert("Please select other than current version");   }
             else if((selected_check_box_index[0] == (total_version-1)) && from =="previous")
             {  alert("Please select other than first version"); }
             else
             {
               var index=0;
               if (from =="previous")
               {
                index=selected_check_box_index[0]+1;
                }
                pars =pars + "version_"+(selected_versions+1)+"="+document.getElementsByClassName('article_diff_checkbox')[index].value + "&"
                window.open("/admin/articles/show_diff?"+ pars, win_options).focus();
             }
        }
       else {
           alert("To See the difference you need atleast two version");
        }
} */

function show_diff_submit(default_version,article_id,from){
    var total_version=jQuery("#multis .article_diff_checkbox").length;
    var selected_versions=0;
    var selected_check_box_index = new Array();
    var pars="article_id=" + article_id + "&"
    var win_options = "toolbar=no,addressbars=yes,scrollbars=yes,width=1050px,height=700,resizable=yes ";
    $("#multis .article_diff_checkbox:checked").each(function(i){
      pars += "version_"+(selected_versions+1)+"="+jQuery(this).attr("value") + "&";
      selected_check_box_index[selected_versions]= i
      selected_versions=selected_versions+1;
    });
     if(selected_versions == 2 && total_version!=1){
          window.open("/admin/articles/show_diff?"+ pars, win_options).focus();
     }
     else if (selected_versions == 1 && total_version!=1){
        if (selected_check_box_index[0]==0 && from=="current"){ 
            alert("Please select other than current version"); 
        }
        else if((selected_check_box_index[0] == (total_version-1)) && from =="previous"){
          alert("Please select other than first version"); 
        }
        else{
          var index=0;
          if (from =="previous"){
            index=selected_check_box_index[0]+1;
          }
            pars += "version_"+(selected_versions+1)+"="+ $(".article_diff_checkbox:eq("+index+")").attr("value") + "&"
            window.open("/admin/articles/show_diff?"+ pars, win_options).focus();
        }
    }
    else {
           alert("To See the difference you need atleast two version");
    }
}


function assign_version(article_id,article_content_id){
    pars="selected_version="+ article_content_id,
    opener.document.article.action="/admin/articles/assign_version/"+article_id+"?"+pars
    opener.document.article.submit();
    parent.close();
}

function submit_further_article()
{
  var d = parent.$('further_reading').update('');  
  s=Sortable.serialize('listTaken').split('&');
  var myCars=new Array();  
    for (i=0;i<=s.length;i++)
        {
            if (s[i]!=null)
            {
                var y=i+1;
                myCars[i]=s[i].split("=")[1];
                var box2 ='<input type="hidden" value="'+s[i].split("=")[1]+'" name="article[article_further_reading_ids][]" id="article_content_sub_title" class="textBoxWidth"/>'
                parent.$('further_reading').insert(box2);
            }
        }

parent.Lightview.hide();
}

function submit_further_article_for_author()
{
	
  var d = parent.$('further_reading').update('');  
  s=Sortable.serialize('listTaken').split('&');
  var res=new String();
  var myCars=new Array();  
    for (i=0;i<=s.length;i++)
        {
            if (s[i]!=null)
            {
                var y=i+1;
                myCars[i]=s[i].split("=")[1];
				res +=s[i].split("=")[1]+','
                var box2 ='<input type="hidden" value="'+s[i].split("=")[1]+'" name="author[author_further_reading_ids][]" id="article_content_sub_title" class="textBoxWidth"/>'
                parent.$('further_reading').insert(box2);
            }
        }
parent.$('author_further_reading_ids').innerHTML=res;
parent.Lightview.hide();
}

function load_lightview(article_id)
{
    i=0;
    var myCars=new Array(); 
    $('further_reading').select('input').each(function(element){
        myCars[i]=element.value;
        i=i+1;
        });

    if (article_id=="new")
        {
            Lightview.show({href:'/admin/articles/further_reading?assign_id='+myCars,options: {fullscreen: true }});           
        }
    else
        {
            pars =  '&assign_id=' + myCars+ '&article_id=' + article_id            
            Lightview.show({href:'/admin/articles/further_reading?'+pars,options: {fullscreen: true  }});        
         }
}

function load_blog_lightview(article_id)
{
    i=0;
    var myCars=new Array();
    $('further_reading').select('input').each(function(element){
        myCars[i]=element.value;
        i=i+1;
        });

    if (article_id=="new")
        {
            Lightview.show({href:'/admin/articles/blog_further_reading?assign_id='+myCars,options: {fullscreen: true }});          
        }
    else
        {
            pars =  '&assign_id=' + myCars+ '&article_id=' + article_id           
            Lightview.show({href:'/admin/articles/blog_further_reading?'+pars,options: {fullscreen: true  }});       
         }
}

function load_author_lightview(author_id)
{
	
    i=0;
    var myCars=new Array(); 
    $('further_reading').select('input').each(function(element){
        myCars[i]=element.value;
        i=i+1;
        });

    if (author_id=="new")
        {
			
            Lightview.show({href:'/admin/author/further_reading?assign_id='+myCars,options: {fullscreen: true }});           
        }
    else
        {
            pars =  '&assign_id=' + myCars+ '&author_id=' + author_id            
            Lightview.show({href:'/admin/author/further_reading?'+pars,options: {fullscreen: true  }});        
         }
}



function fragment_action(){
    document.multi.action="/admin/articles/static_fragment_content"
    document.multi.submit()
}

function list_user_result(id){	
    document.multi.action = "/admin/users/list/"+$(id).value+"/"
    document.multi.submit()
}

function questionnaire_list(id){	
    document.multi.action = "/admin/questionnaires/questionnaire_list/"+$(id).value+"/"
    document.multi.submit()
}
function question_list_pagination(id){	
    document.multi.action = "/admin/questions/question_list/"+$(id).value+"/"
    document.multi.submit()
}

function add_static_article(article_path){    
    var path="http://"+article_path+"/admin/static_page/new?article_path=static_page"    
    var section_type=$('select_article_section_id').value;
    var z=path+"&section_type="+section_type
    $('static_page_link').writeAttribute('href',z);  
    $('static_page_link1').writeAttribute('href',z);  
   
}
function add_static_article1(article_path){    
    var path="http://"+article_path+"/admin/static_page/new?article_path=static_page"    
    var section_type=$('select_article1_section_id').value;
    var z=path+"&section_type="+section_type
    $('static_page_link').writeAttribute('href',z);  
    $('static_page_link1').writeAttribute('href',z);  
   
}

function show_media_search()
{
var video_name=$("media_details_name").value;
var created_at=$("media_details[created_at]").value;	
pars =  '&media_details[created_at]=' + created_at+ '&media_details[name]=' + video_name
var myajax = new Ajax.Request('/admin/media_details/search', {
			method: 'post',
			asynchronous: true,
			evalScripts: true,
			parameters: pars
		});

}

function submit_audio()
{
    document.audio_multi.submit();
}


function show_audio_search()
{

var video_name=$("audio_name").value;
var created_at=$("audio[created_at]").value;
if ($("flag")!=null)
{	
var flag=$("flag").value;
pars =  '&audio[created_at]=' + created_at+ '&audio[name]=' + video_name+'&flag=' + flag
}
else
{
pars =  '&audio[created_at]=' + created_at+ '&audio[name]=' + video_name
}


var myajax = new Ajax.Request('/admin/media_details/audio_search', {
			method: 'post',
			asynchronous: true,
			evalScripts: true,
			parameters: pars
		});

}
function update_image_information_in_hidden_field(id)
{
$("img"+id+"_alt_tag").value=$('image_alt_tag').value;	
 $('view_image_infomation').hide();
}


function user_search(){
    name = $('search_data_firstname').value
    email = $('search_data_email').value
    params = '&user[firstname]=' + name + '&user[email]=' + email
    var myajax = new Ajax.Request('/admin/users/search', { evalScripts:true, method: 'get', parameters: params});
}

function update_document(){
    document.asset_update.submit();
}


function directory_category_tree(){
    x = $('mytree').serializeTree('data[MenuItems]');
    
   // pars = "menu_id=" + x;
    //document.multi1.action = "/admin/directory_categories/reorder_directory_category?" + x;
    //document.multi1.submit();
    var myajax = new Ajax.Request('/admin/directory_categories/reorder_directory_category', {
        method: 'post',
        evalScripts: true,
        parameters: x
    });
}

function submit_subdirectory_category(){
    document.multi.action = "/admin/directory_categories/save_subdirectory_category"
    document.multi.submit();
}

function submit_directory_category(){
	        if ($('directory_category_name').value == "") {
            alert("Name field Should not be blank ");
                }
                else {
    				    document.multi.submit();
                }
}

function edit_directory_category(id){
    pars = "id=" + id;
    var myajax = new Ajax.Updater('edit_page', '/admin/directory_categories/edit', {
        evalScripts:true,
        method: 'get',
        parameters: pars
    });
}

function submit_directory_category1(){
    document.multi.action = "/admin/directory_categories/update"
    document.multi.submit();
}

function submit_subdirectory_category(){
    document.multi.action = "/admin/directory_categories/save_subdirectory_category"
    document.multi.submit();
}

function destroy_directory_category(){

    var x = document.getElementsByName("directory_category[id]");
    for (var n = 0; n < x.length; n++) {
        if (x[n].checked == true) {
            document.multi.action = "/admin/directory_categories/destroy?id=" + x[n].value;
            document.multi.submit();
            
        }
        
    }
}
function subdirectory_category_toggle(directory_category_id){
    Element.toggle(directory_category_id)
}


function upload_imageset()
{
          var image_path=jQuery('#image_detail_image_path').val();
	//	  alert(image_path);                
          var re_img_path = new RegExp("(.*?)\.(jpg|jpeg|png|gif|JPG|JPEG|PNG|GIF)$");          
          if (image_path!="")
           {
               if (!re_img_path.test(image_path))
               {              
               alert("Permissible image formats: gif,png,jpg");              
               }
               else
               {
                pars =  '&image[tag]=' + jQuery('#image_tag').val()+ '&image[caption]=' + jQuery('#image_caption').val()+ '&image[site_id]=' + jQuery('#image_site_id').val()+ '&image[licence_type]=' + jQuery("#image_licence_type").val()+ '&commit=Upload Image' ;
          //      alert(pars);
				document.upload_form.action = "/admin/image_details/save_imageset?"+ pars;
                document.upload_form.submit();
               }
           } 
           else
           {           
            alert("No image has been uploaded");             
           }
           
    
}

function upload_imagesetmetadata_step1()
{

        status=true
        var mes1=""
        var mes2=""
         var mes3=""
         var mes4=""
         var mes5=""
         var mes6=""
		 var mes7=""
        var image_name=$('image_image_name').value;
        re_img_name = new RegExp("^[0-9a-z-]+$");
        re_start_img_name = new RegExp("^[0-9a-z]");
		var licence_type = $('image_licence_type').value
		//alert(licence_type);
        if (image_name=="")
        {
          status=false
          mes1="Imageset name should not be blank"
         
        }       
        if (image_name!="")
        {
           if (!re_img_name.match(image_name))
               {
               status=false
               mes2="'Imageset Name' may only contain lower-case alphanumeric characters and dashes. It may not begin with a dash."
              
               } 
          if (!re_start_img_name.match(image_name))
               {
               status=false
                mes2="'Imageset Name' may only contain lower-case alphanumeric characters and dashes. It may not begin with a dash."
                
               }     
         }
         var alt_tag=$('image_alt_tag').value;
         re_img_alt_tag = new RegExp("^[0-9a-zA-Z-@\(\)&.' ]+$");
        if (alt_tag=="")
        {
         status=false
           mes4="Alt/Title should not be blank";
           
        }  
        if (alt_tag!="")
        {
            if (!re_img_alt_tag.match(alt_tag))
               {
               status=false
                mes5="Alt/Title should contains only alphabets,numbers,full stop,apostrophe,dash,@,() and &"
               
               } 
        
        }        
                if ($('id')==null)
        {
              status=false
             mes6="No image has been uploaded"
             
        }
		if(licence_type == "Choose type")
		{
			mes7 = "Please Select Licence Type"
		}
        if (status==true)
           {
               return true
           }
        else
        {
        var mes=""
        if (mes1!="")
        {
        mes=mes1+'\n'
        }
         if (mes2!="")
        {
        mes=mes+mes2+'\n'
        }
        if (mes3!="")
        {
        mes=mes+mes3+'\n'
        }
         if (mes4!="")
        {
        mes=mes+mes4+'\n'
        }
         if (mes5!="")
        {
        mes=mes+mes5+'\n'
        }
         if (mes6!="")
        {
        mes=mes+mes6+'\n'
        }
		if(mes7 != "")
		{
			mes=mes+mes7+'\n'
		}
        if (mes=="")
        {
        return true
        }
        else
        {        
      //  alert(mes)
        return false
        }
        }
           
}


function upload_alternateimage(arg)
{

          status="true"         
          var image_path=arg.down('input').value;          
          re_img_path = new RegExp("(.*?)\.(jpg|jpeg|png|gif|JPG|JPEG|PNG|GIF)$"); 
          if (image_path=="")
          {        
          alert("No image has been uploaded");         
          }
           if (image_path!="")
           {
               if (!re_img_path.match(image_path))
               {              
               alert("Permissible image formats: gif,png,jpg")              
               }
               else
               {
                pars =  '&image[tag]=' + $('image_tag').value+ '&image[caption]=' + $('image_caption').value+ '&image[site_id]=' + $('image_site_id').value+ '&image[licence_type]=' + $("image_licence_type").value;
                
                $("upload_form").action = "/admin/image_details/upload_new_imageset?"+ pars;
                $("upload_form").submit();
               }
           } 
      

}

function upload_alternateimage_right(arg)
{

          status="true"         
          var image_path=arg.down('input').value;          
          re_img_path = new RegExp("(.*?)\.(jpg|jpeg|png|gif|JPG|JPEG|PNG|GIF)$"); 
          if (image_path=="")
          {        
          alert("No image has been uploaded");         
          }
           if (image_path!="")
           {
               if (!re_img_path.match(image_path))
               {              
               alert("Permissible image formats: gif,png,jpg")              
               }
               else
               {
                pars =  '&image[tag]=' + $('image_tag').value+ '&image[caption]=' + $('image_caption').value+ '&image[site_id]=' + $('image_site_id').value+ '&image[licence_type]=' + $("image_licence_type").value;
                
                $("upload_form_right").action = "/admin/image_details/upload_new_imageset?"+ pars;
                $("upload_form_right").submit();
               }
           } 
      

}



function upload_metadatstep2()
{

 status=true
 var mes1=""
        var mes2=""
         var mes3=""
         var mes4=""
         var mes5=""
         var mes6=""
        var image_name=$('image_image_name').value;
        re_img_name = new RegExp("^[0-9a-z-]+$");
        re_start_img_name = new RegExp("^[0-9a-z]");
        if (image_name=="")
        {
         status=false
          mes1="Imageset name should not be blank"
         
        }       
        if (image_name!="")
        {
           if (!re_img_name.match(image_name))
               {
               status=false
               mes2="'Imageset Name' may only contain lower-case alphanumeric characters and dashes. It may not begin with a dash."
               
               } 
          if (!re_start_img_name.match(image_name))
               {
               status=false
               mes2="'Imageset Name' may only contain lower-case alphanumeric characters and dashes. It may not begin with a dash."
              
               }     
         }
         var alt_tag=$('image_alt_tag').value;
         re_img_alt_tag = new RegExp("^[0-9a-zA-Z-@\(\)&.' ]+$");
        if (alt_tag=="")
        {
         status=false
          mes4="Alt/Title should not be blank"
         
        }  
        if (alt_tag!="")
        {
            if (!re_img_alt_tag.match(alt_tag))
               {
               status=false
           mes5="Alt/Title should contains only alphabets,numbers,full stop,apostrophe,dash,@,() and &"
              
               } 
        
        }
        
        if (status==true)
           {
              return true
           }
         else
         {
         var mes=""
        if (mes1!="")
        {
        mes=mes1+'\n'
        }
         if (mes2!="")
        {
        mes=mes+mes2+'\n'
        }
        if (mes3!="")
        {
        mes=mes+mes3+'\n'
        }
         if (mes4!="")
        {
        mes=mes+mes4+'\n'
        }
         if (mes5!="")
        {
        mes=mes+mes5+'\n'
        }
         if (mes6!="")
        {
        mes=mes+mes6+'\n'
        }
        
        if (mes=="")
        {
        return true
        }
        else
        {
     //   alert(mes)
        return false
        }
       }          
}



function change_asset_type1(type){
    if (type.value==""){
        $('asset_type1').writeAttribute('href','/admin/authentication/new_asset?type=Article');      
    }    
    else {
        $('asset_type1').writeAttribute('href','/admin/authentication/new_asset?type='+type.value);  
    }
}

function change_asset_type2(type){
    if (type.value==""){
        $('asset_type2').writeAttribute('href','/admin/authentication/new_asset?type=Article');      
    }    
    else {
        $('asset_type2').writeAttribute('href','/admin/authentication/new_asset?type='+type.value);  
    }
}
function change_product_type(type){
        if (type.value == "Authorized"){
            $$('.'+type.value).invoke("show")
            $$('.Questionnaires').invoke("hide")
        }
        else {
            if (type.value == "Questionnaires"){
                $$('.'+type.value).invoke("show")
                $$('.Authorized').invoke("hide")
            }
        }     
}

function res(id,ht,wd,to,from){
var answer = true
if (ht < 500 || wd < 500)
{
  answer = confirm("Your image is of lower resolution than the recommended 500px - do you want to continue ?")
   
 }
  window.location = "/admin/image_details/" + ((answer) ? to + "/" + id : from) ;
}

function selected_image(id)

{
pars = "id=" + id
 var myajax = new Ajax.Updater('view_image_infomation', '/admin/image_details/selected_image', {
        method: 'post',
        asynchronous: true,		
        parameters: pars
		
    });
}
function ser(id,width,height,image_type,path)
{
	
    pars = "id=" + id + '&width=' + width+ '&height=' +height+ '&image_type=' +image_type+ '&path=' +path;   
    var myajax = new Ajax.Updater('view_image_infomation', '/admin/image_details/select_inline_image', {
        method: 'post',
        asynchronous: true,		
        parameters: pars
		
    });
}

function select_image_for_gallery(id)
{
$('view_image_infomation').show();

    pars = "id=" + id ;
   
    var myajax = new Ajax.Updater('view_image_infomation', '/admin/image_details/select_image_for_gallery', {
        method: 'post',
        asynchronous: true,		
        parameters: pars
		
    });

}

function add_image_to_gallery()
{
if ($('slideshow_id')!=null)
{

pars = "id=" + $('img_id').value+'&slideshow_id=' + $('slideshow_id').value ;
}
else
{
pars = "id=" + $('img_id').value ;
}


 var myajax = new Ajax.Updater('add_imageset_to_gallery', '/admin/image_details/add_image_to_gallery', {
        method: 'post',
        evalScripts: true,
        asynchronous: true,		
        parameters: pars
		
    });
}
function assets_title_image(asset_id,flag){
	
    pars = "id=" + asset_id +"&title_document="+flag
    var myajax = new Ajax.Updater('assets_information_upload', '/admin/digital_assets/asset_details', {
        method: 'get',
        parameters: pars
    });
}


function select_document(document_name,document_path,document_image_path,document_id)
{
      confirmed = window.confirm("Do you want to make this Document as title document");
if (confirmed)
{
    var img_pre='<table><tr><td><img src='+document_image_path+' '+' alt= /></td><td></td></tr></table>'
    opener.$('no_digital_asset').hide();
    opener.$('digital_asset_change_link').hide();
    opener.$('digital_asset_caption').show();
    opener.$('digital_asset_change_link123').show();
    opener.$('prev_document').show();
     if (opener.$('gen_digital_asset')!=null)
    {
    opener.$('gen_digital_asset').hide();
   
    }    
    opener.$('prev_document').update(img_pre); 
    opener.$('digital_asset_property_digital_asset_id').value=document_id;    
	parent.close();
} 
else 
{
  
}
}

/*function remove_digital_asset()
{
$('prev_document').hide();
$('no_digital_asset').show();
$('digital_asset_change_link').show();
$('digital_asset_caption').hide();
 $('digital_asset_change_link123').hide();
 if ($('gen_digital_asset')!=null)
    {
   $('gen_digital_asset').hide();
   
    }   
$('digital_asset_property_digital_asset_id').value="";
$('digital_asset_property_display_name').value="";
}
*/
/*function upload_standalone_image()
{
                var pars =  '&image[tag]=' + jQuery('#image_tag').val() + '&image[site_id]=' + jQuery('#standalone_site_id').val() + '&image[licence_type]=' + jQuery("#image_licence_type").value + '&commit=Upload Image' ;
                document.upload_form.action = "/admin/image_details/create_standalone_image?"+ pars;
                document.upload_form.submit();
                
}*/
function upload_standalone_image()
{
          var image_path=jQuery('#image_detail_image_path').val();                
          var re_img_path = new RegExp("(.*?)\.(jpg|jpeg|png|gif|JPG|JPEG|PNG|GIF)$");          
          if (image_path!="")
           {
               if (!re_img_path.test(image_path))
               {              
               alert("Permissible image formats: gif,png,jpg");              
               }
               else
               {
                var pars =  '&image[tag]=' + jQuery('#image_tag').val() + '&image[site_id]=' + jQuery('#standalone_site_id').val() + '&image[licence_type]=' + jQuery("#image_licence_type").val() + '&commit=Upload Image' ;
                var set_action = "/admin/image_details/create_standalone_image?"+ pars;
				jQuery("#upload_form").attr("action",set_action);
				jQuery("#upload_form").submit();
               }
           } 
           else
           {           
            alert("No image has been uploaded");             
           }
  
}

function create_standalone_image()
{

        var status=true
        var mes1=""
        var mes2=""
         var mes3=""
         var mes4=""
         var mes5=""
         var mes6=""
         var mes7=""
        var image_name=$('image_image_name').value;
        re_img_name = new RegExp("^[0-9a-z-]+$");
        re_start_img_name = new RegExp("^[0-9a-z]");
        if (image_name=="")
        {
          status=false
          mes1="Filename should not be blank"
         
        }       
        if (image_name!="")
        {
           if (!re_img_name.match(image_name))
               {
               status=false
               mes2="'Filename' Permitted characters:a-z, 0-9, dash."
              
               } 
          if (!re_start_img_name.match(image_name))
               {
               status=false
                mes2="Filename may only start with a-z,0-9."
                
               }     
         }
         var alt_tag=$('image_alt_tag').value;
         re_img_alt_tag = new RegExp("^[0-9a-zA-Z- ]+$");
        if (alt_tag=="")
        {
         status=false
           mes4="Alt/Title should not be blank";
           
        }  
        if (alt_tag!="")
        {
            if (!re_img_alt_tag.match(alt_tag))
               {
               status=false
                mes5="Alt/Title may only start with a-z,0-9"
               
               } 
        
        }      
         if ($('id')==null)
        {
              status=false
             mes6="No image has been uploaded"
             
        }
        if($('image_licence_type').value=="")
        {
             status=false
             mes7="Pick any one of licence type"
        }
        if (status==true)
           {
               return true
           }
        else
        {
        var mes=""
        if (mes1!="")
        {
        mes=mes1+'\n'
        }
         if (mes2!="")
        {
        mes=mes+mes2+'\n'
        }
        if (mes3!="")
        {
        mes=mes+mes3+'\n'
        }
         if (mes4!="")
        {
        mes=mes+mes4+'\n'
        }
         if (mes5!="")
        {
        mes=mes+mes5+'\n'
        }
         if (mes6!="")
        {
        mes=mes+mes6+'\n'
        }
         if (mes7!="")
        {
        mes=mes+mes7+'\n'
        }
        if (mes=="")
        {
        return true
        }
        else
        {        
     //   alert(mes)
        return false
        }
        }
           
}

function show_result_image_dropdown(path,per_page){	
    document.location.href= path + (path.match(/\?/) ? '':'?') + "&per_page="+per_page.value
}

function show_result_print_management(path,per_page){	
    document.location.href= path + (path.match(/\?/) ? '':'?') + "&per_page="+per_page.value
}

function toggleInline_standalone(id) {
var x = document.getElementById(id).style;
if (x.display == 'inline') x.display = 'none';
else x.display = 'inline';
return false;
} 
function generate_auto_tags(){
    var myStr=new String(tinyMCE.activeEditor.getContent()); 
    pars = "&article_content=" + escape(myStr)  
    var myajax = new Ajax.Updater("auto-tag", "/admin/articles/generate_auto_tags", {
        asynchronous: true,
        evalScripts: true,
        method: 'post',
        parameters: pars
    });
}

function check_for_date()
{
var from_date=new Date($('search_data[from_date]').value);
var to_date=new Date($('search_data[to_date]').value);


if (from_date>to_date)
  {
  alert("To date should be greater than from date");
  return false
  }
 else
 {
 return true
 }
}

function check_valid_date()
{
    var err_msg = [];
    if ($('search_data[from_date]').value!="" && new Date($('search_data[from_date]').value) ==  "Invalid Date")
    {
     err_msg.push("Invalid from date ");
    }
    if ($('search_data[to_date]').value!="" && new Date($('search_data[to_date]').value) ==  "Invalid Date")
    {
     err_msg.push("Invalid to date ");
    }
    if ($('search_data[date_of_publication]').value!="" && new Date($('search_data[date_of_publication]').value) ==  "Invalid Date")
    {
     err_msg.push("Invalid publication date");     
    }
     if ($('magazine_issue[date_of_publication]').value!="" && new Date($('magazine_issue[date_of_publication]').value) ==  "Invalid Date")
    {
     err_msg.push("Invalid publication date");     
    }
    if (err_msg.length>0)
    {
    alert(err_msg.join("\n"));
    return false
    }
    else
    {
    return true
    }
}

function save_tag_name(id,page,type,from)
	{
	pars = $H({ 'id': id , name: $('name_'+id).value, 'search_data[type]': type}).toQueryString()
	var myajax = new Ajax.Request('/admin/'+ from +'/inplace_update', {
        method: 'post',
        evalScripts: true,
        parameters: pars
    });
	}
	
function cancel_tag_update(id,page,type,from)
{
    pars = "id=" +id+"&search_data[type]="+type;
    var myajax = new Ajax.Request('/admin/'+ from +'/inplace_cancel', {
        method: 'post',
        evalScripts: true,
         parameters: pars
    });

}	

function manual_tag_move_article(id,assignto,tag_name,from)
{
   if ($(assignto).value=="") 
   {
    alert("please select a "+from);
    return false
    }
    else if (confirm("Do you really want to delete "+from + " '" +tag_name + "' " +" and move its articles to "+ from + "' " +$(assignto).options[$(assignto).selectedIndex].text+"' ?"))
    { 
    pars = "id=" +id+"&assignto="+$(assignto).value;
    var myajax = new Ajax.Request('/admin/'+ from +'s/'+ from +'_delete', {
        method: 'post',
        evalScripts: true,
         parameters: pars
    });
    }
}
function check_date_format(id)
{
 var err_msg = [];
  if ($(id).value!="" && new Date($(id).value) ==  "Invalid Date")
    {
     err_msg.push("Invalid date format");     
    }
    if (err_msg.length>0)
    {
    alert(err_msg.join("\n"));
    return false
    }
    else
    {
    return true
    }
}

function directory_listing_category_tree(){
    x = $('mytree').serializeTree('data[MenuItems]');
    
   // pars = "menu_id=" + x;
    //document.multi1.action = "/admin/directory_listing_categories/reorder_directory_listing_category?" + x;
    //document.multi1.submit();
    var myajax = new Ajax.Request('/admin/directory_listing_categories/reorder_directory_listing_category', {
        method: 'post',
        evalScripts: true,
        parameters: x
    });
}

function submit_subdirectory_listing_category(){
    document.multi.action = "/admin/directory_listing_categories/save_subdirectory_listing_category"
    document.multi.submit();
}

function submit_directory_listing_category(){
	        if ($('directory_listing_category_name').value == "") {
            alert("Name field Should not be blank ");
                }
                else {
    				    document.multi.submit();
                }
}

function edit_directory_listing_category(id){
    pars = "id=" + id;
    var myajax = new Ajax.Updater('edit_page', '/admin/directory_listing_categories/edit', {
        evalScripts:true,
        method: 'get',
        parameters: pars
    });
}

function submit_directory_listing_category1(){
    document.multi.action = "/admin/directory_listing_categories/update"
    document.multi.submit();
}

function submit_classified_listing_category1(){
    document.multi.action = "/admin/classified_listing_categories/update"
    document.multi.submit();
}

function submit_subdirectory_listing_category(){
    document.multi.action = "/admin/directory_listing_categories/save_subdirectory_listing_category"
    document.multi.submit();
}

function destroy_directory_listing_category(){

    var x = document.getElementsByName("directory_listing_category[id]");
    for (var n = 0; n < x.length; n++) {
        if (x[n].checked == true) {
            document.multi.action = "/admin/directory_listing_categories/destroy?id=" + x[n].value;
            document.multi.submit();
            
        }
        
    }
}
function subdirectory_listing_category_toggle(directory_listing_category_id){
    Element.toggle(directory_listing_listing_category_id)
}
function directory_listing_unpublish(){
	$('directory_listings_unpublish').value=0
	document.multi_directory_listings.submit();
}

function directory_preview(url){
    var win_options = "toolbar=no,addressbars=yes,scrollbars=yes,width=1050px,height=700,resizable=yes ";
    window.open(url, "terms", win_options).focus();
}

function directory_sponsor_status(id,flag){
	if (flag==1){
	   $('directory_publish').hide()
	   $('directory_unpublish').show()
	}
	else if (flag==0){
       $('directory_unpublish').hide()
   	   $('directory_publish').show()
	} 
    pars = "id=" +id+"&status="+flag;
    var myajax = new Ajax.Updater('status_updation_message','/admin/directory_listings/change_status', {
        method: 'post',
        evalScripts: true,
         parameters: pars
    });
}

function change_site_user()
{
	document.change_site.submit()
}

function all_source_from_site(site_id)
{
	pars = "site_id=" +site_id+"&status=site";
    var myajax = new Ajax.Updater('test','/admin/ranked_list/get_source', {
        method: 'post',
        evalScripts: true,
         parameters: pars
    });
}
function all_source_from_portal(site_id)
{
		pars = "site_id=" +site_id+"&status=portal";
    var myajax = new Ajax.Updater('test','/admin/ranked_list/get_source', {
        method: 'post',
        evalScripts: true,
         parameters: pars
    });
}

function view_version(article_id,article_content_id){
    var win_options = "toolbar=no,addressbars=yes,scrollbars=yes,width=1050px,height=700,resizable=yes ";
    window.open("/admin/articles/view_version_history?article_id="+article_id+"&article_content_id="+article_content_id+"", "view_version", win_options).focus();
}


function make_latest_article_version(article_id,article_content_id)
{
    var pars="id="+article_id+"&article_content_id="+article_content_id;
    opener.document.multi.action="/admin/articles/edit?"+pars;
    opener.document.multi.submit();
    parent.close();
}

function insert_image_from_edit_imageset(image,image_path,thumbnail_path,image_id,title,caption)



{
    var img_pre='<table><tr><td><img src='+thumbnail_path+' '+' alt= /></td><td>Caption:<br/>'+caption+'</td></tr></table>'
    opener.$('no_image').hide();
    opener.$('change_link').hide();
    opener.$('imageset_caption').show();
    opener.$('change_link123').show();
    opener.$('prev').show();
     if (opener.$('gen_image')!=null)
    {
    opener.$('gen_image').hide();
   
    }    
    opener.$('prev').update(img_pre); 
    opener.$('image_property_image_id').value=image_id;    
	parent.close();
} 

function add_imageset_form_to_gallery()
{	
    $('image_property_width').value=""
	 $('image_property_height').value=""
	 $('image_property_image_id').value=""
	 $('image_property_logical_name').value=""
	 $('image_property_author').value=""	
	 $('image_property_description').value=""
	 $('add_image_to_gallery').update("");
	$('test').show();
}


function remove_imageset_form_to_gallery()
{	
     $('image_property_width').value=""
	 $('image_property_height').value=""
	 $('image_property_image_id').value=""
	 $('image_property_logical_name').value=""
	 $('image_property_author').value=""
	 $('image_property_description').value=""
	 $('add_image_to_gallery').update("");
	$('test').hide();
}

function gallery_image_popup()
{
    newwindow=window.open('/admin/image_details/popup_image_manager/?title=gallery','mywindow','width=967,height=580,scrollbars=yes');
	if (window.focus) {newwindow.focus()}
	return false;
}
  
function magazine_issue_image_popup()
{
    newwindow=window.open('/admin/image_details/popup_image_manager/?title=magazine_issue','mywindow','width=967,height=580,scrollbars=yes');
        if (window.focus) {newwindow.focus()}
        return false;
}


function insert_image_to_gallery(image_path,width,height,image_type,image_id)
{
	alert(img_pre);
	 var img_pre='<table><tr><td><img src='+image_path+' '+' alt= /></td></tr></table>'
	 alert(img_pre);
	 opener.$('image_property_width').value=width
	 opener.$('image_property_height').value=height
	 opener.$('image_property_image_id').value=image_id	 
	 alert(img_pre);
	 opener.$('add_image_to_gallery').update(img_pre);
	 parent.close(); 
}


function edit_imageset_in_gallery(update_id,image_property_id)
{
	$('new_button').hide();
    pars = "image_property_id=" +image_property_id;
    var myajax = new Ajax.Updater(update_id,'/admin/image_details/edit_imageset_in_gallery', {
        method: 'post',
        evalScripts: true,
         parameters: pars
    });	
}

function gallery_popup()
{
    newwindow=window.open('/admin/image_details/popup_image_gallery/','mywindow','width=970,height=630,resizable=yes');
	if (window.focus) {newwindow.focus()}
	return true;
} 

function edit_gallery(id)
{
    newwindow=window.open('/admin/image_details/edit_gallery/?flag=edit_gallery&id='+id+'','edit_gallery','width=970,height=630,resizable=yes');
	if (window.focus) {newwindow.focus()}
	return true;
}  

/*function insert_gallery_to_article(image_path,gallery_id)
{
	var img_pre='<table><tr><td><img src='+image_path+' '+' alt= width=60 height=60 /></td></tr></table>'
    
    opener.$('gallery_link').hide();   
    opener.$('gallery_link123').show();
    opener.$('prev_gallery').show();
	  if (opener.$('no_gallery')!=null)
    {
    opener.$('no_gallery').hide();
   
    }    
     if (opener.$('gen_gallery')!=null)
    {
    opener.$('gen_gallery').hide();
   
    }    
    opener.$('prev_gallery').update(img_pre); 
    opener.$('gallery_property_image_sequence_id').value=gallery_id;    
	parent.close();
}*/


function remove_gallery()
{
	{
			 
$('prev_gallery').hide();


 if ($('gen_gallery')!=null)
    {
   $('gen_gallery').hide();
   
    }   

$('gallery_property_image_sequence_id').value="";

}
}

function split_article(article_id)
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
}

function upload_image_from_popup()
{
	
	      status="true"         
          var image_path=$('image_detail_image_path').value;          
          re_img_path = new RegExp("(.*?)\.(jpg|jpeg|png|gif|JPG|JPEG|PNG|GIF)$"); 
          if (image_path=="")
          {        
          alert("No image has been uploaded");         
          }
           if (image_path!="")
           {
               if (!re_img_path.match(image_path))
               {              
               alert("Permissible image formats: gif,png,jpg")              
               }
               else
               {                
              document.multi.action = "/admin/image_details/upload_imageset_from_popup/";	  
              document.multi.submit();
               }
           } 
	  
}

function change_cropping_image(id,type)
{
	 document.image.action = "/admin/image_details/edit_orientation?id="+id+"&white_background="+type;	  
     document.image.submit();
}

/*function audio_details(audio_id)
{
	 pars = "audio_id=" +audio_id;
    var myajax = new Ajax.Updater('audio_detail','/admin/media_details/edit_audio_detail', {
        method: 'post',
        evalScripts: true,
         parameters: pars
    });	
} */

function audio_details(audio_id)
{
	 pars = "audio_id=" +audio_id;
	  jQuery.ajax({
	  	   type: 'POST',
           data: pars,
     url:'/admin/media_details/edit_audio_detail',
	   success: function(data){
       jQuery("#audio_detail").html(data);
	  
    }
  });
}

function enable_primary_status(primary_key){
  if ($('related_company_aliases_display_status_' + primary_key).checked == true) {
     $("related_company_primarystatus_" + primary_key ).disabled = false
//	$("related_company_primarystatus_" + primary_key ).checked = true
  }
  else {

    $("related_company_primarystatus_" + primary_key ).checked = false;
	$("related_company_primarystatus_" + primary_key ).disabled = true;
   //jQuery(this).checked=false;

  }
}

function preview_home(url){
    newwindow=window.open('http://Indian_express.preview.admin_pl_test.indianexpress.in','mywindow','width=1067,height=600,scrollbars=yes,resizable=yes,addressbars=yes,toolbar=no');
        if (window.focus)
            {
                newwindow.focus();
            }
        return false;
}

/*Related company validations*/

    function check_box_validate()
    {
	if (jQuery("input[type=checkbox]:checked").length > 0)   {

        if (jQuery("input[name=related_company]:checked.radio_style:not('input[name=related_company]:disabled')").length > 0)   {
                  // alert('no');
            }
            else{
               alert('Please select another Company Alias as the Primary Name from the displayed list');
			   return false;
                }
             }
            else{
            alert('please select atleast one display checkbox');
			return false;
    }
}

    function adding_parent_child(){
	child = jQuery('.drop_list_child li')
    if (child.length > 1)
    {
        for (i = 0; i < child.length; i++) {
           var box = '<input type="hidden" value="' + child[i].id + '" name="related_company_child[id][]" id="related_company_child" class="textBoxWidth"/>'
           parent.$('drop_list_left').insert(box);
        }
    }

    parent_field =  jQuery('.drop_list_parent li')
    if (parent_field.length > 1)
    {
        if (parent_field.length > 2) {
           alert("Only One Parent is Allowed")
           return false
        }
        else {
           for (i = 0; i < parent_field.length; i++) {
             var box = '<input type="hidden" value="' + parent_field[i].id + '" name="related_company_parent[id][]" id="related_company_parent" class="textBoxWidth"/>'
             parent.$('drop_list_right').insert(box);
        }
     }
  }
}


