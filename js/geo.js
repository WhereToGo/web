// Generated by CoffeeScript 1.7.1
var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['singleton', 'async!http://maps.google.com/maps/api/js?sensor=true&key=AIzaSyAU43H9HS_S0p94SLnuU-oxadj6tzdUXx0'], function(Singleton) {
  'use strict';
  var Geo;
  return Geo = (function(_super) {
    __extends(Geo, _super);

    function Geo() {
      this.off = __bind(this.off, this);
      this.on = __bind(this.on, this);
      this.getCoordsError = __bind(this.getCoordsError, this);
      this.update = __bind(this.update, this);
      this.setCoords = __bind(this.setCoords, this);
      return Geo.__super__.constructor.apply(this, arguments);
    }

    Geo.prototype.coords = {
      lat: 46.48048,
      lng: 30.756235
    };

    Geo.prototype.LatLng = new google.maps.LatLng(46.48048, 46.48048);

    Geo.prototype.subscribers = [];

    Geo.prototype.init = function() {
      this.geocoder = new google.maps.Geocoder();
      this.update();
      return this.interval = setInterval(this.update, 1 * 60 * 1000);
    };

    Geo.prototype.setCoords = function(position) {
      var LatLngTMP;
      this.coords.lat = position.coords.latitude;
      this.coords.lng = position.coords.longitude;
      LatLngTMP = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
      return this.notify(LatLngTMP);
    };

    Geo.prototype.getCoords = function(callback, errorback) {
      if (errorback == null) {
        errorback = this.getCoordsError;
      }
      if (navigator.geolocation) {
        return navigator.geolocation.getCurrentPosition(callback, errorback);
      } else {
        return errorback(1);
      }
    };

    Geo.prototype.update = function() {
      return this.getCoords(this.setCoords);
    };

    Geo.prototype.getCoordsError = function(error) {
      switch (error.code) {
        case error.PERMISSION_DENIED:
          return alert("User denied the request for Geolocation.");
        case error.POSITION_UNAVAILABLE:
          return alert("Location information is unavailable.");
        case error.TIMEOUT:
          return alert("The request to get user location timed out.");
        case error.UNKNOWN_ERROR:
          return alert("An unknown error occurred.");
      }
    };

    Geo.prototype.notify = function(LatLngTMP) {
      var sub, _i, _len, _ref, _results;
      if (!LatLngTMP.equals(this.LatLng)) {
        this.LatLng = LatLngTMP;
        _ref = this.subscribers;
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          sub = _ref[_i];
          _results.push(sub(LatLngTMP));
        }
        return _results;
      }
    };

    Geo.prototype.on = function(type, handler) {
      if (type !== 'change') {
        throw new Error("Geo: no such event as '" + type + "'");
        return false;
      }
      if (!handler instanceof Function) {
        throw new Error("Geo: no such event as '" + type + "'");
        return false;
      }
      this.subscribers.push(handler);
      return handler;
    };

    Geo.prototype.off = function(type, handler) {
      var i, indexes, sub, _i, _len;
      if (handler == null) {
        handler = type;
      }
      indexes = (function() {
        var _i, _len, _ref, _results;
        _ref = this.subscribers;
        _results = [];
        for (i = _i = 0, _len = _ref.length; _i < _len; i = ++_i) {
          sub = _ref[i];
          if (sub === handler) {
            _results.push(i);
          }
        }
        return _results;
      }).call(this);
      for (_i = 0, _len = indexes.length; _i < _len; _i++) {
        i = indexes[_i];
        arr.splice(i);
      }
      return this;
    };

    return Geo;

  })(Singleton);
});

//# sourceMappingURL=geo.map
