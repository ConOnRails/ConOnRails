# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

pop_up = () ->
  $( "#create-user-for-vol").dialog( "open" )

$ ->
  $("#create-user-for-vol").dialog({ modal: true, autoOpen: false, height: 300, width: 350 });
  $("#create-user-button").button().click(pop_up)



