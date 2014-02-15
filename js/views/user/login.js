// Generated by CoffeeScript 1.7.1
var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['views/base/view', 'text!templates/user/login.hbs'], function(View, template) {
  'use strict';
  var LoginView;
  return LoginView = (function(_super) {
    __extends(LoginView, _super);

    function LoginView() {
      this.join = __bind(this.join, this);
      return LoginView.__super__.constructor.apply(this, arguments);
    }

    LoginView.prototype.autoRender = true;

    LoginView.prototype.className = 'loginView';

    LoginView.prototype.template = template;

    template = null;

    LoginView.prototype.initialize = function() {
      LoginView.__super__.initialize.apply(this, arguments);
      this.delegate('submit', 'form', this.join);
      return this.delegate('input focus', '.has-error #inputPassword', (function(_this) {
        return function() {
          return _this.$el.find("#inputPassword").closest(".form-group").removeClass("has-error");
        };
      })(this));
    };

    LoginView.prototype.join = function(e) {
      var formData;
      e.preventDefault();
      formData = $(e.target).serializeObject();
      return $.ajax({
        url: "http://wtgser.azurewebsites.net/api/users/postme",
        type: "POST",
        contentType: "application/json",
        data: JSON.stringify(formData),
        error: (function(_this) {
          return function() {
            return _this.$el.find("#inputPassword").closest(".form-group").addClass("has-error");
          };
        })(this),
        success: (function(_this) {
          return function(user) {
            formData.id = JSON.parse(user)["user_id"];
            return _this.publishEvent("logged", formData);
          };
        })(this)
      });
    };

    return LoginView;

  })(View);
});

//# sourceMappingURL=login.map
