@Application = do (Backbone, Marionette, $, _) ->

  # Handlebars Helpers
  # ------------------

  Handlebars.registerHelper "modulo", (n, options) ->
    if parseInt(n) % 2 is 0
      options.fn @
    else
      options.inverse @


  Handlebars.registerHelper "ifCond", (v1, operator, v2, options) ->
    switch operator
      when "=="
        (if (v1 is v2) then options.fn(@) else options.inverse(@))
      when "==="
        (if (v1 is v2) then options.fn(@) else options.inverse(@))
      when "<"
        (if (v1 < v2) then options.fn(@) else options.inverse(@))
      when "<="
        (if (v1 <= v2) then options.fn(@) else options.inverse(@))
      when ">"
        (if (v1 > v2) then options.fn(@) else options.inverse(@))
      when ">="
        (if (v1 >= v2) then options.fn(@) else options.inverse(@))
      when "&&"
        (if (v1 and v2) then options.fn(@) else options.inverse(@))
      when "||"
        (if (v1 or v2) then options.fn(@) else options.inverse(@))
      else
        options.inverse @


  # App Declaration
  # ---------------

  App = new Marionette.Application

  App.addInitializer ->
    App.module("Header").start()

  App.addRegions
    header: "#header"
    main:   "#main"

  App.on "start", (options) ->
    if Backbone.history
      Backbone.history.start()
      Backbone.history.navigate "default", { trigger: true }


  App
