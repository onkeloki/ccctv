class Player extends BaseComponent
	constructor: (@app)->
		super(@app)
		@vid = document.getElementById("videoplayer");
		@playing = false;
		@vid.addEventListener "playing", (e)=>
			@playing = true;
		@vid.addEventListener "pause", (e)=>
			@playing = false;
		@vid.addEventListener "ended", (e)=>
			@playing = false;
		@vid.addEventListener "error", (e)=>
			@playing = false;

		@interval = -1;
		$("#controlls .progress").on "click", @progressClick.bind(@)
	_formatSeconds: (seconds)->
		date = new Date(1970, 0, 1);
		date.setSeconds(seconds);
		date.toTimeString().replace(/.*(\d{2}:\d{2}:\d{2}).*/, "$1");

	progressClick: (e)->
		p = e.clientX / $(window).width() * 100;
		pos = @vid.duration / 100 * p
		@vid.currentTime = pos

	exitKey:()->
		@hide()

	catchesKey: ()->
		@isOpen()
	selectKey: ()->
		if @playing
			@vid.pause()
		else
			@vid.play()

	right: ()->
		if $(".progress").hasClass("focus")
			@vid.currentTime = @vid.currentTime + 20
	left: ()->
		if $(".progress").hasClass("focus")
			@vid.currentTime = @vid.currentTime - 20

	up: ()->
		if @barIsHidden()
			@showbar();
			return
		$(".progress").addClass("focus")

	down: ()->
		if $(".progress").hasClass("focus")
			$(".progress").removeClass("focus");
			return
		@hidebar();


	everySecond: ()->
		$("#controlls .info .timer").text "#{@_formatSeconds(@vid.currentTime)} / #{@_formatSeconds(@vid.duration)}"
		$("#controlls .progress-bar").css("width", @vid.currentTime / @vid.duration * 100 + "%")

	show: ()->
		$("#playerlayer").removeClass("d-none").addClass("d-block")
		$("#controlls").removeClass("hidden");
	hide: ()->
		clearInterval(@interval);
		$("#playerlayer").removeClass("d-block").addClass("d-none")
		$("#controlls").addClass("hidden");
		@vid.pause()
	isOpen: ()->
		return $("#playerlayer").hasClass("d-block")
	load: (url)->
		$("#videoplayer").attr("src", url)

	hidebar: ()->
		$("#controlls").addClass("hidden")
	showbar: ()->
		$("#controlls").removeClass("hidden");

	barIsHidden: ()->
		$("#controlls").hasClass("hidden")
	play: (url)->
		@showbar();
		clearInterval(@interval);
		setTimeout(@hidebar.bind(@), 4000)
		@interval = setInterval @everySecond.bind(@), 1000
		@load url
		@show() if not @isOpen()
		@vid.play()
