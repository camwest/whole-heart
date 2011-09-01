class App
  constructor:  ->
    env = process.env.NODE_ENV || "development"
    @storage = {}
    # load the environment file
    require( __dirname + '/../config/environments/' + env ).load(@)

  set: (key, value = null) ->
    if value
      @storage[key] = value
    else
      @storage[key]

module.exports = new App
