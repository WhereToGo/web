define [
  'views/base/view'
  'text!templates/events/new.hbs'
], (View, template) ->
  'use strict'

  class newEvent extends View
    # Automatically render after initialize.
    autoRender: true
    className: 'newEvent'
    template: template
    template = null    
    tagName = 'div'