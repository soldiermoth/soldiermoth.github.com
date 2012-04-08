define [
	"Marionette"
], (Marionette) ->
	app = new Marionette.Application()
	app.addRegions
		content : "#content"
	app.addInitializer ->
		@$("#name").popover
		@content.show new Marionette.CollectionView()
	return app
