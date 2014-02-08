define [
  'views/base/view'
  'text!templates/startup.hbs'
], (View, template) ->
  'use strict'

  class Startup extends View

    autoRender: true
    region:'main'
    template: template
    template = null
    
    initialize: =>
        super
        @afterRender()
        
        
    afterRender: =>
        #geolocation
        getLocation: =>
            if navigator.geolocation
                navigator.geolocation.getCurrentPosition showPosition, showError
                alert 9
            else
                alert "Geolocation is not supported by this browser."
            return
        showPosition = (position) =>
            latlon = position.coords.latitude + "," + position.coords.longitude
            img_url = "http://maps.googleapis.com/maps/api/staticmap?center=" + latlon + "&zoom=14&size=400x300&sensor=false"
            document.getElementById("mapholder").innerHTML = "<img src='" + img_url + "'>"
            
        
          return
        showError = (error) =>
            switch error.code
                when error.PERMISSION_DENIED
                    alert "User denied the request for Geolocation."
                when error.POSITION_UNAVAILABLE
                    alert "Location information is unavailable."
                when error.TIMEOUT
                    alert "The request to get user location timed out."
                when error.UNKNOWN_ERROR
                    alert "An unknown error occurred."
         
                    