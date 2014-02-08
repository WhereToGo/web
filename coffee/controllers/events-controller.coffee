define [
  'controllers/base/controller'
  'models/base/model'
  'views/events/new'
  'views/events/show'
], (Controller, Model, newEvent, showEvent) ->
  'use strict'

  class EventsController extends Controller

    add:=>
        @view = new newEvent region:'main'
    show:=>
        @view = new showEvent region:'main'
        