define [
	"backbone"
	"jquery"
	"underscore"
	"marionette"
	"text!./templates/answerTemplate.html"
], (Backbone, $, _, Marionette, tweetTemplate) ->
	Answers = Backbone.Collection.extend
		url: "http://api.stackexchange.com/2.0/users/68172/answers?order=desc&sort=creation&site=stackoverflow&filter=!9Tk6P.j1M"
		parse: (data) -> data.items
	AnswerView = Marionette.ItemView.extend
		className: "item"
		template: tweetTemplate
		onRender: ->
			@$("img").addClass "thumbnail"
			_.each @$("img"), (img) ->
				$(img).width("100%") if img.width > 350
			@$("pre").addClass "prettyprint linenums pre-scrollable"
	AnswersView = Marionette.CollectionView.extend
		itemView: AnswerView
		initialize: ->
			@collection = new Answers()
			@collection.fetch()
		onRender: -> prettyPrint()
		appendHtml: (collectionView, itemView) ->
			if collectionView.collection.first() == itemView.model
				itemView.$el.addClass "active"
			collectionView.$el.append itemView.el
