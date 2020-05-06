import ENV from '../config/environment'
import Ember from 'ember'

/* global Raven */

export function initialize() {
  // makes a mess of js stack traces in dev
  if (!ENV.isProduction) {
    return
  }

  Raven
    .config('https://f78b0658678443beaa32db78304a03cd@sentry.io/279032', {
      release: '<<<head_long>>>',
      environment: ENV.environment,
    })
    .addPlugin(Raven.Plugins.Ember, Ember)
    .install()
}

export default {
  name: 'sentry',
  initialize
}
