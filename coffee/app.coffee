define [
	"jquery"
	"use!marionette"
	"cs!TweetView"
	"cs!StackView"
	"cs!GitView"
	"text!templates/alsoKnownAs.html"
], ($,Marionette,TweetView,StackView,GitView,alsoKnownAsTemplate) ->
	app = new Marionette.Application()
	app.addRegions
		tweetContainer : "#tweetContainer"
		stackContainer : "#stackContainer"
		gitContainer : "#gitContainer"
	app.addInitializer ->
		$("#aka").popover
			placement : "bottom"
			title : "Also Known As:"
			content : alsoKnownAsTemplate
	app.addInitializer ->
		@tweetContainer.on "view:show", ->
			$("#tweetCarousel").carousel()
		@tweetContainer.show new TweetView()
		@stackContainer.on "view:show", ->
			$("#stackCarousel").carousel()
		@stackContainer.show new StackView()
		@gitContainer.on "view:show", ->
			$("#gitCarousel").carousel()
		@gitContainer.show new GitView()
	return app
