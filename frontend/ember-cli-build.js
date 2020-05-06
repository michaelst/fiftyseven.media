/* eslint-env node */
'use strict';

const EmberApp = require('ember-cli/lib/broccoli/ember-app');
let Funnel = require('broccoli-funnel');
let UnwatchedDir = require('broccoli-source').UnwatchedDir;

module.exports = function(defaults) {
  let app = new EmberApp(defaults, {
    'ember-bootstrap': {
      bootstrapVersion: 4,
      importBootstrapFont: false,
      importBootstrapCSS: true
    },
  });

  // Use `app.import` to add additional libraries to the generated
  // output files.
  //
  // If you need to use different assets in different
  // environments, specify an object as the first parameter. That
  // object's keys should be the environment name and the values
  // should be the asset to use in that environment.
  //
  // If the library that you are including contains AMD or ES6
  // modules that you would like to import into your application
  // please specify an object with the list of modules as keys
  // along with the exports of each module as its value.

  app.import('vendor/font-awesome/fa-brands.min.js');
  app.import('vendor/font-awesome/fa-regular.min.js');
  app.import('vendor/font-awesome/fontawesome.min.js');

  if (EmberApp.env() === 'production') {
    app.import('node_modules/raven-js/dist/raven.js');
    app.import('node_modules/raven-js/dist/plugins/ember.js');
  }

  //app.import('vendor/spacial/js/theme.js');
  //app.import('vendor/spacial/js/custom/slider.js');
  //app.import('vendor/spacial/js/vendor/manual-loaded/panolens.min.js');
  //app.import('vendor/spacial/js/vendor/gmaps.js');
  //app.import('vendor/spacial/js/vendor/imagesloaded.js');
  //app.import('vendor/spacial/js/vendor/jquery.ajaxchimp.js');
  //app.import('vendor/spacial/js/vendor/jquery.elevateZoom-3.0.8.min.js');
  //app.import('vendor/spacial/js/vendor/jquery.magnific.popup.js');
  //app.import('vendor/spacial/js/vendor/jquery.panorama_viewer.js');
  //app.import('vendor/spacial/js/vendor/jquery.simple-text-rotator.js');
  //app.import('vendor/spacial/js/vendor/masonry.min.js');
  //app.import('vendor/spacial/js/vendor/modernizr.js');
  //app.import('vendor/spacial/js/vendor/pikaday.js');
  //app.import('vendor/spacial/js/vendor/scroll.min.js');
  //app.import('vendor/spacial/js/vendor/scrolltrigger.js');
  //app.import('vendor/spacial/js/vendor/skrollr.min.js');
  //app.import('vendor/spacial/js/vendor/youtube.bg.js');

  return app.toTree();
};
