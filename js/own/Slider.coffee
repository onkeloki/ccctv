class Slider extends BaseComponent
	constructor: (@tag)->
		super @tag
		console.log @className
		@url = @_findInMe(".slidergroup").data("url")
		console.log @tag
		console.log @url
		$(@tag).on "selectionevent", ".slidercard", (e)=>
			@loadDetails($(e.currentTarget).data())
		@slidercard_tpl = @_getTemplate("tpl_slidercard");

		#@detailsTemplateHTML = $("#" + @className + "-details").html()
		#@details_tpl = Handlebars.compile(@detailsTemplateHTML)
		@reload()

	loadDetails: (data)->
		return
		@detailsrequest.abort() if @detailsrequest
		@detailsrequest = @_get
			url: data.url
			success: (e)=>
				console.log e
	reload: ()->
		@_get
			url: @url
			success: (e)=>
				for conf in e.conferences
					@_findInMe(".slidergroup .slider").append $(@slidercard_tpl(conf)).data(conf)

###	bySlug:(conferences)->
		r = {}
		for conf in conferences
			folder = conf.slug.split("/")¢###
