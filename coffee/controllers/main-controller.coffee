define [
  'controllers/base/controller'
  'models/events-collection'
  'views/main/index'
], (Controller, EventsCollection, IndexView) ->
  'use strict'

  class MainController extends Controller

    index: (params) ->
      @collection = new EventsCollection()
      @view = new IndexView collection: @collection, region: 'main'
      
