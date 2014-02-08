define [
    'views/base/view'
    'text!templates/login.hbs'
    'views/startup'
], (View, template , Startup) ->
  'use strict'

  class Login extends View

    autoRender: true
    className: 'hello-world'
    template: template
    template = null
    
    initialize: =>
        #test request to backend
        @delegate 'click', '.join', @join

    join:=>
        #basic validation handling
        username = $('#userNameInput').val()
        if username? && username!=''
            username = $('#userNameInput').val()
            alert "Thanks for singing in " + username
            _@ = @;
            @.dispose();
            _@.view = new Startup region: 'main'
        else
            alert "Username cannot be empty"
        
        