define [
	"marionette"
	"cs!common/NavbarView"
	"cs!home/TweetView"
	"cs!home/StackView"
	"cs!home/GitView"
	"text!./templates/homeTemplate.html"
], (Marionette,NavbarView,TweetView,StackView,GitView,homeTemplate) ->

	HomeView = Marionette.Layout.extend
		template: homeTemplate
		regions:
			tweetContainer: "#tweetContainer"
			gitContainer: "#gitContainer"
			stackContainer: "#stackContainer"
		onRender: ->
			@tweetContainer.on "view:show", =>
				@$("#tweetCarousel").carousel()
			@tweetContainer.show new TweetView
			@gitContainer.on "view:show", =>
				@$("#gitCarousel").carousel()
			@gitContainer.show new GitView
			@stackContainer.on "view:show", =>
				@$("#stackCarousel").carousel()
			@stackContainer.show new StackView

	app = new Marionette.Application()
	app.addRegions
		navbarContainer: "#navbarContainer"
		contentContainer: "#content"
	app.addInitializer ->
		@navbarContainer.show new NavbarView
			activeNavId: "home"
		@contentContainer.show new HomeView

	return app
