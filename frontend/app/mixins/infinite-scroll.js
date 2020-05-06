import Ember from 'ember';
import Mixin from '@ember/object/mixin';

export default Mixin.create({

  loading: false,

  finished: false,

  init() {
    Ember.run.scheduleOnce('afterRender', this, function() {
      Ember.$(window).on('scroll', () => {
        let scrollPos = Ember.$(window).scrollTop() + Ember.$(window).height()
        if (scrollPos > Ember.$(document).height() - 500 && !this.get('loading')) {
          this.set('loading', true)
          this.infiniteLoadMore()
        }
      })
    });
    return this._super(...arguments);
  },

});
