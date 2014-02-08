define [
  'controllers/base/controller'
  'models/user'
  'views/login'
], (Controller, User, Login) ->
  'use strict'

  class HelloController extends Controller
    login: (params) ->
        @model = new User()
        @view = new Login model: @model, region: 'main'
