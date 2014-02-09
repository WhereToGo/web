define [
  'chaplin'
  'handlebars'
  'views/base/view'
  'text!templates/main/index.hbs'
  'text!templates/main/popover.hbs'
  'geo'
  'models/tags-collection'
], (Chaplin, Handlebars, View, template, popoverTemplate, Geo, TagsCollection) ->
  'use strict'

  that = null

  class IndexView extends View

    autoRender: true
    region:'main'
    template: template
    template = null
    
    initialize: =>
      super
      @geo = Geo.get()
      @tags = new TagsCollection()
      that = @

      window.collection = @tags

      @tags.fetch
        success: ()->
          that.collection.fetch
            success: (collection)->
              that.addMarker model.attributes for model in collection.models
    
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

    setCenter: (LatLng) =>
      @map.setCenter LatLng
      @me.setPosition LatLng


    addMarker: (attrs)=>
      LatLng = new google.maps.LatLng attrs.location.lat, attrs.location.lng
      tagId = attrs.int_id
      tagId = 3 if tagId <3

      markerImage = new google.maps.MarkerImage(
        '/i/tags/' + @tags.get(tagId).attributes.path + '.png',
        new google.maps.Size(60,60),
        new google.maps.Point(0,0),
        new google.maps.Point(30,30),
        new google.maps.Size(60,60)
      );

      marker = new google.maps.Marker
        icon: markerImage,
        position: LatLng, 
        map: @map,
        title: attrs.title,
        model: attrs

      google.maps.event.addListener marker, 'click', @openPopover
      @markers.push marker

    openPopover: ()->
      tpl = Handlebars.compile popoverTemplate
      content = tpl @model

      infoWindow = new google.maps.InfoWindow
        content: content,
        position: @getPosition()

      infoWindow.open(that.map)
