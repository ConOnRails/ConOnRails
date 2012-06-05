# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

window.events = {}
window.events.getMain = () ->
  $.ajax({
         url: '/events',
         dataType: 'script',
         data: {
          "page": window.events.page,
          "active": window.events.active },
         success: ->
           setTimeout('window.events.getMain()', 10000)
        }
  )


