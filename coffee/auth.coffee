define ['singleton'], (Singleton) ->
  'use strict'

  class Auth extends Singleton
    token: ""

    init: ()->
      @token = @load()

    isLogged: -> !!@token

    login: (options = {}) =>
      if @tryToLogin options
        @token = @createToken options
        @save()
        return true
      else
        return false

    logout: (options = {}) =>
      @token = ""
      @save()


    tryToLogin: (options = {}) => !!options.username

    createToken: (options = {}) => options.username


    load: () => localStorage.getItem "auth"
    save: () => localStorage.setItem "auth", @token


