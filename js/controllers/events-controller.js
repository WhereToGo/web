// Generated by CoffeeScript 1.7.1
var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['controllers/base/controller', 'models/base/model', 'views/events/new', 'views/events/show'], function(Controller, Model, newEvent, showEvent) {
  'use strict';
  var EventsController;
  return EventsController = (function(_super) {
    __extends(EventsController, _super);

    function EventsController() {
      this.show = __bind(this.show, this);
      this.add = __bind(this.add, this);
      return EventsController.__super__.constructor.apply(this, arguments);
    }

    EventsController.prototype.add = function() {
      return this.view = new newEvent({
        region: 'main'
      });
    };

    EventsController.prototype.show = function() {
      return this.view = new showEvent({
        region: 'main'
      });
    };

    return EventsController;

  })(Controller);
});

//# sourceMappingURL=events-controller.map
