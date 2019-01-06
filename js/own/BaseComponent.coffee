class BaseComponent
	@htmlHashMap = null
	constructor: (@tag)->
		BaseComponent.htmlHashMap = {} if not BaseComponent.htmlHashMap?
		@tag = $("<div>") if not @tag
		@className = @.__proto__.constructor.name
		@htmlTemplate = null
		$(@tag).addClass(@className.toLowerCase())
		@cssPath = "/components/#{@className}.css"
		@templatePath = "/components/#{@className}.html"
		$(@tag).data("instance", @)
	_findInMe: (selecor)->
		$(@tag).find(selecor)

	###
    EXECUTE GIVEN CALLBACK WITH TEMPLATE HTML
    callback(html)
  ###
	_getTemplate: (name)->
		html = @_findInMe("script." + name).html()
		Handlebars.compile(html)

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