@Tweet48.module 'Modules', (Modules, App, Backbone, Marionette, $, _) ->

  class Modules.UrlHelper
    @getInstance: ->
      @_instance ?= new @(arguments...)

    urlFor: (route) ->
      route = '/' unless route?
      route = "/#{ route }" if route.slice(0) isnt '/'
      route = "#{ route }/" if route.slice(-1) isnt '/'

      route = route.replace(/\/\//g, '/')
      route

    currentPath: ->
      @urlFor Backbone.history.fragment