$ ->
  new MenuDecorator(window.location.pathname)

MenuDecorator = (here) ->
  this.here = here
  this.init()

MenuDecorator.prototype = {
  admin_subpaths: [
    '/radio_admin',
    '/radio_groups',
    '/departments',
    '/radio_assignment_log',
    '/contacts',
    '/duty_board_groups',
    '/duty_board_slots',
    '/volunteers',
    '/users',
    '/roles',
    '/vsps',
    '/conventions',
    '/audits',
    '/versions',
    '/login_log'
  ],

  init: (->
    this.$menubar = $('#menubar')

    this.main_menu_section() || this.sub_section()
  ),

  main_menu_section: (->
    this.selected = false
    this.$menubar.find('.tab').each this.match_main_menu.bind(this)
    this.selected
  ),

  match_main_menu: ((i, thing) ->
    tab_href = $(thing).attr('href')

    if tab_href == this.here
      $(thing).addClass('active')
      this.selected = true
  ),

  sub_section: (->
    for path in this.admin_subpaths
      if path == this.here
        $('#menu-tab-admin').addClass('active')
        return true
    return false)
}