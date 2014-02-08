define [
  'chaplin'
  'views/base/view'
  'text!templates/main/index.hbs'
  'geo'
], (Chaplin, View, template, Geo) ->
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
      $('#addEvent').css('display' : 'block')
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

      @markers = []

      # test
      setTimeout( ()=>
        @addMarker({
          id: 0,
          title: "ololo1"
        }, new google.maps.LatLng 46.46568, 30.756255)
      , 3000)
      # test

    setCenter: (LatLng) =>
      @map.setCenter LatLng
      @me.setPosition LatLng


    addMarker: (model, LatLng)=>
      markerImage = new google.maps.MarkerImage(
        '/i/sports.png',
        new google.maps.Size(75,75),
        new google.maps.Point(59,55),
        new google.maps.Point(37,37),
        new google.maps.Size(1000,739)
      );

      marker = new google.maps.Marker
        icon: markerImage,
        position: LatLng, 
        map: @map,
        title: model.title,
        model: model

      google.maps.event.addListener marker, 'click', (a)->
        Chaplin.utils.redirectTo url: "event/{@model.id}"

      @markers.push marker



        


    

         
                    