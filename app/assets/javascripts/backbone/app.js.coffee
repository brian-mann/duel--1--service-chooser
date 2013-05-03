class App.View extends Marionette.ItemView
	template: JST["backbone/services"]
	events: -> "click input" : (e) ->
		@$("#price").text @collection.getTotal $(e.currentTarget).data("title")
class App.Services extends Backbone.Collection
	getTotal: (title) ->
		@findWhere({title: title}).set isSelected: !@findWhere({title: title}).get("isSelected")
		_.reduce @where({isSelected: true}), ((total, model) -> total + model.get("price")), 0	
App.start = ->
	services = new App.Services	[{ title: 'web development', price: 200 }, { title: 'web design',	price: 250 }, { title: 'photography', price: 100 }, { title: 'coffee drinking', price: 10  }]
	$("#main-region").html(new App.View({collection: services}).render().el)