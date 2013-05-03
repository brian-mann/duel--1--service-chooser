Array::sum = ->
	if @length > 0 then _.reduce @, (t, i) -> t + i else 0

# Array::get = (attr) -> 
# 	i.get(attr) for i in @

class App.View extends Marionette.ItemView
	template: JST["backbone/services"]
	events: -> "click input" : (e) ->
		id = $(e.currentTarget).data("title")
		@$("#price").text @collection.getTotal id

class App.Services extends Backbone.Collection
	getTotal: (title) ->
		m = @findWhere({title: title})
		m.set isSelected: !m.get("isSelected")
		# total = _.reduce @where({isSelected: true}), ((total, model) -> total + model.get("price")), 0
		# total = @reduce ((total, model) -> total + (if model.get("isSelected") then model.get("price") else 0)), 0
		# total = _.pluck(@where({isSelected: true}), "price").sum() <-- will not work
		# total = _.invoke(@where({isSelected: true}), "get", "price").sum()
		# @reduce ((array, model) -> array.push(model.get("price")) if model.get("isSelected"), [])
		# total = (model.get("price") for model in @where({isSelected: true})).sum()
		# total = @where({isSelected: true}).get("price").sum()
		@retreive("price", {isSelected: true}).sum()
	
	retreive: (attr, condition = {}) ->
		if _.isEmpty(condition) then @pluck(attr) else _.invoke(@where(condition), "get", attr)
	
App.start = ->
	services = new App.Services [
		{ title: 'web development', 	price: 200 }
		{ title: 'web design', 				price: 250 }
		{ title: 'photography', 			price: 100 }
		{ title: 'coffee drinking', 	price: 10  }
	]
	view = new App.View collection: services
	$("#main-region").html(view.render().el)
	

	# App.addRegions
	# 	mainRegion: "#main-region"
	# 
	# App.mainRegion.show(new App.View)