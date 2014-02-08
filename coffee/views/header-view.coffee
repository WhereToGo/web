define [
  'views/base/view'
  'text!templates/header.hbs'
], (View, template) ->
  'use strict'

  class HeaderView extends View
    template: template