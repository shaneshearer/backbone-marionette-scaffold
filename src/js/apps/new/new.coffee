@Application.module "New", (New, App, Backbone, Marionette, $, _) ->

  class New.Router extends Marionette.AppRouter
    appRoutes:
      "newpage": "show"

  API =
    show: ->
      New.Show.Controller.show()

  App.addInitializer ->
    new New.Router
      controller: API