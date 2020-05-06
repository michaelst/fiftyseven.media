import Ember from 'ember'

export default Ember.Controller.extend({

  session: Ember.inject.service(),

  buttonState: 'ready',
  error: null,

  actions: {
    login() {
      this.set('error', null)
      this.set('buttonState', 'loading')

      let credentials = this.getProperties('email', 'password')

      this.get('session').authenticate('authenticator:jwt', credentials)
      .then(() => {
        this.set('buttonState', 'success')
        this.transitionToRoute('creators.dashboard').then(() => this.set('buttonState', 'ready'))
      })
      .catch(error => {
        this.set('error', error.response.errors[0].message.split(':')[1])
        this.set('buttonState', 'ready')
      })
    },
  },

});
