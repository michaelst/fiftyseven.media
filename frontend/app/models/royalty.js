import DS from 'ember-data';

export default DS.Model.extend({

  album: DS.belongsTo('album', { async: true }),
  amount: DS.attr(),
  artist: DS.belongsTo('artist', { async: true }),
  commercial_model_type: DS.attr(),
  incoming_batch_description: DS.attr(),
  incoming_batch_source_name: DS.attr(),
  inserted_on: DS.attr(),
  percentage: DS.attr(),
  earned_amount: DS.attr(),
  quantity: DS.attr(),
  song: DS.belongsTo('song', { async: true }),
  territory_of_sale: DS.attr(),
  use_type: DS.attr(),

});
