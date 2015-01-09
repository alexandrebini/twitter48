@Tweet48.module 'Controllers', (Controllers, App, Backbone, Marionette, $, _) ->

  class Controllers.Base extends Marionette.Controller

    constructor: (options = {}) ->
      super options
      @_instance_id = _.uniqueId('controller')
      App.execute 'register:instance', @, @_instance_id

    onDestroy: ->
      @layout.destroy() if @layout
      App.execute 'unregister:instance', @, @_instance_id