define [
  'controllers/base/controller'
  'models/base/model'
  'views/events/new'
], (Controller, Model, newEvent) ->
  'use strict'

  class EventsController extends Controller

    add:=>
        @view = new newEvent region:'main'