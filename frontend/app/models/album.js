import Ember from 'ember'
import DS from 'ember-data'

export default DS.Model.extend({

  artist: DS.belongsTo('artist', { async: true }),
  artworkUrl: DS.attr(),
  listenUrl: DS.attr(),
  publish: DS.attr('boolean'),
  title: DS.attr(),

  backgroundStyle: Ember.computed('artworkUrl', function() {
    return Ember.String.htmlSafe("background: url(" + this.get('artworkUrl') + ") no-repeat center center;")
  }),

});
