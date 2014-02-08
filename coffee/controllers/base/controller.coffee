define ['chaplin', 'auth', 'views/site-view', 'views/header-view'], (Chaplin, Auth, SiteView, HeaderView) ->
  'use strict'

  class Controller extends Chaplin.Controller
    # Place your application-specific controller features here.
    beforeAction: (params, route) ->
      @reuse 'site', SiteView
      @reuse 'header', HeaderView, region: 'header'

      @redirectUnlessLogin route


    redirectUnlessLogin: (route)->
      auth = Auth.get()

      if not /login|register/.test route.path
        if not auth.isLogged()
          @redirectTo url: '/login'
          return false

      if auth.isLogged() and /login|register/.test route.path
        @redirectTo url: '/'
        return false

      true
