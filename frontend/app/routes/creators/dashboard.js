import Ember from 'ember'
import InfiniteScroll from 'web/mixins/infinite-scroll'

export default Ember.Route.extend(InfiniteScroll, {

  session: Ember.inject.service(),

  beforeModel() {
    if (!this.get('session.isAuthenticated')) {
      this.transitionTo('login')
    }
  },

  model() {
    this.set('params', {offset: 0})
    return this.get('store').query('royalty', this.get('params')).then(results => results.toArray())
  },

  infiniteLoadMore() {
    this.set('controller.showLoader', true)
    let params = this.get('params')
    params.offset++
    this.set('params', params)
    return this.get('store').query('royalty', this.get('params')).then(results => {
      this.get('controller.model').pushObjects(results.toArray())
      this.set('controller.showLoader', false)
      Ember.run.later(this, () => {
        this.set('loading', false)
      }, 2000)
    })
  },

});
