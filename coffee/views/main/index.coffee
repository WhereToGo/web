define [
  'views/base/view'
  'text!templates/main/index.hbs'
], (View, template) ->
  'use strict'

  class IndexView extends View

    autoRender: true
    region:'main'
    template: template
    template = null
    
    initialize: =>
      super
      @afterRender()
        
        
    afterRender: =>
      #geolocation
      x = document.getElementById('main-container')
      getLocation = =>
        if navigator.geolocation
          navigator.geolocation.getCurrentPosition showPosition, showError
        else
          x.innerHTML = "Geolocation is not supported by this browser."
        return
      showPosition = (position) =>
        latlon = position.coords.latitude + "," + position.coords.longitude
        img_url = "http://maps.googleapis.com/maps/api/staticmap?center=" + latlon + "&zoom=14&size=540x180&sensor=false"
        x.innerHTML = "<img class='map' src='" + img_url + "'>"
        return
      showError = (error) =>
        switch error.code
          when error.PERMISSION_DENIED
            x.innerHTML = "User denied the request for Geolocation."
          when error.POSITION_UNAVAILABLE
            x.innerHTML = "Location information is unavailable."
          when error.TIMEOUT
            x.innerHTML = "The request to get user location timed out."
          when error.UNKNOWN_ERROR
            x.innerHTML = "An unknown error occurred."
              
      getLocation();
         
                    