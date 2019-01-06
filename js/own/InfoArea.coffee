class InfoArea extends BaseComponent
	constructor: (@app)->


	onEventSelect: (event, conference)->
		html = $("#tpl_info").html()
		infoTPL = Handlebars.compile(html)
		$("#infoarea").html infoTPL({event: event, conference: conference})
		$("#poster").css("background-image", "url(" + event.poster_url + ")");

	onEventClick: (event, conference)->
		@onEventSelect(event, conference)
		$("#rightarea").addClass("small")
		$("#infoarea").addClass("large");
		$("#playbutton").addClass("active");

	makeSmall: ()->
		$("#rightarea").removeClass("small")
		$("#infoarea").removeClass("large");

