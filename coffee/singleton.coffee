define ()->
  'use strict'

  class Singleton
    instance = undefined
   
    @get : ->
      instance ?= new @