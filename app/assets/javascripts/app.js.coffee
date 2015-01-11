@Tweet48 = do (Backbone, Marionette) ->
  App = new Marionette.Application

  App.addRegions
    timelineRegion: '.timeline-region'
    followersMatcherRegion: '.followers-matcher-region'

  App.addInitializer ->
    App.module('UsersApp').start()

  App.on 'start', ->
    @startHistory()

  App