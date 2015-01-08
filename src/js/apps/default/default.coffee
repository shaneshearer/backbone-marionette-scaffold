@Application.module "Default", (Default, App, Backbone, Marionette, $, _) ->

  class Default.Router extends Marionette.AppRouter
    appRoutes:
      "default": "show"

  API =
    show: ->
      Default.Show.Controller.show()

  App.addInitializer ->
    new Default.Router
      controller: API