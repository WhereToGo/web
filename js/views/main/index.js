// Generated by CoffeeScript 1.7.1
var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['chaplin', 'handlebars', 'views/base/view', 'text!templates/main/index.hbs', 'text!templates/main/popover.hbs', 'geo', 'auth', 'models/tags-collection'], function(Chaplin, Handlebars, View, template, popoverTemplate, Geo, Auth, TagsCollection) {
  'use strict';
  var IndexView, that;
  that = null;
  return IndexView = (function(_super) {
    __extends(IndexView, _super);

    function IndexView() {
      this.addMarker = __bind(this.addMarker, this);
      this.setCenter = __bind(this.setCenter, this);
      this.createMap = __bind(this.createMap, this);
      this.initialize = __bind(this.initialize, this);
      return IndexView.__super__.constructor.apply(this, arguments);
    }

    IndexView.prototype.autoRender = true;

    IndexView.prototype.region = 'main';

    IndexView.prototype.template = template;

    template = null;

    IndexView.prototype.initialize = function() {
      IndexView.__super__.initialize.apply(this, arguments);
      this.geo = Geo.get();
      this.auth = Auth.get();
      this.tags = new TagsCollection();
      that = this;
      window.collection = this.collection;
      return this.tags.fetch({
        success: function() {
          return that.collection.fetch({
            success: function(collection) {
              var model, _i, _len, _ref, _results;
              _ref = collection.models;
              _results = [];
              for (_i = 0, _len = _ref.length; _i < _len; _i++) {
                model = _ref[_i];
                _results.push(that.addMarker(model.attributes));
              }
              return _results;
            }
          });
        }
      });
    };

    IndexView.prototype.attach = function() {
      IndexView.__super__.attach.apply(this, arguments);
      $('#addEvent').css({
        'display': 'block'
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

    IndexView.prototype.createMap = function(startCoords) {
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
      this.map = new google.maps.Map(this.$el.find("#mapView")[0], mapOptions);
      this.me = new google.maps.Marker({
        position: startCoords,
        map: this.map,
        title: "You are here!"
      });
      return this.markers = [];
    };

    IndexView.prototype.setCenter = function(LatLng) {
      this.map.setCenter(LatLng);
      return this.me.setPosition(LatLng);
    };

    IndexView.prototype.addMarker = function(attrs) {
      var LatLng, marker, markerImage, tagId;
      LatLng = new google.maps.LatLng(attrs.location.lat, attrs.location.lng);
      tagId = attrs.int_id;
      if (tagId < 3) {
        tagId = 3;
      }
      markerImage = new google.maps.MarkerImage('/i/tags/' + this.tags.get(tagId).attributes.path + '.png', new google.maps.Size(60, 60), new google.maps.Point(0, 0), new google.maps.Point(30, 30), new google.maps.Size(60, 60));
      marker = new google.maps.Marker({
        icon: markerImage,
        position: LatLng,
        map: this.map,
        title: attrs.title,
        model: attrs
      });
      google.maps.event.addListener(marker, 'click', this.openPopover);
      return this.markers.push(marker);
    };

    IndexView.prototype.openPopover = function() {
      var content, infoWindow, tpl, _ref;
      if ((_ref = that.activePopover) != null) {
        _ref.close();
      }
      tpl = Handlebars.compile(popoverTemplate);
      content = tpl(this.model);
      infoWindow = new google.maps.InfoWindow({
        content: content,
        position: this.getPosition(),
        maxWidth: 450
      });
      infoWindow.open(that.map);
      return that.activePopover = infoWindow;
    };

    return IndexView;

  })(View);
});
