// Generated by CoffeeScript 1.7.1
var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['chaplin', 'auth', 'views/site-view', 'views/header-view'], function(Chaplin, Auth, SiteView, HeaderView) {
  'use strict';
  var Controller;
  return Controller = (function(_super) {
    __extends(Controller, _super);

    function Controller() {
      return Controller.__super__.constructor.apply(this, arguments);
    }

    Controller.prototype.beforeAction = function(params, route) {
      this.reuse('site', SiteView);
      this.reuse('header', HeaderView, {
        region: 'header'
      });
      return this.redirectUnlessLogin(route);
    };

    Controller.prototype.redirectUnlessLogin = function(route) {
      var auth;
      auth = Auth.get();
      if (!/login|register/.test(route.path)) {
        if (!auth.isLogged()) {
          this.redirectTo({
            url: '/login'
          });
          return false;
        }
      }
      if (auth.isLogged() && /login|register/.test(route.path)) {
        this.redirectTo({
          url: '/'
        });
        return false;
      }
      return true;
    };

    return Controller;

  })(Chaplin.Controller);
});

//# sourceMappingURL=controller.map
