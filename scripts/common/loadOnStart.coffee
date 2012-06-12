define [
	"underscore"
	"marionette"
	"prettify",
	"bootstrap"
], (_,Marionette) ->

	Marionette.TemplateCache.loadTemplate = (template, callback) ->
		callback.call @, _.template(template)

	Marionette.Renderer.renderTemplate = (template,data) ->
		template(data)
