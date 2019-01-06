class Player extends BaseComponent
	constructor: ()->


	show: ()->
		$("#playerLayer").removeClass("d-none").addClass("d-block")
	hide: ()->
		$("#playerLayer").removeClass("d-block").addClass("d-none")
	isOpen: ()->
		return $("#playerLayer").hasClass("d-block")
	load: (url)->
		url = "https://mirror-1.server.selfnet.de/CCC/congress/2018/slides-h264-hd/35c3-10009-eng-deu-Afroroutes_Africa_Elsewhere_hd-slides.mp4"
		$("#videoplayer").attr("src", url)
	play: ()->
		@show() if not @isOpen()
		vid = document.getElementById("videoplayer");
		vid.play()
