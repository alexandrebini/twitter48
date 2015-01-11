@Tweet48.module 'UsersApp.Timeline', (Timeline, App, Backbone, Marionette, $, _) ->

  class Timeline.Controller extends App.Controllers.Base
    initialize: ->
      @layout = @getLayoutView()

      @listenTo @layout, 'show', =>
        @formRegion()

      App.timelineRegion.show @layout

    formRegion: ->
      formView = @getFormView()
      @listenTo formView, 'submit:form', (screenName) ->
        App.vent.trigger 'visit:timeline', screenName
      @layout.formRegion.show formView

    tweetsRegion: (tweets) ->
      tweetsView = @getTweetsView(tweets)
      @layout.tweetsRegion.show tweetsView

    getLayoutView: ->
      new Timeline.Layout()

    getFormView: ->
      new Timeline.FormView()

    getTweetsView: (tweets) ->
      new Timeline.TweetsView(collection: tweets)

    display: (screenName) ->
      tweets = App.request 'timeline:entity', screenName
      App.execute 'when:fetched', tweets, =>
        @tweetsRegion(tweets)