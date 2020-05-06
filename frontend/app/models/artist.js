import DS from 'ember-data';

export default DS.Model.extend({

  backgroundStyle: DS.attr(),
  bio: DS.attr(),
  facebookUrl: DS.attr(),
  headerImage: DS.attr(),
  keywords: DS.attr(),
  listImageUrl: DS.attr(),
  name: DS.attr(),
  publish: DS.attr('boolean'),
  albums: DS.hasMany('album'),
  slug: DS.attr(),
  spotifyUrl: DS.attr(),
  twitterUrl: DS.attr(),
  videos: DS.attr(),
  youtubeUrl: DS.attr(),

});
