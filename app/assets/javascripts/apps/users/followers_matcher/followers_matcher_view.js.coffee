@Tweet48.module 'UsersApp.FollowersMatcher', (FollowersMatcher, App, Backbone, Marionette, $, _) ->

  class FollowersMatcher.Layout extends Marionette.LayoutView
    template: 'users/followers_matcher/templates/layout'
    regions:
      formRegion: '.form-region'
      followersRegion: '.followers-region'

  class FollowersMatcher.FormView extends Marionette.ItemView
    template: 'users/followers_matcher/templates/form'
    ui:
      'firstUser': 'input.first-user'
      'secondUser': 'input.second-user'
      'button': 'input[type="submit"]'

    events:
      'submit' : 'submit'
      'click @ui.button' : 'submit'

    submit: (e) ->
      e.preventDefault()
      firstUser = @ui.firstUser.val()
      secondUser = @ui.secondUser.val()
      if firstUser? && secondUser?
        @trigger 'submit:form', [firstUser, secondUser]

  class FollowersMatcher.FollowerView extends Marionette.ItemView
    tagName: 'li'
    template: 'users/followers_matcher/templates/follower'

  class FollowersMatcher.EmptyView extends Marionette.ItemView
    tagName: 'li'
    template: 'users/followers_matcher/templates/empty'

  class FollowersMatcher.FollowersView extends Marionette.CollectionView
    childView: FollowersMatcher.FollowerView
    emptyView: FollowersMatcher.EmptyView
    tagName: 'ul'