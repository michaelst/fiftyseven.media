import GraphQLAdapter from 'ember-graphql-adapter'
import DataAdapterMixin from 'ember-simple-auth/mixins/data-adapter-mixin'
import ENV from 'web/config/environment'

export default GraphQLAdapter.extend(DataAdapterMixin, {

  endpoint: ENV.url,
  authorizer: 'authorizer:custom',

})
