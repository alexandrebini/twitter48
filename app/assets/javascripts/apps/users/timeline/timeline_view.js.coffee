@Tweet48.module 'UsersApp.Timeline', (Timeline, App, Backbone, Marionette, $, _) ->

  class Timeline.Layout extends Marionette.LayoutView
    template: 'users/timeline/templates/layout'
    regions:
      formRegion: '.form-region'
      tweetsRegion: '.tweets-region'

  class Timeline.FormView extends Marionette.ItemView
    template: 'users/timeline/templates/form'
    ui:
      'text': 'input[type="text"]'
      'button': 'input[type="submit"]'

    events:
      'submit' : 'submit'
      'click @ui.button' : 'submit'

    submit: (e) ->
      e.preventDefault()
      text = @ui.text.val()
      @trigger 'submit:form', text if text?

  class Timeline.TweetView extends Marionette.ItemView
    tagName: 'li'
    template: 'users/timeline/templates/tweet'

  class Timeline.EmptyView extends Marionette.ItemView
    tagName: 'li'
    template: 'users/timeline/templates/empty'

  class Timeline.TweetsView extends Marionette.CollectionView
    childView: Timeline.TweetView
    emptyView: Timeline.EmptyView
    tagName: 'ul'