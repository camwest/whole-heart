process.env.NODE_ENV = "test"
testCase = require('nodeunit').testCase
titleizer = require('../app/helpers/titleizer')


module.exports = testCase
  "should return 'The Party' for input the_party": (test) ->
    test.equal 'The Party', titleizer.title 'the_party'
    test.done()

  "should return 'What to Wear' for input what_to_wear": (test) ->
    test.equal 'What to Wear', titleizer.title 'what_to_wear'
    test.done()

  "should return 'Today is Gone' for input today_is_gone": (test) ->
    test.equal 'Today is Gone', titleizer.title 'today_is_gone'
    test.done()

  "should return 'Isis is Special' for input 'isis_is_special": (test) ->
    test.equal 'Isis is Special', titleizer.title 'isis_is_special'
    test.done()

  "testing wedding titles":(test) ->
    check = (word, keyword) ->
      test.equal word, titleizer.title keyword

    check "The Love Story", "the_love_story"
    check "Location", "location"
    check "The Party", "the_party"
    check "The Wedding Party", "the_wedding_party"
    check "Itinerary", "itinerary"
    check "Meet Our Guests", "meet_our_guests"
    check "What to Wear", "what_to_wear"
    check "Where to Eat on Friday", "where_to_eat_on_friday"
    check "Local Accommodations", "local_accommodations"
    check "Saturday Brunch", "saturday_brunch"
    check "What to Do on Saturday", "what_to_do_on_saturday"
    check "RSVP", "rsvp"

    test.done()

