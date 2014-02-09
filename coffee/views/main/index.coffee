define [
  'chaplin'
  'handlebars'
  'views/base/view'
  'text!templates/main/index.hbs'
  'text!templates/main/popover.hbs'
  'geo'
], (Chaplin, Handlebars, View, template, popoverTemplate, Geo) ->
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
      that = @

      @collection.fetch
        success: ()=> console.log @

      
    
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
          title: "ololo1",
          description: "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Dicta, voluptatem facilis ipsa consequuntur itaque quisquam animi cupiditate voluptates deserunt porro cumque quis nesciunt. Impedit, possimus, nisi omnis consectetur nesciunt sed. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Iste, reiciendis, laudantium delectus quidem quos corrupti perspiciatis consequatur magni tempore accusantium consequuntur alias aut provident eius sit ratione excepturi officiis quasi. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nesciunt, ratione, odio, fugiat quaerat velit nulla numquam neque repellat deleniti animi inventore maxime quia aut! Repudiandae dolores sequi reprehenderit perferendis eveniet. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ipsam, quae, suscipit et expedita earum sequi alias deleniti at corporis corrupti iusto unde fugiat culpa natus doloribus ut quos sit voluptatum. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Neque incidunt possimus nemo. Non, perferendis, incidunt, ipsam, atque dolorem illum laudantium quam aliquam eius esse ex molestias alias magnam modi voluptas? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nisi, suscipit, optio ipsum est quam modi facere quaerat laudantium consequuntur consequatur quo odio totam expedita recusandae natus. Deserunt, velit quasi culpa. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Rerum, excepturi, accusantium, fugiat qui laboriosam velit quibusdam reiciendis asperiores fugit sint necessitatibus nulla ipsam ipsa est facere animi ducimus voluptas consequatur. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Debitis, provident, mollitia, officiis, aliquam at laboriosam in officia quo earum reprehenderit quam iste qui id temporibus odit culpa labore vitae placeat.",
          users: [
            {id:0, name: "Vyatcheslav Potravnyy"}
            {id:1, name: "Joe Lajoe"}
            {id:2, name: "Lara Kroft"}
            {id:3, name: "Sara Kerrigan"}
            {id:0, name: "Vyatcheslav Potravnyy"}
            {id:1, name: "Joe Lajoe"}
            {id:2, name: "Lara Kroft"}
            {id:3, name: "Sara Kerrigan"}
          ]
          path: "strike"
        }, new google.maps.LatLng 46.46568, 30.756255)
      , 3000)
      # test

    setCenter: (LatLng) =>
      @map.setCenter LatLng
      @me.setPosition LatLng


    addMarker: (model, LatLng)=>
      markerImage = new google.maps.MarkerImage(
        '/i/tags/' + model.path + '.png',
        new google.maps.Size(60,60),
        new google.maps.Point(0,0),
        new google.maps.Point(30,30),
        new google.maps.Size(60,60)
      );

      marker = new google.maps.Marker
        icon: markerImage,
        position: LatLng, 
        map: @map,
        title: model.title,
        model: model

      google.maps.event.addListener marker, 'click', @openPopover
      @markers.push marker

    openPopover: ()->
      tpl = Handlebars.compile popoverTemplate
      content = tpl @model

      infoWindow = new google.maps.InfoWindow
        content: content,
        position: @getPosition()

      infoWindow.open(that.map)



        


    

         
                    