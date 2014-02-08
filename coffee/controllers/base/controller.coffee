define ['chaplin', 'views/site-view', 'views/header-view'], (Chaplin, SiteView, HeaderView) ->
  'use strict'

  class Controller extends Chaplin.Controller
    # Place your application-specific controller features here.
    beforeAction: ->
      @reuse 'site', SiteView
      @reuse 'header', HeaderView, region: 'header'
