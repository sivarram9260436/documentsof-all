/**
 *   @author ramkumarp
 *   @version 1.0
 *   @lastupdated 3 Sep 2012
 *   @lastupdatedby ramkumarp
 *   @usage: $("Any Selector").fixScroll(options)
 *   @sample: 
*/
(function($) {
    $.fn.fixScroll = function(options) {
        var defaults={"topSpace":40}; // options which will be by default
        var settings = $.extend(defaults, options); // extending user defined options with defaults
        return this.each(function() {
        	var $win = $(window)
  		  , $fixBar = $(this)
  		  , fixBarTop = $fixBar.length && $fixBar.offset().top - settings.topSpace
  		  , isFixed = 0
  		$win.on('scroll', processScroll)
  		function processScroll() {
  		  var i, scrollTop = $win.scrollTop()
  		  if (scrollTop >= fixBarTop && !isFixed) {
  			isFixed = 1
  			$fixBar.addClass('detachedfromPage')
  		  } else if (scrollTop <= fixBarTop && isFixed) {
  			isFixed = 0
  			$fixBar.removeClass('detachedfromPage')
  		  }
  		}

        });
      };
    $(document).ready(function(){
        $("[data-fix-scroll='true']").fixScroll({})
    });

function lastAddedLiveFunc()
{  
	console.log("called")
	/*$('div.loading').html('<img src="/images/prettyPhoto/default/loader.gif"/>');
	$.get(location.href + '/page/' + Number($('.count_page').val()), function(data){
		if (data != "") {
			$(".schedule_display_block").append(data);
		}
		$('div.loading').empty();
	});*/
	$.each([1,2,3,4,5,6,7,8,9,10],function(){
		$("#article_list tbody").append($("#article_list tbody tr:first").clone());		
	});
};
$(window).scroll(function(){
	var wintop = $(window).scrollTop(), docheight = $(document).height(), winheight = $(window).height();
    var  scrolltrigger = 0.95;
    if  (((wintop/(docheight-winheight)) > scrolltrigger)){
    	//$('.count_page')[0].value= Number($('.count_page').val())+1
         lastAddedLiveFunc();
      }
  });
})(jQuery);
