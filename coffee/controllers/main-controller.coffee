define [
  'controllers/base/controller'
  'models/user'
  'views/main/index'
], (Controller, UserModel, IndexView) ->
  'use strict'

  class MainController extends Controller

    index: (params) ->
      @model = new UserModel()
      @view = new IndexView model: @model, region: 'main'
