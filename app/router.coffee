`import Ember from 'ember'`

Router = Ember.Router.extend
  location: GithubNotificationsENV.locationType

Router.map ->
  @resource 'notifications'
  @resource 'notification', path: '/notification/:notification_id'

`export default Router`
