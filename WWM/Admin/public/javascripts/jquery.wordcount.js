/* Textarea Word Count Jquery Plugin */

jQuery.fn.wordCount = function(params){
	var p = {
		counterElement:"display_count"
	};
	var total_words;
	
	if(params) {
		jQuery.extend(p, params);
	}	
//for each keypress function on text areas
	this.keypress(function()
	{ 
		total_words=this.value.split(/[\s\.\?]+/).length;
		jQuery('#'+p.counterElement).html(total_words);
	});	
};
