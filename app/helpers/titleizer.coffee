exports.title = (underscored) ->
  title = (titleize word for word in underscored.split("_"))
  title.join(" ")


titleize = (word) ->
  return word if word.match new RegExp(smallwords())
  return word.toUpperCase() if word.match new RegExp(acronyms())

  word.charAt(0).toUpperCase() + word.slice(1)

smallwords = ->
  ['^is$','to$', '^on$'].join('|')

acronyms = ->
  ['rsvp'].join('|')
