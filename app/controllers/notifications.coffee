`import Ember from 'ember'`

NotificationsController = Ember.ArrayController.extend
  queryParams: ['repository']
  repository: null
  sortProperties: ['updated_at']
  sortAscending: true
  viewFilter: (item, index, enumerable) ->
    !item.isMuted && !item.isSubscribed && !item.isRead
  repositories: (->
    this.filter(@viewFilter).reduce (previousValue, item) ->
      repository = previousValue.findBy('name', item.repository.full_name) || { name: item.repository.full_name, count: 0 }
      repository.count += 1
      previousValue.pushObject repository unless repository.count > 1
      previousValue
    , Ember.ArrayProxy.create(content: Ember.A([])), 'repository'
  ).property 'model.@each.hasMuted', 'model.@each.isRead'
  filteredNotifications: (->
    repository = @get 'repository'
    notifications = @get('arrangedContent')
      .filter(@viewFilter)
    if repository then notifications.filterBy('repository.full_name', repository) else notifications
  ).property 'repository', 'model', 'model.@each.hasMuted'

`export default NotificationsController`
