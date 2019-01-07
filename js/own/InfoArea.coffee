class InfoArea extends BaseComponent
	constructor: (@app)->


	onEventSelect: (event, conference)->
		html = $("#tpl_info").html()
		infoTPL = Handlebars.compile(html)

		$("#infoarea").html infoTPL({event: event, conference: conference})
		$("#poster").css("background-image", "url(" + event.poster_url + ")");

	selectKey: ()->
		url = $("#recordingButtons .active").data("file");
		console.log("1", url)
		@app.player.play(url);

	selectNextButton: ()->
		if $("#recordingButtons .active").next().length > 0
			$("#recordingButtons .active").removeClass("active").next().addClass("active")
	selectPrevButton: ()->
		if $("#recordingButtons .active").prev().length > 0
			$("#recordingButtons .active").removeClass("active").prev().addClass("active")

	onEventClick: (event)->
		conference = @app.DS.byAcronym[@app.loadedAcronym]
		html = $("#tpl_info").html()
		infoTPL = Handlebars.compile(html)
		$(".conferencetitle").text(conference.title)
		$(".event_title").text(event.title)
		$(".event_subtitle").text(event.subtitle)
		$("#infoarea").html infoTPL({event: event, conference: conference})
		$("#poster").css("background-image", "url(" + event.poster_url + ")");
		for r in event.recordings
			t = "";
			if r.language.split("-").length == 1
				type = r.mime_type.split("/")
				if type[0] is "video"
					n = r.language;
					n += " (HD)" if r.high_quality
					$("#recordingButtons").append $("<div>").attr("data-file", r.recording_url).addClass("btn btn-large btn-gui").text n
		$($("#recordingButtons .btn").get(0)).addClass("active")
		$("#rightarea").addClass("small");
		$("#infoarea").addClass("large");


	makeSmall: ()->
		$(".navigation_clicked").removeClass("navigation_clicked")
		$("#rightarea").removeClass("small")
		$("#infoarea").removeClass("large");

