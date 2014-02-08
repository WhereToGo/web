define [
  'controllers/base/controller'
  'auth'
  'models/user'
  'views/user/login'
], (Controller, Auth, User, Login) ->
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

    edit: (params) -> @