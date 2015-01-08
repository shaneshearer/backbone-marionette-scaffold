@Application.module "Default.Show", (Show, App, Backbone, Marionette, $, _) ->

  # Header View
  # -----------

  Show.View = Marionette.ItemView.extend

    # Properties
    # ----------

    tagName: "section"


    # Template
    # --------

    template: (data) ->
      Application.Templates.default(data)
