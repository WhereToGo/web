define [
  'singleton'
  'async!http://maps.google.com/maps/api/js?sensor=true&key=AIzaSyAU43H9HS_S0p94SLnuU-oxadj6tzdUXx0'
], (Singleton) ->
  'use strict'

  class Geo extends Singleton
    firstCoords: lat: 46.48048, lng:30.756235
    
    init: ()->
      @geocoder = new google.maps.Geocoder()
      @getCoords (position)=>
        @firstCoords.lat = position.coords.latitude
        @firstCoords.lng = position.coords.longitude

    
    getCoords: (callback, errorback = @getCoordsError) =>
      if navigator.geolocation
        navigator.geolocation.getCurrentPosition callback, errorback
      else
        errorback 1

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