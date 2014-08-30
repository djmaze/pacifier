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

  new: (->
    @get('last_read_at') == null
  ).property('last_read_at')

  participating: (->
    @get('reason') == 'participating' # ??
  ).property('reason')

  actions:
    subscribe: ->
      alert('Woohoo! You did it!')
    goto: ->
      @set 'isLoading', true
      Ember.$.getJSON(@get('subject.latest_comment_url')).then (comment_data) =>
        window.open comment_data.html_url, '_blank'
        @set 'isLoading', false
  markAsRead: ->
    # FIXME Get this working
    model = @get('controllers.notifications').get('model')
  muteAllNotificationsUntilHere: ->
    @get('controllers.notifications').muteAllNotificationsUntil(@get('model'))

`export default NotificationController`
