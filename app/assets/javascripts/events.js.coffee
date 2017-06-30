# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

window.events = {}
window.events.getMain = (push = false) ->
  get_merge_events = () ->
    $('input[name="merge_ids[]"]:checked').map(() ->
      $(this).val()).get()


  console.log(get_merge_events())
  data = {
    "page": window.events.page,
    "convention": window.events.convention,
    "merge_mode": window.events.merge_mode,
    "merge_ids": get_merge_events(),
    "show_older": $('#show_older').is(':checked')
  }

  $.ajax({
      url: window.events.path,
      dataType: 'script',
      data: data
    }
  ).done((data, status, xhr)->
    if !window.banner.pause
      setTimeout((->
        window.events.getMain()), 5000)
  )

window.events.getReview = (filters) ->
  data = {
    "page": window.events.page,
    "filters": filters,
    "convention": $('#convention').val(),
    "q": $('input[name=q]').val(),
    "from_date": $('#from_date').data('date'),
    "to_date": $('#to_date').data('date')
  }
  $.ajax({
      url: '/events/review',
      dataType: 'script',
      data: data
    }
  ).done((data, status, xhr)->
    history.pushState(data, 'Search', this.url)
  )


window.events.getFilters = ->
  things = {}

  $('#filters .btn-group').each((index, group)->
    console.log($(group).find('.btn-primary').data('value'));
    things[$(group).data('flag')] = $(group).find('.btn-primary').data('value')
    true
  )

  things

window.events.exportReview = (filters) ->
  data =
    "filters": filters,
    "convention": $('#convention').val(),
    "q": $('input[name=q]').val(),
    "from_date": $('#from_date').data('date'),
    "to_date": $('#to_date').data('date')

  window.location = '/events/export.csv?' + jQuery.param(data)

window.events.clearDateFields = ->
  $('#from_date').data('DateTimePicker').date(null)
  $('#to_date').data('DateTimePicker').date(null)

window.events.clearDates = ->
  window.events.clearDateFields()
  window.events.getReview window.events.getFilters()

window.events.clearFilters = ->
  $('#filters .btn-group button[data-value=true]').removeClass('btn-primary')
  $('#filters .btn-group button[data-value=false]').removeClass('btn-primary')
  $('#filters .btn-group button[data-value=all]').addClass('btn-primary')
  $('#filters .btn-group button[data-value=asc]').addClass('btn-primary')
  $('#filters .btn-group button[data-value=desc]').removeClass('btn-primary')

  $('#filters select[name=convention]').val('all')
  console.log $('#from_date').data('DateTimePicker')
  window.events.clearDateFields()
  $('input[name=q]').val('')

  window.events.getReview window.events.getFilters()
