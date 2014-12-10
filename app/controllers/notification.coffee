`import Ember from 'ember'`

NotificationController = Ember.ObjectController.extend
  needs: ['notifications']

  urlAtGithub: (->
    @get 'subject.latest_comment_url'
  ).property('subject.latest_commit_url')

  octiconClass: (->
    switch @get('subject.type')
      when 'PullRequest' then 'octicon-git-pull-request'
      when 'Issue' then 'octicon-issue-opened'
      when 'Commit' then 'octicon-git-commit'
      else @get('subject.type')
  ).property('subject.type')

  isNew: (->
    @get('last_read_at') == null
  ).property('last_read_at')

  participating: (->
    @get('reason') == 'participating' # ??
  ).property('reason')

  isSubscribed: (->
    @get('reason') == 'manual'
  ).property 'reason'

  actions:
    toggleSubscription: ->
      @set 'reason', if @get('reason') == 'manual' then 'subscribed' else 'manual'
      subscribed = @get('isSubscribed')
      @set 'model.justSubscribed', subscribed
      Ember.$.ajax
        url: @get('subscription_url'), type: 'PUT',
        data: JSON.stringify(subscribed: subscribed)
      false
    goto: ->
      @set 'isLoading', true
      new Ember.RSVP.Promise((resolve, reject) =>
        if @get('private')
          # We would need "repo" permission in order to fetch the latest comment URL for a notification in a private repository
          # This is definitely too much for now
          resolve subject.url
        else
          Ember.$.getJSON(@get('subject.latest_comment_url')).then (comment_data) =>
            resolve comment_data.html_url
      ).then (url) =>
        window.open url, '_blank'
        @set 'isLoading', false
        @set 'isRead', true
    muteAllNotificationsUntilHere: ->
      filteredNotifications = @get 'controllers.notifications.filteredNotifications'
      @muteThreadForNotification notification for notification in filteredNotifications[0..filteredNotifications.indexOf(@get('model'))] when notification.isSubscribed isnt true
      @set 'hasMuted', true

  muteThreadForNotification: (notification) ->
    console.log "Mark as read #{notification.id} #{notification.subject.title}"
    Ember.$.ajax
      url: notification.url, type: 'PATCH'
    console.log "Mute #{notification.id} #{notification.subject.title}"
    Ember.$.ajax
      url: notification.subscription_url, type: 'PUT',
      data: JSON.stringify(ignored: true)
    cont = @get('controllers.notifications.model').findBy('id', notification.id)
    notification.isMuted = true

`export default NotificationController`
