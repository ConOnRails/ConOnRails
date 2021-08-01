# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  form = $('#volunteer_search')
  div = $('<td class="radio_volunteer" id="radio_volunteer"></div>')

  search = document.querySelector('#volunteer_search')
  $('#volunteer_search').on('ajax:success', (evt) ->
    [_data, _status, _xhr] = evt.detail;
    $('#matching_volunteers').html(_xhr.responseText))

  bind_action = (evt) ->
    [_data, _status, _xhr] = evt.detail
    $('#radio_volunteer').html(evt.data.name)
    form.hide()
    $('h2').text('Now select a department')
    $('#matching_volunteers').html(_xhr.responseText)

  window.radios = {}
  window.radios.bind_volunteer = (id, name) ->
    $('#vol-' + id).bind('ajax:success', { id: id, name: name }, bind_action)
