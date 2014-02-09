define [
  'models/base/collection'
  'models/events-model'
], (Collection, EventsModel) ->
  'use strict'

  class EventsCollection extends Collection
    model: EventsModel
    url: "http://wtgser.azurewebsites.net/api/events/getall"

    parse:(response)=>
      console.log a
      super
	