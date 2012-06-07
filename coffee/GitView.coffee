define [
	"jquery"
	"underscore"
	"marionette"
	"backbone"
	"text!templates/repoTemplate.html"
	"text!templates/commitTemplate.html"
], ($, _, Marionette, Backbone, repoTemplate, commitTemplate) ->
	Repos = Backbone.Collection.extend
		url : "https://api.github.com/users/soldiermoth/repos?callback=?"
		parse : (data) -> data.data
	Commits = Backbone.Collection.extend
		initialize : (models,options) -> @repo = options.repo
		url : () -> "https://api.github.com/repos/soldiermoth/#{@repo}/commits?callback=?"
		parse : (data) ->
			data = data.data
			data = _.filter data, (commit) ->
				(commit.author && commit.author.login == "soldiermoth") ||
				(commit.commit.author && commit.commit.author.name == "soldiermoth")
			_.each data, (commit) => commit.repo = @repo
			_.first data, 1
	CommitView = Marionette.ItemView.extend
		template : commitTemplate
	CommitsView = Marionette.CollectionView.extend
		itemView : CommitView
	RepoView = Marionette.Layout.extend
		className : "item"
		template : repoTemplate
		regions :
			commitSection : ".commits"
		initialize : ->
			repoCommits = new Commits [], repo : @model.get "name"
			@defFetch = $.Deferred()
			repoCommits.fetch success : => @defFetch.resolve repoCommits
		onRender : ->
			@defFetch.done (collection) =>
				@commitSection.show new CommitsView collection : collection
	ReposView = Marionette.CollectionView.extend
		itemView : RepoView
		initialize : ->
			@collection = new Repos()
			@collection.fetch()
		appendHtml : (collectionView, itemView) ->
			if collectionView.collection.first() == itemView.model
				itemView.$el.addClass "active"
			collectionView.$el.append itemView.el
