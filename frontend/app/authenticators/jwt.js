import Ember from 'ember'
import Base from 'ember-simple-auth/authenticators/base'
import graphql from 'npm:graphql-request'
import ENV from 'web/config/environment'

const { RSVP: { Promise }, run } = Ember;

export default Base.extend({

  session: Ember.inject.service(),

  restore(data) {
    return new Promise((resolve, reject) => {
      if (!Ember.isEmpty(data.token)) {
        resolve(data)
      } else {
        reject()
      }
    })
  },

  authenticate(credentials) {
    const { email, password } = credentials

    let query = `mutation UserLogin {
      login(email: "` + email + `", password: "` + password + `") {
        token
        user {
          id
          username
          email
          balance
        }
      }
    }`

    return new Promise((resolve, reject) => {
      graphql.request(ENV.url, query).then((response) => {
        run(() => {
          resolve({
            token: response.login.token,
            user: response.login.user,
          })
        })
       }, (error) => {
          run(() => {
            reject(error)
          })
        })
    })

  },

  invalidate(data) {
    return Promise.resolve(data)
  }
})
