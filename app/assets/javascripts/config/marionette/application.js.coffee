do (Backbone) ->

  _.extend Backbone.Marionette.Application::,

    startHistory: ->
      Backbone.history.start({ pushState: true })
      $(document).on 'click', 'a[data-internal]', (ev) ->
        ev.preventDefault()

    register: (instance, id) ->
      @_registry ?= {}
      @_registry[id] = instance

    unregister: (instance, id) ->
      delete @_registry[id]

    resetRegistry: ->
      oldCount = @getRegistrySize()
      for key, controller of @_registry
        controller.region.destroy()
      msg = "There were #{ oldCount } controllers in the registry, there are now #{ @getRegistrySize() }"
      if @getRegistrySize() > 0
        console.warn(msg, @_registry)
      else
        console.log(msg)

    getRegistrySize: ->
      _.size @_registry