//= require jquery
//= require underscore
//= require bootstrap
//= require backbone
//= require backbone.babysitter
//= require backbone.wreqr
//= require backbone.marionette
//= require hamlcoffee

//= require_tree ./config

//= require app
//= require_tree ./base
//= require_tree ./entities
//= require_tree ./modules
//= require_tree ./apps

$(document).ready ->
  Tweet48.start()