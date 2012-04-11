define [
	"use!backbone"
	"jquery"
	"use!underscore"
	"use!marionette"
	"text!templates/answerTemplate.html"
], (Backbone, $, _, Marionette, tweetTemplate) ->
	Answers = Backbone.Collection.extend
		url : "http://api.stackexchange.com/2.0/users/68172/answers?order=desc&sort=creation&site=stackoverflow&filter=!9Tk6P.j1M"
		parse : (data) -> data.items
	AnswerView = Marionette.ItemView.extend
		className : "well item"
		template : tweetTemplate
		serializeData : ->
			jsonData = @model.toJSON()
			return jsonData
		onRender : ->
			@$("img").addClass "thumbnail"
			_.each @$("img"), (img) ->
				$(img).width("100%") if img.width > 350
			@$("pre").addClass "prettyprint linenums pre-scrollable"
	AnswersView = Marionette.CollectionView.extend
		initialize : ->
			@collection = new Answers()
			@collection.fetch()
		itemView : AnswerView
		onRender : ->
			prettyPrint()
			@$el.carousel()
