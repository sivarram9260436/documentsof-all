   
// this is comment moderation using check box jquery lines...
     $(document).ready(   
      function() {  
      //clicking the parent checkbox should check or uncheck all child checkboxes   
     $("#article_published").click(  
     function() {  
     $('.checkbox_style').attr('checked', this.checked);  
     }  
     );  
 });


// news wire feed changes...
$(document).ready(function()
{
   $(".checkbox_style").click(function()
   {
   $('.radio_style').attr('checked','');
  $(this).parent().next().children().children().attr('checked','checked');
   });
});



/*code for releated checkbox*/
 function() {
   
      //clicking the parent checkbox should check or uncheck all child checkboxes
   
     jQuery("#article_published").click(function() {
 
	     jQuery('.check_related').attr('checked', this.checked);
 
     });
 
   }

jQuery(document).ready(function(){
   jQuery(".check_related").click(function() {
	if (jQuery(this).is(':checked'))//to select radio button when checkbox checked
	{
		jQuery(this).parent().next().children().children().attr('checked','checked');
	}
	else{
		//empty when uncheck the checkbox
	}
  });
});



// news wire feed changes...
//jQuery.noConflict();
$(function() {
$("#drop_list_left a[title],#drop_list_right a[title]").tooltip({

   // tweak the position
   offset: [10, 2],

   // use the "slide" effect
   effect: 'slide'

// add dynamic plugin with optional configuration for bottom edge
}).dynamic({ bottom: { direction: 'down', bounce: true } });
});