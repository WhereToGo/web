// Generated by CoffeeScript 1.7.1
var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['views/base/view', 'text!templates/login.hbs'], function(View, template) {
  'use strict';
  var Login;
  return Login = (function(_super) {
    __extends(Login, _super);

    function Login() {
      return Login.__super__.constructor.apply(this, arguments);
    }

    Login.prototype.autoRender = true;

    Login.prototype.className = 'hello-world';

    Login.prototype.template = template;

    template = null;

    Login.prototype.initialize = function() {};

    return Login;

  })(View);
});
