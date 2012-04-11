define [
	"use!backbone"
	"use!underscore"
	"use!marionette"
	"text!templates/tweetTemplate.html"
], (Backbone, _, Marionette, tweetTemplate) ->
	Tweets = Backbone.Collection.extend
		url : "http://api.twitter.com/1/statuses/user_timeline.json?screen_name=soldiermoth&callback=?&include_entities=true&include_rts=true"
	TweetView = Marionette.ItemView.extend
		className : "well item"
		template : tweetTemplate
		serializeData : ->
			jsonData = @model.toJSON()
			jsonData.retweet = false
			oldText = jsonData.text
			newText = jsonData.text
			_.each jsonData.entities.user_mentions,(mention) ->
				newText = newText.replace(
					oldText.slice(mention.indices[0],mention.indices[1]),
					"<a target='_blank' href='https://twitter.com/#{mention.screen_name}'>@#{mention.screen_name}</a>",
					1
				)
			_.each jsonData.entities.urls,(url) ->
				newText = newText.replace(
					oldText.slice(url.indices[0],url.indices[1]),
					"<a href='#{url.url}'>#{url.display_url}</a>",
					1
				)
			if oldText.match /^RT/
				jsonData.retweet = true
				newText = newText.replace /^RT.*a>:/, ""
			jsonData.text = newText
			return jsonData
	TweetsView = Marionette.CollectionView.extend
		initialize : ->
			@collection = new Tweets()
			@collection.fetch()
		itemView : TweetView
		appendHtml : (collectionView, itemView) ->
			if collectionView.collection.first() == itemView.model
				itemView.$el.addClass "active"
			collectionView.$el.append itemView.el
