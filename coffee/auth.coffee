define ['singleton'], (Singleton) ->
  'use strict'

  class Auth extends Singleton
    token: ""

    init: ()->
      @token = @load()
      @id = @loadID()

    isLogged: -> !!@token

    login: (options = {}) =>
      if @tryToLogin options
        @token = @createToken options
        @id = options.id
        @save()
        return true
      else
        return false

    logout: (options = {}) =>
      @token = ""
      @id = ""
      @save()


    tryToLogin: (options = {}) => !!options.login

    createToken: (options = {}) => options.login


    load:   () => localStorage.getItem "auth"
    loadID: () => localStorage.getItem "user_id"
    save:   () => 
      localStorage.setItem "auth", @token
      localStorage.setItem "user_id", @id

