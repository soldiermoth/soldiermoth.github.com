define [
	"use!marionette"
	"jquery"
	"text!templates/alsoKnownAs.html"
	"cs!TweetView"
	"cs!StackView"
], (Marionette,$,alsoKnownAsTemplate,TweetView,StackView) ->
	app = new Marionette.Application()
	app.addRegions
		tweetContainer : "#tweetContainer"
		stackContainer : "#stackContainer"
	app.addInitializer ->
		$("#aka").popover
			placement : "bottom"
			title : "Also Known As:"
			content : alsoKnownAsTemplate
	app.addInitializer ->
		@tweetContainer.show new TweetView()
		@stackContainer.show new StackView()
	return app
