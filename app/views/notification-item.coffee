`import Ember from 'ember'`

NotificationItemView = Ember.View.extend
  tagName: 'tr'
  classNameBindings: ['isActive']
  isActive: false
  mouseEnter: ->
    @set 'isActive', true
  mouseLeave: ->
    @set 'isActive', false
  click: ->
    if confirm("Mark read until here?")
      @get('controller').muteAllNotificationsUntilHere()


`export default NotificationItemView`
