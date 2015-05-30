# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

window.events = {}
window.events.getMain = (push=false) ->
  get_merge_events = () ->
    $('input[name="merge_ids[]"]:checked').map( () ->
      $(this).val()).get()


  console.log(get_merge_events())
  data =  {
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
    setTimeout((->
      window.events.getMain()), 5000)
    if push == true
      history.pushState(data, 'Main', this.url)
    else
      history.replaceState(data, 'Main', this.url)
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
    things[$(group).data('flag')] = $(group).find('.btn-primary').data('value')
  )

  things

