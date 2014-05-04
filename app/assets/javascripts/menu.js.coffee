$ ->
  here = window.location.pathname
  $menubar = $('#menubar')
  $menubar.find('.tab').each (i, thing) ->
    tab_href = $(thing).attr('href')
    if tab_href == here
      $(thing).addClass('selected')