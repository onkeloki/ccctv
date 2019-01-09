class BaseComponent
	@htmlHashMap = null
	constructor: (@tag)->
		@className = @.__proto__.constructor.name


	left: ()->
		console.log "left() in #{@className}"
	up: ()->
		console.log "up() in #{@className}"
	right: ()->
		console.log "right() in #{@className}"
	down: ()->
		console.log "down() in #{@className}"
	selectKey: ()->
		console.log "selectKey() in #{@className}"
	exitKey: ()->
		console.log "exitKey() in #{@className}"

	###
  SEND GET
	###
	_get: (obj)->
		obj.cache = false
		obj.method = "get"
		obj.type = "json"
		$.ajax obj

	###
		RETURN TAG
	###
	_getTag: ()->  @tag