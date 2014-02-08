// Generated by CoffeeScript 1.7.1
var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['views/base/view', 'text!templates/startup.hbs'], function(View, template) {
  'use strict';
  var Startup;
  return Startup = (function(_super) {
    __extends(Startup, _super);

    function Startup() {
      this.afterRender = __bind(this.afterRender, this);
      this.initialize = __bind(this.initialize, this);
      return Startup.__super__.constructor.apply(this, arguments);
    }

    Startup.prototype.autoRender = true;

    Startup.prototype.region = 'main';

    Startup.prototype.template = template;

    template = null;

    Startup.prototype.initialize = function() {
      Startup.__super__.initialize.apply(this, arguments);
      return this.afterRender();
    };

    Startup.prototype.afterRender = function() {
      var getLocation, showError, showPosition, x;
      x = document.getElementById('main-container');
      getLocation = (function(_this) {
        return function() {
          if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(showPosition, showError);
          } else {
            x.innerHTML = "Geolocation is not supported by this browser.";
          }
        };
      })(this);
      showPosition = (function(_this) {
        return function(position) {
          var img_url, latlon;
          latlon = position.coords.latitude + "," + position.coords.longitude;
          img_url = "http://maps.googleapis.com/maps/api/staticmap?center=" + latlon + "&zoom=14&size=540x180&sensor=false";
          x.innerHTML = "<img class='map' src='" + img_url + "'>";
        };
      })(this);
      showError = (function(_this) {
        return function(error) {
          switch (error.code) {
            case error.PERMISSION_DENIED:
              return x.innerHTML = "User denied the request for Geolocation.";
            case error.POSITION_UNAVAILABLE:
              return x.innerHTML = "Location information is unavailable.";
            case error.TIMEOUT:
              return x.innerHTML = "The request to get user location timed out.";
            case error.UNKNOWN_ERROR:
              return x.innerHTML = "An unknown error occurred.";
          }
        };
      })(this);
      return getLocation();
    };

    return Startup;

  })(View);
});
