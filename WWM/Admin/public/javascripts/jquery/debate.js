jQuery(function() {
	jQuery("#add_contributor").click(function(e) {
		// var added_contributor_name = jQuery("#debate_contributor_debate option:selected").text();
		// var added_contributor_id = jQuery("#debate_contributor_debate option:selected").val();
		var added_contributor_name = "";
		var added_contributor_id = "";
		var selected_contributors = [];
		var selected_roles = [];
		jQuery("#ul_debate_contributor_debate li.bit-box").each(function(){
    		added_contributor_name = jQuery(this).text();
    		added_contributor_id = jQuery(this).find(".smallinput").val();
		});
		var added_contributor_role_name = jQuery("#debate_role_type_debate option:selected").text();
		var added_contributor_role_id = jQuery("#debate_role_type_debate option:selected").val();
		jQuery(".append_content input").each(function(){
			selected_contributors = selected_contributors.concat(jQuery(this).val().split("_")[0]);
		});
		jQuery(".append_content span").each(function() {
			selected_roles = selected_roles.concat(jQuery(this).text());
		});
		var duplicate_contributor = jQuery.inArray(added_contributor_id, selected_contributors);
		var duplicate_role = jQuery.inArray(added_contributor_role_name, selected_roles);
		if(duplicate_contributor >= 0){
			alert("Duplicate Contributor Found");
			e.preventDefault();
		}else if(duplicate_role >= 0){
			alert("Duplicate Role Found");
			e.preventDefault();
		}else if((added_contributor_role_id != "") && (added_contributor_id != "")){
			var added_contributor = added_contributor_name + " (<span class='validate'>" + added_contributor_role_name + "</span>) ";
			var hidded_field = "<input type='hidden' name='contributors[]' value=" + added_contributor_id + '_' + added_contributor_role_id + "></input>";
			jQuery("#contributor_list").append("<div class='append_content'>" + added_contributor + hidded_field + "<a href='#' class='close'>X</a></div>");
			jQuery("#debate_role_type_debate").attr("value", "");
			jQuery("#ul_debate_contributor_debate li:first").remove();
		}else if(added_contributor_role_id == "") {
			alert("Please select one Role");
			e.preventDefault();
		}else {
			alert("Please select one Contributor");
			e.preventDefault();
		}
	});
});
jQuery(function() {
	jQuery('.append_content .close').live('click', function() {
		jQuery(this).closest("div").remove();
	});
});
jQuery(function() {
	jQuery("#site_based_user_export").click(function() {
		var site_id = jQuery("#selected_site").val();
		var params = "&site_id=" + site_id;
		var path = window.location.host;
		jQuery.ajax({
			type : 'POST',
			url : "http://" + path + "/admin/debates/download_users_csv?site_based=yes" + params,
			dataType : "html",
			success : function() {

			}
		});
	});
});
jQuery(function() {
	jQuery("#debate_form_submit").click(function(e) {
		var selected_contributor = [];
		jQuery(".append_content span").each(function() {
			selected_contributor = selected_contributor.concat(jQuery(this).text());
		});
		var proposer = jQuery.inArray("Proposer", selected_contributor);
		var opposer = jQuery.inArray("Opposer", selected_contributor);
		var duplicate = selected_contributor.length - selected_contributor.uniq().length
		if(duplicate > 0){
			alert("Duplicate Entry found");
			e.preventDefault();
			return false;
		}else if((proposer >= 0) && (opposer >= 0)){
			return true;
		}else {
			alert("Please select Proposer and Opposer in Contributors");
			e.preventDefault();
			return false;
		}
	});
});
jQuery(function() {
	jQuery("#debate_advance_status").click(function() {
		var debate_id = jQuery("#debate_edit_id").val();
		var params = "&debate_id=" + debate_id;
		var path = window.location.host;
		jQuery.ajax({
			type : 'POST',
			url : "http://" + path + "/admin/debates/advance_debate_status?" + params,
			dataType : "html",
			success : function(data) {
				jQuery("#debate_status").attr("value", data);
				alert("Now debate status has been advanced")
				// alert("Now the debate phase is advanced to " + jQuery("#debate_status").text());
			}
		});
	});
});
