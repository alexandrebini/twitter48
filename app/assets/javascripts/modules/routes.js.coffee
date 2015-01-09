@Tweet48.module 'Modules', (Modules, App, Backbone, Marionette, $, _) ->

  class Modules.Routes
    @getInstance: ->
      @_instance ?= new @(arguments...)

    rootPath: ->
      @urlFor '/'

    phrasePath: (id) ->
      "/#{ id }/tasks/"

    taskPath: (phraseId, taskId) ->
      "#{ phraseId }/tasks/#{ taskId }/managers/"

    urlFor: (route) ->
      Modules.UrlHelper.getInstance().urlFor route