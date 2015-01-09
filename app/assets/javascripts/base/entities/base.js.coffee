@Tweet48.module 'Entities', (Entities, App, Backbone, Marionette, $, _) ->

  App.commands.setHandler 'when:fetched', (entities, callback, failCallback) ->
    xhrs = _.chain([entities]).flatten().pluck('_fetch').value()
    $.when(xhrs...)
      .done ->
        callback()
      .fail (e) ->
        failCallback() if failCallback