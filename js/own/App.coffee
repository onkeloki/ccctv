class App extends BaseComponent
	constructor: ()->
		@initAcronym = "35c3";
		@loadedAcronym;
		@navigation = new Navigation(@)
		@DS = new ConferencesDS(@)
		@infoArea = new InfoArea(@)
		@player = new Player(@)
		@DS.reload @launch.bind(@)
		$("body").on "keydown", @keyup.bind @

	keyup: (e)->
		switch
			when  e.key is "ArrowLeft" then @getKeyCatcher().left(e)
			when  e.key is "ArrowRight" then @getKeyCatcher().right(e)
			when  e.key is "ArrowUp" then @getKeyCatcher().up(e)
			when e.key is "ArrowDown" then @getKeyCatcher().down(e)
			when $.inArray(e.keyCode, [13, 32]) > -1 then @getKeyCatcher().selectKey(e)
			when e.keyCode is 27 then @getKeyCatcher().exitKey(e)
	getKeyCatcher: ()->
		return @player if @player.catchesKey()
		return @infoArea if @infoArea.catchesKey()
		return @navigation

	launch: ()->
		@conferenceView(@initAcronym)

	renderTemplate: (id, obj)->
		$("#rightarea").empty()
		html = $("#tpl_" + id).html()
		tpl = Handlebars.compile(html)
		Handlebars.registerHelper "debug", (e)->
			console.log "DEBUG", e.data
		$("#rightarea").append tpl(obj)
	conferenceView: (acronym)->
		@DS.depploadEventsByAcronym acronym, (conference)=>
			@loadedAcronym = acronym
			@renderTemplate("playerview", conference)
			@navigation.selectItem $(".slidercard")[0]
			return
