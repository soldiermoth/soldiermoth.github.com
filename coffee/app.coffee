define [
	"use!marionette"
	"jquery"
	"text!templates/alsoKnownAs.html"
], (Marionette,$,alsoKnownAsTemplate) ->
	app = new Marionette.Application()
	app.addRegions
		content : "#content"
	app.addInitializer ->
		$("#name").popover
			placement : "bottom"
			title : "Also Known As:"
			content : alsoKnownAsTemplate
	return app
