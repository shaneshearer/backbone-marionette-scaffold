@Application.module "Header.Show", (Show, App, Backbone, Marionette, $, _) ->
  Show.Controller =
    show: ->
      view = new Show.View

      App.header.show(view)