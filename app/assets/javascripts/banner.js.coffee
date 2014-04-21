$ ->
  get_banner()
  $('.pause-banner').change(handlePause)

handlePause = () ->
  window.pauseBanner = $('.pause-banner').is(':checked')
  console.log(window.pauseBanner)
  if window.pauseBanner == false
    get_banner()

get_banner = () ->
  return if window.pauseBanner
  $.get('/banner', fill_banner);

fill_banner = (data) ->
  $('#banner-placeholder').html(data);
  setTimeout((->
    get_banner()), 10000)
