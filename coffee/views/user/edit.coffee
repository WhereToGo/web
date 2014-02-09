define [
  'views/base/view'
  'text!templates/user/edit.hbs'    
    
], (View, template) =>
  'use strict'

  class SiteView extends View
    container: 'body'
    template: template
    template = null
    autoRender:true

    initialize:(model)=>
    	super
    	console.log(model)