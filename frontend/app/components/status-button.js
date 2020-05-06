import Ember from 'ember';

export default Ember.Component.extend({

  actions: {
    click() {
      if (this.get('state') === "ready") {
        Ember.tryInvoke(this, 'action')
      }
    },
  },

});
