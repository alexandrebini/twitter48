@Tweet48.module 'Entities', (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Tweet extends Backbone.Model

  class Entities.Timeline extends Backbone.Collection
    model: Entities.Tweet
    url: '/api/timelines.json'

  API =
    getTimeline: (screnName) ->
      timeline = new Entities.Timeline()
      timeline.fetch
        data: { screen_name: screnName }
      timeline

  App.reqres.setHandler 'timeline:entity', (screenName) ->
    API.getTimeline(screenName)