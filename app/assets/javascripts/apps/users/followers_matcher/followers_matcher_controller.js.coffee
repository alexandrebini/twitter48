@Tweet48.module 'UsersApp.FollowersMatcher', (FollowersMatcher, App, Backbone, Marionette, $, _) ->

  class FollowersMatcher.Controller extends App.Controllers.Base
    initialize: ->
      @layout = @getLayoutView()

      @listenTo @layout, 'show', =>
        @formRegion()

      App.followersMatcherRegion.show @layout

    formRegion: ->
      formView = @getFormView()
      @listenTo formView, 'submit:form', (screenNames) ->
        App.vent.trigger 'visit:followers-matcher', screenNames
      @layout.formRegion.show formView

    followersRegion: (followers) ->
      followersView = @getFollowersView(followers)
      @layout.followersRegion.show followersView

    getLayoutView: ->
      new FollowersMatcher.Layout()

    getFormView: ->
      new FollowersMatcher.FormView()

    getFollowersView: (followers) ->
      new FollowersMatcher.FollowersView(collection: followers)

    display: (screenNames) ->
      followers = App.request 'followers:in-common:entities', screenNames
      App.execute 'when:fetched', followers, =>
        @followersRegion(followers)