define [
  'views/base/view'
  'text!templates/user/edit.hbs'    
    
], (View, template) ->
  'use strict'

  class SiteView extends View
    container: 'body'
    autorender: true
    template: template
    template = null
    