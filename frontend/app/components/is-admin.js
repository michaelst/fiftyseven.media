import Ember from 'ember';

export default Ember.Component.extend({

  session: Ember.inject.service(),

  isAdmin: Ember.computed('session.data.authenticated.user.id', function() {
    return this.get('session.data.authenticated.user.id') === '1'
  }),

});
