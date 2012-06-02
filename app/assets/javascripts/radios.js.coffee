# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  form = $('#volunteer_search')
  div = $('<div class="radio_volunteer" id="radio_volunteer"></div>')

  $('#volunteer_search').bind('ajax:success', (evt, data, status, xhr) ->
    $('#matching_volunteers').html(xhr.responseText))

  bind_action = (evt, data, status, xhr) ->
    div.html(evt.data.name)
    form.replaceWith(div)
    $('#matching_volunteers').html(xhr.responseText)

  window.radios = {}
  window.radios.bind_volunteer = (id, name) ->
    $('#vol-' + id).bind('ajax:success', { id: id, name: name }, bind_action)


