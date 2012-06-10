# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

pop_up = () ->
  $("#create-user-for-vol").dialog("open")

$ ->
    $("#create-user-for-vol").dialog({ modal: true, autoOpen: false, height: 300, width: 350 })
    $("#create-user-button").button().click(pop_up)


fill_in = (event, ui) ->
  $("#volunteer_first_name").val(ui.item.first_name)
  $("#volunteer_middle_name").val(ui.item.middle_name)
  $("#volunteer_last_name").val(ui.item.last_name)
  $("#volunteer_address1").val(ui.item.address1)
  $("#volunteer_address2").val(ui.item.address2)
  $("#volunteer_address3").val(ui.item.address3)
  $("#volunteer_city").val(ui.item.city)
  $("#volunteer_state").val(ui.item.state)
  $("#volunteer_postal").val(ui.item.postal)
  $("#volunteer_home_phone").val(ui.item.home_phone)
  $("#volunteer_work_phone").val(ui.item.work_phone)
  $("#volunteer_other_phone").val(ui.item.other_phone)
  $("#volunteer_email").val(ui.item.email)

hook_up_attendees = () ->
  $('#search-attendees').autocomplete({
                                      source:    "/volunteers/attendees",
                                      minLength: 2,
                                      select:    fill_in
                                      })

$ ->
    hook_up_attendees()



