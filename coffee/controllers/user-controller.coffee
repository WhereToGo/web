define [
  'controllers/base/controller'
  'auth'
  'models/base/model'
  'models/user'
  'views/user/login'
  'views/user/edit'
], (Controller, Auth, Model, User, Login, Edit) ->
  'use strict'

  class UserController extends Controller

    initialize: ()->
      super
      @auth = Auth.get()

    login: (params) ->
        @subscribeEvent "logged", (options)=>
          if @auth.login(options)
            @redirectTo url: ""
        @model = new User()
        @view = new Login model: @model, region: 'main'

    logout: (params) -> 
      @auth.logout()
      @redirectTo url: "login"

    edit: (params) =>
      # $.ajax
      #   url: "http://wtgser.azurewebsites.net/api/users/getuser?user_id=1"
      #   cache: false
      #   beforeSend: ->
      #     #alert "Получаем контент"
      #     return
      #   success: (html) =>
      #     @model = new Model()
      #     username = JSON.parse(html).name
      #     @model.set("username",username)
      #     @view = new Edit model: @model, region: 'main'
      #     return

      @model = new Model()
      @model.fetch
        url:'http://wtgser.azurewebsites.net/api/users/get?id=1'
        success:()=>
          @view = new Edit model: @model , region: 'main'
      # $.ajax
      #   url: "http://wtgser.azurewebsites.net/api/users/postme"
      #   type: "POST"
      #   contentType: "application/json"
      #   data:'{"login":"logiwnd","pass":"slkdfj"}'
      #   success: (result) ->
      #     console.log 'ok'
      #     return

      #   error: (jqXHR, textStatus, errorThrown) ->
      #     console.log(jqXHR)
      #     return\
     
      # $.ajax
      #   url: "http://wtgser.azurewebsites.net/api/tags/subscription"
      #   type: "POST"
      #   contentType: "application/json"
      #   data:'{"int_id":"5","user_id":"1"}'
      #   success: (result) ->
      #     console.log 'ok'
      #     return

      #   error: (jqXHR, textStatus, errorThrown) ->
      #     console.log(jqXHR)
      #     return