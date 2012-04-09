define [
	"use!marionette"
	"jquery"
	"text!templates/alsoKnownAs.html"
	"cs!TweetView"
], (Marionette,$,alsoKnownAsTemplate,TweetView) ->
	app = new Marionette.Application()
	app.addRegions
		tweetContainer : "#tweetContainer"
	app.addInitializer ->
		$("#name").popover
			placement : "bottom"
			title : "Also Known As:"
			content : alsoKnownAsTemplate
	app.addInitializer ->
		@tweetContainer.show new TweetView()
	return app
