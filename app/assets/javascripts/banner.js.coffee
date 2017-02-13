window.banner = {};

$ ->
  get_banner()  

get_banner = () ->
  return if window.banner.pause
  $.get('/banner', fill_banner);

fill_banner = (data) ->
  $('#banner-placeholder').html(data);
  setTimeout((->
    get_banner()), 10000)

window.banner.toggle_pause = (pause) ->
  window.banner.pause = pause
  $.ajax( {url: "/sessions/set_pause_refresh", type: "PUT", data: "pause=" + pause, complete: get_banner} )