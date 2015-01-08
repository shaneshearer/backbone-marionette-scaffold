@Application.module "Header.Show", (Show, App, Backbone, Marionette, $, _) ->

  # Header View
  # -----------

  Show.View = Marionette.ItemView.extend

    # Properties
    # ----------

    _activeClass: "active"
    tagName:      "section"


    # Events
    # ------

    events:
      "click nav a": "_handleNavClick"


    # Template
    # --------

    template: (data) ->
      Application.Templates.header(data)


    # Public Methods
    # --------------

    onRender: ->
      @$el.find("a[href='#{window.location.hash}']").parent().addClass @_activeClass


    # Event Handlers
    # --------------

    _handleNavClick: (e) ->
      e.preventDefault()

      href = $(e.currentTarget).attr("href")

      $("nav li").removeClass @_activeClass
      $("[href=#{href}]").parent().addClass @_activeClass
      Backbone.history.navigate href, { trigger: true }
