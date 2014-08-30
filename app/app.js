import Ember from 'ember';
import Resolver from 'ember/resolver';
import loadInitializers from 'ember/load-initializers';

Ember.MODEL_FACTORY_INJECTIONS = true;

var App = Ember.Application.extend({
  modulePrefix: 'github-notifications', // TODO: loaded via config
  Resolver: Resolver
});

//Ember.$.ajaxSetup({ cache: false });
Ember.$.ajaxPrefilter(function(options, originalOptions, xhr) {
  xhr.setRequestHeader('authorization', 'token <REPLACEME>');
});

loadInitializers(App, 'github-notifications');

Ember.Handlebars.registerBoundHelper('formattedDate', function(date) {
    return moment(date).fromNow();
});

export default App;
