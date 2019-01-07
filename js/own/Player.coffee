class Player extends BaseComponent
	constructor: (@app)->



	show: ()->
		$("#playerlayer").removeClass("d-none").addClass("d-block")
	hide: ()->
		$("#playerlayer").removeClass("d-block").addClass("d-none")
	isOpen: ()->
		return $("#playerlayer").hasClass("d-block")
	load: (url)->
		$("#videoplayer").attr("src", url)
	play: (url)->
		@load url
		@show() if not @isOpen()
		vid = document.getElementById("videoplayer");
		vid.play()
