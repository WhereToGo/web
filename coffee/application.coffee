define [
  'chaplin'
  'bootstrap'
  'serializeObject'
], (Chaplin) ->
  'use strict'

  # The application object.
  # Choose a meaningful name for your application.
  class Application extends Chaplin.Application
    title: 'Where To Go?'
    # start: ->
    #   # You can fetch some data here and start app
    #   # (by calling `super`) after that.
    #   super

    initRouter: (routes, options = {}) ->
      options.pushState = no
      super routes, options
