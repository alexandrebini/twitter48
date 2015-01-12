@Tweet48.module 'Entities', (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Follower extends Backbone.Model

  class Entities.Followers extends Backbone.Collection
    model: Entities.Follower
    url: '/api/followers.json'

  API =
    getFollowersInCommon: (screenNames) ->
      followers = new Entities.Followers()
      followers.fetch
        url: '/api/followers/in_common.json'
        data: { screen_names: screenNames }
      followers

  App.reqres.setHandler 'followers:in-common:entities', (screenNames) ->
    API.getFollowersInCommon(screenNames)