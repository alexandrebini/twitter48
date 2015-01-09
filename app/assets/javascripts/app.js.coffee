@Tweet48 = do (Backbone, Marionette) ->
  App = new Marionette.Application

  App.addRegions
    someRegion: '.some-region'

  App.addInitializer ->
    App.module('SomeApp').start()

  App.on 'start', ->
    @startHistory()

  App