import Ember from 'ember'

export function substring(params/*, hash*/) {
  let string = params[0]
  let start = params[1]
  let stop = params[2]

  if (string) {
    if (stop) {
      return string.slice(start, stop)
    } else {
      return string.slice(start)
    }
  }
}

export default Ember.Helper.helper(substring)
