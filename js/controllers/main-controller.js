// Generated by CoffeeScript 1.7.1
var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['controllers/base/controller', 'models/user', 'views/login'], function(Controller, User, Login) {
  'use strict';
  var HelloController;
  return HelloController = (function(_super) {
    __extends(HelloController, _super);

    function HelloController() {
      return HelloController.__super__.constructor.apply(this, arguments);
    }

    HelloController.prototype.login = function(params) {
      this.model = new User();
      return this.view = new Login({
        model: this.model,
        region: 'main'
      });
    };

    return HelloController;

  })(Controller);
});