`import Ember from 'ember'`

NotificationsController = Ember.ArrayController.extend
  queryParams: ['repository']
  repository: null
  sortProperties: ['updated_at']
  sortAscending: true
  muteAllNotificationsUntil: (model) ->
    alert "TODO" + @get('filteredNotifications').indexOf(model)
  repositories: (->
    this.reduce (previousValue, item) ->
      repository = previousValue.findBy('name', item.repository.full_name) || { name: item.repository.full_name, count: 0 }
      repository.count += 1
      previousValue.pushObject repository unless repository.count > 1
      previousValue
    , Ember.ArrayProxy.create(content: Ember.A([])), 'repository'
  ).property 'model.@each'
  filteredNotifications: (->
    repository = @get 'repository'
    notifications = @get 'arrangedContent'
    repositories = if repository then notifications.filterBy('repository.full_name', repository) else notifications
    repositories
  ).property 'repository', 'model'

`export default NotificationsController`
