@Application.module "Default.Show", (Show, App, Backbone, Marionette, $, _) ->
  Show.Controller =
    show: ->
      view = new Show.View

      App.main.show(view)