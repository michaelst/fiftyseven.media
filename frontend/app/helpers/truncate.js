import Ember from 'ember'

export function truncate(params/*, hash*/) {
  let string = params[0]
  let length = params[1]
  let ellipsis = params[2]

  if (string) {
    let truncatedString = string.substring(0, length);

    if (ellipsis === true && truncatedString.length < string.length) {
      truncatedString += '...'
    }

    return truncatedString;
  }
}

export default Ember.Helper.helper(truncate);
