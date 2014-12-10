`import Ember from 'ember'`

AuthenticatedRoute = Ember.Route.extend
  beforeModel: (transition) ->
    unless @get('session').get('isAuthenticated')
      transition.abort()
      @authenticateSession()

  authenticateSession: ->
    @get('session').fetch('github-oauth2').then =>
      @authenticatedWithToken @get('session').get('authorizationToken')
    , (error) =>
      @get('session').open('github-oauth2').then =>
        @authenticatedWithToken @get('session').get('authorizationToken')
      , (error) ->
        alert "Error: " + error

  authenticatedWithToken: (token) ->
    Ember.$.ajaxPrefilter (options, originalOptions, xhr) ->
      xhr.setRequestHeader 'authorization', "token #{token}"
    @transitionTo 'notifications'

  actions:
    invalidateSession: ->
      @get('session').close('github-oauth2').then ->
        alert("Successfully logged out")

`export default AuthenticatedRoute`
