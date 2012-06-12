define [
	"marionette"
  "text!./templates/alsoKnownAs.html"
	"text!./templates/navbarTemplate.html"
], (Marionette,akaTemplate,navbarTemplate) ->
	
	Marionette.ItemView.extend
		template: navbarTemplate
		initialize: ->
			@_activeNavId ?= @options.activeNavId
		setActiveNavId: (activeNavId) ->
			@$("##{@_activeNavId}").removeClass "active"
			@$("##{activeNavId}").addClass "active"
			@_activeNavId = activeNavId
		onRender: ->
			@$("##{@_activeNavId}").addClass "active"
			@$("#aka").popover
				placement: "bottom"
				title: "Also Known As:"
				content: akaTemplate
