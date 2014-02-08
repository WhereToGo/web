define ()->
  'use strict'

  class Singleton
    instance = null    
   
    @get: ->
      if not @instance?
        instance = new @
        instance.init()
      
      instance
   
    init: (name = "unknown") ->
      console.log "#{name} initialized"