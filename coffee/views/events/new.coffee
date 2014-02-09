define [
  'chaplin'
  'views/base/view'
  'text!templates/events/new.hbs'
  'geo'
  'moment'
  'DTPicker'
], (Chaplin, View, template, Geo, moment) ->
  'use strict'

  class newEvent extends View
    # Automatically render after initialize.
    autoRender: true
    className: 'newEvent'
    template: template
    template = null    
    tagName = 'div'
    
    initialize: =>
      super
      @geo = Geo.get()

      @delegate 'submit', 'form', @submit
      @delegate 'input change', 'input', @validate

        
    attach: ()->
      super
      $('#addEvent').css('display' : 'none')
      @createMap new google.maps.LatLng @geo.firstCoords.lat, @geo.firstCoords.lng
      @geo.getCoords (position)=>
        latlng = new google.maps.LatLng position.coords.latitude, position.coords.longitude
        @map.setCenter latlng

      @$el.find(".inputLat").val @geo.firstCoords.lat
      @$el.find(".inputLng").val @geo.firstCoords.lng

      @initDatePicker()


    initDatePicker: ()=>
      @startDTP = @$el.find("#startDTPicker")
      @endDTP   = @$el.find("#endDTPicker")

      @startDTP.datetimepicker
        defaultDate: moment()
        endDate: moment().add "hours", 2
        useSeconds: false

      @endDTP.datetimepicker
        defaultDate: moment().add "hours", 2
        startDate: moment()
        useSeconds: false

      @startDTP.on 'change.dp', (e)=>
        val = $(e.target).data("DateTimePicker").getDate()
        @endDTP.data("DateTimePicker").setStartDate val

      @endDTP.on 'change.dp', (e)=>
        val = $(e.target).data("DateTimePicker").getDate()
        @startDTP.data("DateTimePicker").setEndDate val
      

    createMap: (startCoords)=>
      mapOptions = 
        zoom: 14,
        center: startCoords,
        mapTypeControl: true,
        mapTypeControlOptions: {style: google.maps.MapTypeControlStyle.DROPDOWN_MENU},
        navigationControl: true,
        navigationControlOptions: {style: google.maps.NavigationControlStyle.SMALL},
        mapTypeId: google.maps.MapTypeId.ROADMAP

      @map = new google.maps.Map @$el.find("#newEventMap")[0], mapOptions 

      @marker = new google.maps.Marker
        position: startCoords,
        map: @map,
        title: "Place for event"
        draggable: true

      google.maps.event.addListener @marker, 'dragend', ()=>
        LatLng = @marker.getPosition()
        @$el.find(".inputLat").val LatLng.lat()
        @$el.find(".inputLng").val LatLng.lng()

    setCenter: (LatLng) =>
      @map.setCenter LatLng
      @marker.setPosition LatLng

    addMarker: (LatLng)=>
      @$el.find(".inputLat").val LatLng.lat()
      @$el.find(".inputLng").val LatLng.lng()


    validate: ()=>
      canSave = true
      canSave = false if $("#eventTitle").val().length is 0
      start = moment @startDTP.data("DateTimePicker").getDate()
      end   = moment @endDTP.data("DateTimePicker").getDate()
      canSave = false if start >= end
      @$el.find(".btn-submit").toggleClass "disabled", !canSave


    submit: (e)=>
      e.preventDefault()
      fd = $(e.target).serializeObject()

      data =
        title: fd.title 
        description: fd.description
        location:
          lat: fd.lat
          lng: fd.lng
        user_id: 3 
        int_id: parseInt fd.tag
        start_date: moment(@startDTP.data("DateTimePicker").getDate()).utc().format "YYYY/MM/DDTHH:mm:ss"
        end_date:   moment(@endDTP.data("DateTimePicker").getDate()).utc().format "YYYY/MM/DDTHH:mm:ss"


      $.ajax
        url: "http://wtgser.azurewebsites.net/api/events/put"
        type: "POST"
        contentType: "application/json"
        data:JSON.stringify data
        success: (result) ->
          Chaplin.utils.redirectTo url: "/"
        error: (jqXHR, textStatus, errorThrown) ->
          consolo.log jqXHR
          alert "Error"
