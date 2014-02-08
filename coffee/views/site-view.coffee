define [
  'views/base/view'
  'text!templates/site.hbs'    
    
], (View, template) ->
  'use strict'

  class SiteView extends View
    container: 'body'
    id: 'site-container'
    regions:
      main: '#main-container'
      header: '#header'
    template: template
    template = null