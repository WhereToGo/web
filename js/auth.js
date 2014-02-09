// Generated by CoffeeScript 1.7.1
var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['singleton'], function(Singleton) {
  'use strict';
  var Auth;
  return Auth = (function(_super) {
    __extends(Auth, _super);

    function Auth() {
      this.save = __bind(this.save, this);
      this.loadID = __bind(this.loadID, this);
      this.load = __bind(this.load, this);
      this.createToken = __bind(this.createToken, this);
      this.tryToLogin = __bind(this.tryToLogin, this);
      this.logout = __bind(this.logout, this);
      this.login = __bind(this.login, this);
      return Auth.__super__.constructor.apply(this, arguments);
    }

    Auth.prototype.token = "";

    Auth.prototype.init = function() {
      this.token = this.load();
      return this.id = this.loadID();
    };

    Auth.prototype.isLogged = function() {
      return !!this.token;
    };

    Auth.prototype.login = function(options) {
      if (options == null) {
        options = {};
      }
      if (this.tryToLogin(options)) {
        this.token = this.createToken(options);
        this.id = options.id;
        this.save();
        return true;
      } else {
        return false;
      }
    };

    Auth.prototype.logout = function(options) {
      if (options == null) {
        options = {};
      }
      this.token = "";
      this.id = "";
      return this.save();
    };

    Auth.prototype.tryToLogin = function(options) {
      if (options == null) {
        options = {};
      }
      return !!options.login;
    };

    Auth.prototype.createToken = function(options) {
      if (options == null) {
        options = {};
      }
      return options.login;
    };

    Auth.prototype.load = function() {
      return localStorage.getItem("auth");
    };

    Auth.prototype.loadID = function() {
      return localStorage.getItem("user_id");
    };

    Auth.prototype.save = function() {
      localStorage.setItem("auth", this.token);
      return localStorage.setItem("user_id", this.id);
    };

    return Auth;

  })(Singleton);
});
