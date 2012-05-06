# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
 get_main() if ( $('#eventlist').length )

get_main = () ->
  $.get('/events/subwombat', fill_main)

fill_main = (data) ->
  $('#eventlist').html(data);
  setTimeout((-> get_main()), 10000)
