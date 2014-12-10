`import config from '../config/environment'`
`import TokenStore from '../models/token_store'`

ApplicationToriiAdapter = Ember.Object.extend
  open: (authentication) ->
    console.log 'open'
    authorizationCode = authentication.authorizationCode
    new Ember.RSVP.Promise((resolve, reject) ->
      Ember.$.ajax
        url: config.gatekeeperURL + authorizationCode
        #dataType: "json"
        success: Ember.run.bind(null, resolve)
        error: Ember.run.bind(null, reject)
    ).then (token) ->
      TokenStore.write token
      authorizationToken: token
  fetch: ->
    console.log 'fetch'
    TokenStore.read().then (token) ->
      console.log 'fetched ' + token
      authorizationToken: token
  close: ->
    console.log 'close'
    TokenStore.remove()

`export default ApplicationToriiAdapter`
