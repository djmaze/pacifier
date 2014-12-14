`import Ember from 'ember'`
`import config from './config/environment'`

Router = Ember.Router.extend
  location: config.locationType

Router.map ->
  @resource 'notifications'
  @resource 'notification', path: '/notification/:notification_id'

`export default Router`
