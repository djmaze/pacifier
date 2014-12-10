`import Ember from 'ember'`

TokenStore =
  read: ->
    new Ember.RSVP.Promise (resolve, reject) =>
      token = localStorage.getItem @cookieName
      if token then resolve token else reject()
  write: (token) ->
    localStorage.setItem @cookieName, token
  remove: ->
    localStorage.removeItem @cookieName
  cookieName: 'authorizationToken'

`export default TokenStore`
