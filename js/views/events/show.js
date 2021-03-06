// Generated by CoffeeScript 1.7.1
var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['views/base/view', 'text!templates/events/show.hbs', 'geo'], function(View, template, Geo) {
  'use strict';
  var showEvent;
  return showEvent = (function(_super) {
    var tagName;

    __extends(showEvent, _super);

    function showEvent() {
      this.addMarker = __bind(this.addMarker, this);
      this.setCenter = __bind(this.setCenter, this);
      this.createMap = __bind(this.createMap, this);
      this.initialize = __bind(this.initialize, this);
      return showEvent.__super__.constructor.apply(this, arguments);
    }

    showEvent.prototype.autoRender = true;

    showEvent.prototype.className = 'showEvent';

    showEvent.prototype.template = template;

    template = null;

    tagName = 'div';

    showEvent.prototype.initialize = function() {
      showEvent.__super__.initialize.apply(this, arguments);
      return this.geo = Geo.get();
    };

    showEvent.prototype.attach = function() {
      showEvent.__super__.attach.apply(this, arguments);
      $('#addEvent').css({
        'display': 'none'
      });
      this.createMap(new google.maps.LatLng(this.geo.firstCoords.lat, this.geo.firstCoords.lng));
      return this.geo.getCoords((function(_this) {
        return function(position) {
          var latlng;
          latlng = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
          return _this.map.setCenter(latlng);
        };
      })(this));
    };

    showEvent.prototype.createMap = function(startCoords) {
      var mapOptions;
      mapOptions = {
        zoom: 14,
        center: startCoords,
        mapTypeControl: true,
        mapTypeControlOptions: {
          style: google.maps.MapTypeControlStyle.DROPDOWN_MENU
        },
        navigationControl: true,
        navigationControlOptions: {
          style: google.maps.NavigationControlStyle.SMALL
        },
        mapTypeId: google.maps.MapTypeId.ROADMAP
      };
      this.map = new google.maps.Map(this.$el.find("#EventMap")[0], mapOptions);
      return this.me = new google.maps.Marker({
        position: startCoords,
        map: this.map,
        title: "You are here!"
      });
    };

    showEvent.prototype.setCenter = function(LatLng) {
      this.map.setCenter(LatLng);
      return this.me.setPosition(LatLng);
    };

    showEvent.prototype.addMarker = function(LatLng) {};

    return showEvent;

  })(View);
});

//# sourceMappingURL=show.map
