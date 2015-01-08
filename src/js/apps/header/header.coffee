@Application.module "Header", (Header, App, Backbone, Marionette, $, _) ->
  @startWithParent = false

  API =
    show: ->
      Header.Show.Controller.show()

  Header.on "start", ->
    API.show()