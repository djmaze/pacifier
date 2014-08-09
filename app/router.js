import Ember from 'ember';

var Router = Ember.Router.extend({
  location: GithubNotificationsENV.locationType
});

Router.map(function() {
});

export default Router;
