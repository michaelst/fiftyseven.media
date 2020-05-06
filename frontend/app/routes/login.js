import Ember from 'ember';

export default Ember.Route.extend({

  session: Ember.inject.service(),

  classNames: ["d-flex align-items-center justify-content-center"],

  beforeModel() {
    if (this.get('session.isAuthenticated')) {
      this.get('session').invalidate()
    }
  }

});
