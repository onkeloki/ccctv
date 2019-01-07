window.own = {}
initAutoinitbox = (boxId, count)->
	scriptUrl = "/js/own/" + boxId + ".js";
	window.own.scripts = {} if not window.own.scripts

	window.own.scripts[scriptUrl] = []  if not window.own.scripts[scriptUrl]
	window.own = {} if not window.own
	window.own.autoInitBox = {} if not window.own.autoInitBox
	if not window.own.autoInitBox[boxId]
		window.own.autoInitBox[boxId] = []
	constructoline = "new  " + boxId + "('#" + boxId + "_" + count + "')"
	## class already loaded
	if window[boxId]

		window.own.autoInitBox[boxId].push(eval(constructoline));
	else

#class not loaded but loading
		if window.own.scripts[scriptUrl].length > 0
			window.own.scripts[scriptUrl].push(constructoline)
		#class not loading and not loading
		if  window.own.scripts[scriptUrl].length == 0
			window.own.scripts[scriptUrl].push(constructoline)
			$.getScript scriptUrl, (javascript, textStatus, jqxhr)=>
				for x in  window.own.scripts[scriptUrl]
					window.own.autoInitBox[boxId].push(eval(x));


pad = (str, max) ->
	str = str.toString()
	if str.length < max then pad('0' + str, max) else str



