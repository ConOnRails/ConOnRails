$ ->
  $('.clickable-row').click ->
    window.document.location = $(this).data 'href'