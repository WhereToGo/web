define [
    'views/base/view'
    'text!templates/user/login.hbs'
], (View, template) ->
  'use strict'

  class LoginView extends View

    autoRender: true
    className: 'loginView'
    template: template
    template = null

    initialize: ()->
      super
      @delegate 'submit', 'form', @join
    
    join: (e) =>
      e.preventDefault()
      formData = $(e.target).serializeObject()
      # @model.save formData, {
      #   success: (model)=>
      #     @publishEvent "logged", model
      #   error: (data)=>
      #     alert JSON.stringify data
      # }
      @publishEvent "logged", formData
      console.log "view - event sent"