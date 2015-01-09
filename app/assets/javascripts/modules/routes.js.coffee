@Tweet48.module 'Modules', (Modules, App, Backbone, Marionette, $, _) ->

  class Modules.Routes
    @getInstance: ->
      @_instance ?= new @(arguments...)

    rootPath: ->
      @urlFor '/'

    timelinePath: (screnName) ->
      @urlFor "/timeline/#{ screnName }/"

    followersMatcherPath: (screenNames) ->
      @urlFor "/followers-matcher/#{ screenNames.join('/') }/"

    urlFor: (route) ->
      Modules.UrlHelper.getInstance().urlFor route