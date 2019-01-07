class Player extends BaseComponent
	constructor: (@app)->
		@vid = document.getElementById("videoplayer");


	show: ()->
		$("#playerlayer").removeClass("d-none").addClass("d-block")
		$("#controlls").removeClass("hidden");
	hide: ()->
		$("#playerlayer").removeClass("d-block").addClass("d-none")
		$("#controlls").addClass("hidden");
		@vid.pause()
	isOpen: ()->
		return $("#playerlayer").hasClass("d-block")
	load: (url)->
		$("#videoplayer").attr("src", url)
	play: (url)->
		@load url
		@show() if not @isOpen()
		@vid.play()
