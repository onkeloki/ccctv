class App extends BaseComponent
	constructor: ()->
		@initAcronym = "35c3";
		@loadedAcronym;
		@navigation = new Navigation()
		@DS = new ConferencesDS()
		@DS.reload @launch.bind(@)
		$("body").on "eventselected", ()=>
			html = $("#tpl_info").html()
			infoTPL = Handlebars.compile(html)
			guid = $(".slidercard.navigation_selected").data("guid")
			event = @DS.eventsByGuid[guid]
			conference = @DS.byAcronym[@loadedAcronym]
			$("#infoarea").html infoTPL({event: event, conference: conference})
			$("#poster").css("background-image", "url(" + event.poster_url + ")");

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
