// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
//= require jquery
//= require jquery_ujs
//= require_tree .
Event.addBehavior.reassignAfterAjax = true;
 Event.addBehavior({
   'div.pagination a' : Remote.Link
 })
$(document).ready(function(){
  $('input.ui-datepicker').datepicker();
});