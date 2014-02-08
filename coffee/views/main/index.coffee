define [
  'views/base/view'
  'text!templates/main/index.hbs'
  'geo'
], (View, template, Geo) ->
  'use strict'

  class IndexView extends View

    autoRender: true
    region:'main'
    template: template
    template = null
    
    initialize: =>
      super
      @geo = Geo.get()
      
    
    attach: ()->
      super
      @createMap new google.maps.LatLng @geo.firstCoords.lat, @geo.firstCoords.lng
      @geo.getCoords (position)=>
        latlng = new google.maps.LatLng position.coords.latitude, position.coords.longitude
        @map.setCenter latlng


    createMap: (startCoords)=>
      mapOptions = 
        zoom: 14,
        center: startCoords,
        mapTypeControl: true,
        mapTypeControlOptions: {style: google.maps.MapTypeControlStyle.DROPDOWN_MENU},
        navigationControl: true,
        navigationControlOptions: {style: google.maps.NavigationControlStyle.SMALL},
        mapTypeId: google.maps.MapTypeId.ROADMAP

      @map = new google.maps.Map @$el.find("#mapView")[0], mapOptions 

      @me = new google.maps.Marker
        position: startCoords,
        map: @map,
        title: "You are here!"

    setCenter: (LatLng) =>
      @map.setCenter LatLng
      @me.setPosition LatLng

    addMarker: (LatLng)=>

    

         
                    