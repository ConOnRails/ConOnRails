# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

window.events = {}
window.events.getMain = () ->
  $.ajax({
         url:       window.events.path,
         dataType: 'script',
         data: {
            "page": window.events.page,
            "merge_mode": window.events.merge_mode,
            "show_older": $('#show_older').is(':checked')
         },
         success: ->
           setTimeout((-> window.events.getMain()), 10000)
         }
  )

window.events.getReview = (filters) ->
  $.ajax({
         url:      '/events/review',
         dataType: 'script',
         data: {
            "page": window.events.page,
            "filters": filters,
            "convention": $('#convention').val()
            }
         }
  )



