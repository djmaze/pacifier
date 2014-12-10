`import Ember from 'ember'`
`import AuthenticatedRoute from './authenticated'`

NotificationsRoute = AuthenticatedRoute.extend
  model: (params) ->
    #path = if params.repository then "repos/#{params.repository}/notifications" else 'notifications'
    path = 'notifications'
    @getData path, [], 1
  getData: (path, results, page) ->
    Ember.$.ajax(datatype: 'json', url: "https://api.github.com/#{path}?page=#{page}&per_page=50", cache: false).then (data) =>
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
