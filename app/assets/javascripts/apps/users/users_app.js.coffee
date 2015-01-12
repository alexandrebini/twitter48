@Tweet48.module 'UsersApp', (UsersApp, App, Backbone, Marionette, $, _) ->
  @startWithParent = false

  class UsersApp.Router extends Marionette.AppRouter
    appRoutes:
      'timeline/:screenNames/' : 'timeline'
      'followers-matcher/*screenNames/' : 'followersMatcher'

  API =
    start: ->
      @timelineController = new UsersApp.Timeline.Controller()
      @followersMatcherController = new UsersApp.FollowersMatcher.Controller()

    timeline: (screenName) ->
      @timelineController.display(screenName)

    followersMatcher: (screenNames) ->
      screenNames = screenNames.split('/') if _.isString(screenNames)
      @followersMatcherController.display(screenNames)

  UsersApp.on 'start', ->
    new UsersApp.Router
      controller: API
    API.start()

  App.vent.on 'visit:timeline', (screenName) ->
    App.vent.trigger 'visit', App.Modules.Routes.getInstance().timelinePath(screenName)
    API.timeline(screenName)

  App.vent.on 'visit:followers-matcher', (screenNames) ->
    App.vent.trigger 'visit', App.Modules.Routes.getInstance().followersMatcherPath(screenNames)
    API.followersMatcher(screenNames)