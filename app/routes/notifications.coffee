`import Ember from 'ember'`

NotificationsRoute = Ember.Route.extend
  model: (params) ->
    #path = if params.repository then "repos/#{params.repository}/notifications" else 'notifications'
    path = 'notifications'
    @getData path, [], 1
  getData: (path, results, page) ->
    Ember.$.getJSON("https://api.github.com/#{path}?page=#{page}&per_page=50").then (data) =>
      if data.length > 0
        @getData path, results.concat(data), page + 1
      else
        results
      #results.concat data

  renderTemplate: ->
    @render 'notifications'
    @render 'notifications/index',
      outlet: 'index'
      into: 'notifications'

`export default NotificationsRoute`
