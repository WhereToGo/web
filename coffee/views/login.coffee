define [
  'views/base/view'
  'text!templates/login.hbs'
], (View, template) ->
  'use strict'

  class HelloWorldView extends View
    # Automatically render after initialize.
    autoRender: true
    className: 'hello-world'

    # Save the template string in a prototype property.
    # This is overwritten with the compiled template function.
    # In the end you might want to used precompiled templates.
    template: template
    template = null
    
    initialize: ->
        #test request to backend
        
        #alert('hi');
        $.ajax(
            url: "http://192.168.187.1:2200"
            context: document.body
        ).done ->
            alert '2'
            return

