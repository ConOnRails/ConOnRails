$ ->
  get_banner() 

handlePause = () ->
  window.pauseBanner = $('#pause-banner').is(':checked')
  if window.pauseBanner == false
    get_banner() 

get_banner = () ->
  return if window.pauseBanner
  $.get('/banner', fill_banner);

fill_banner = (data) ->
  $('#banner-placeholder').html(data);
  $('#pause-banner').change(handlePause)
  setTimeout((->
    get_banner()), 10000)