import Ember from 'ember'
import config from './config/environment'

const Router = Ember.Router.extend({
  location: config.locationType,
  rootURL: config.rootURL
})

Router.map(function() {
  this.route('home', { path: '/' })
  this.route('login')

  this.route('music', function() {
    this.route('artists')
    this.route('artist', { path: '/artist/:id/:slug' })
    this.route('releases')
    this.route('join')
  })

  this.route('legal', function() {
    this.route('privacy-policy')
    this.route('terms-of-use')
  })

  this.route('creators', function() {
    this.route('dashboard')
    this.route('balance')
  })
})

export default Router
