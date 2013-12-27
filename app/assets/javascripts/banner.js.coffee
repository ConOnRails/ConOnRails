$ ->
  get_banner()

get_banner = () ->
  $.get('/banner', fill_banner);

fill_banner = ( data ) ->
  $('#banner-placeholder').html( data );
###
  setTimeout((-> get_banner()), 10000)
###