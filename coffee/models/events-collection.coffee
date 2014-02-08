define [
  'models/base/collection'
  'models/events-model'
], (Collection, EventsModel) ->
  'use strict'

  class EventsCollection extends Collection
    model: EventsModel
	