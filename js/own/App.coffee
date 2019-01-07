class App extends BaseComponent
	constructor: ()->
		@initAcronym = "35c3";
		@loadedAcronym;
		@navigation = new Navigation(@)
		@DS = new ConferencesDS(@)
		@infoArea = new InfoArea(@)
		@player = new Player(@)
		@DS.reload @launch.bind(@)










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
			console.log $(".slidercard")[0]
			@navigation.selectItem $(".slidercard")[0]
			return
