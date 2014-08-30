`import Ember from 'ember'`

IndexRoute = Ember.Route.extend
  redirect: ->
    @transitionTo 'notifications'

`export default IndexRoute`
