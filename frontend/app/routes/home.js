import Ember from 'ember'

export default Ember.Route.extend({

  isAnimating: false,
  current: 0,

  model() {
    return Ember.RSVP.hash({
      albums: Ember.RSVP.resolve(
        this.get('store').query('album', {first: 8}).then(results => results.toArray())
      ),
    })
  },

  actions: {
    slide(dir) {
      if( this.get('isAnimating') ) return false
      this.set('isAnimating', true)

      let self = this
      let items = Ember.$('#slider-items.itemwrap').children()
      let itemsCount = items.length
      let cntAnims = 0
      let current = this.get('current')
      let currentItem = items[current]

      items.each((k, item) => {
        Ember.$(item).removeClass('navOutNext')
        Ember.$(item).removeClass('navOutPrev')
        Ember.$(item).removeClass('navInNext')
        Ember.$(item).removeClass('navInPrev')
      })

      if( dir === 'next' ) {
          current = current < itemsCount - 1 ? current + 1 : 0
      }
      else if( dir === 'prev' ) {
          current = current > 0 ? current - 1 : itemsCount - 1
      }

      this.set('current', current)

      let nextItem = items[current ]

      let onEndAnimationCurrentItem = function() {
          Ember.$(this).removeClass( 'current' )
          Ember.$(this).removeClass( dir === 'next' ? 'navOutNext' : 'navOutPrev' )
          ++cntAnims
          if( cntAnims === 2 ) {
            self.set('isAnimating', false)
          }
      }

      let onEndAnimationNextItem = function() {
          Ember.$(this).addClass( 'current' )
          Ember.$(this).removeClass( dir === 'next' ? 'navInNext' : 'navInPrev' )
          ++cntAnims
          if( cntAnims === 2 ) {
            self.set('isAnimating', false)
          }
      }

      onEndAnimationCurrentItem()
      onEndAnimationNextItem()

      Ember.$(currentItem).addClass( dir === 'next' ? 'navOutNext' : 'navOutPrev' )
      Ember.$(nextItem).addClass( dir === 'next' ? 'navInNext' : 'navInPrev' )
      Ember.$(nextItem).addClass('current').delay(100).queue(function(next){
        Ember.$(currentItem).removeClass('current')
        next();
      })
    },
  }

})
