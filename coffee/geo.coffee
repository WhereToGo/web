define [
  'singleton'
  'async!http://maps.google.com/maps/api/js?sensor=true&key=AIzaSyAU43H9HS_S0p94SLnuU-oxadj6tzdUXx0'
], (Singleton) ->
  'use strict'

  class Geo extends Singleton
    coords: lat: 46.48048, lng:30.756235
    LatLng: new google.maps.LatLng 46.48048, 46.48048
    subscribers: []

    
    init: ()->
      @geocoder = new google.maps.Geocoder()
      @update()
      @interval = setInterval @update, 1*60*1000


    setCoords: (position) =>
      @coords.lat = position.coords.latitude
      @coords.lng = position.coords.longitude
      LatLngTMP = new google.maps.LatLng position.coords.latitude, position.coords.longitude
      @notify LatLngTMP


    getCoords: (callback, errorback = @getCoordsError) ->
      if navigator.geolocation
        navigator.geolocation.getCurrentPosition callback, errorback
      else
        errorback 1

    update: ()=> @getCoords @setCoords

    getCoordsError: (error) => 
      switch error.code
        when error.PERMISSION_DENIED
          alert "User denied the request for Geolocation."
        when error.POSITION_UNAVAILABLE
          alert "Location information is unavailable."
        when error.TIMEOUT
          alert "The request to get user location timed out."
        when error.UNKNOWN_ERROR
          alert "An unknown error occurred."

    notify: (LatLngTMP) ->
      if not LatLngTMP.equals @LatLng
        @LatLng = LatLngTMP
        sub(LatLngTMP) for sub in @subscribers


    on: (type, handler) =>
      if type isnt 'change' 
        throw new Error "Geo: no such event as '#{type}'"; return false

      if not handler instanceof Function 
        throw new Error "Geo: no such event as '#{type}'"; return false
      
      @subscribers.push handler
      return handler
        
    off: (type, handler=type) =>
      indexes = (i for sub, i in @subscribers when sub is handler)
      arr.splice(i) for i in indexes
      return @