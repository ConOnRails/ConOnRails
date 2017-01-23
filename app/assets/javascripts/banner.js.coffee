$ ->
  get_banner() 

handlePause = () ->
  if !window.events.pause
    get_banner() 

get_banner = () ->
  return if window.events.pause
  $.get('/banner', fill_banner);

fill_banner = (data) ->
  $('#banner-placeholder').html(data);
  setTimeout((->
    get_banner()), 10000)