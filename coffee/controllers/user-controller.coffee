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

    edit: (params) ->
      @model = new Model
      @model.fetch
        url:'http://wtgser.azurewebsites.net/api/users/getuser?user_id=1'
        success:()=>
          @view = new Edit model: @model , region: 'main'