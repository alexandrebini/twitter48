@Tweet48.module 'Modules', (Modules, App, Backbone, Marionette, $, _) ->

  class Modules.PageChanger
    @getInstance: ->
      @_instance ?= new @(arguments...)

    navigate: (route, options = {}) ->
      route = Modules.Routes.getInstance().urlFor(route)
      Backbone.history.navigate route, options

  API =
    navigate: (route) ->
      Modules.PageChanger.getInstance().navigate(route)

  App.vent.on 'visit', (route) ->
    API.navigate(route)