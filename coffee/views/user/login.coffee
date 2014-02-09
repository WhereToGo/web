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
      @delegate 'input focus', '.has-error #inputPassword', ()=>
        @$el.find("#inputPassword").closest(".form-group").removeClass "has-error"
    
    join: (e) =>
      e.preventDefault()
      formData = $(e.target).serializeObject()

      $.ajax
        url: "/api/users/postme"
        type: "POST"
        contentType: "application/json"
        data:JSON.stringify formData
        error: () =>
          @$el.find("#inputPassword").closest(".form-group").addClass "has-error"
        success: (user) =>
          formData.id = JSON.parse(user)["user_id"]
          @publishEvent "logged", formData