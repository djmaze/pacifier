`import Ember from 'ember'`

NotificationsController = Ember.ArrayController.extend
  queryParams: ['repository']
  repository: null
  sortProperties: ['updated_at']
  sortAscending: true
  viewFilter: (item, index, enumerable) ->
    !item.isMuted && !item.isRead && !item.justSubscribed
  repositories: (->
    this.filter(@viewFilter).reduce (previousValue, item) ->
      repository = previousValue.findBy('name', item.repository.full_name) || { name: item.repository.full_name, count: 0 }
      repository.count += 1
      previousValue.pushObject repository unless repository.count > 1
      previousValue
    , Ember.ArrayProxy.create(content: Ember.A([])), 'repository'
    .sortBy('count').reverseObjects()
  ).property 'model.@each.hasMuted', 'model.@each.isRead', 'model.@each.justSubscribed'
  filteredNotifications: (->
    repository = @get 'repository'
    notifications = @get('arrangedContent')
      .filter(@viewFilter)
    notifications = if repository then notifications.filterBy('repository.full_name', repository) else notifications
    notifications[0..49]
  ).property 'repository', 'model', 'model.@each.hasMuted'

`export default NotificationsController`
