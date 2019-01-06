class Navigation
	constructor: ()->
		@selectionClass = "navigation_selected"
		$("body").on "keydown", @keyup.bind @

		if @getSelectedTag().length is 0
			@selectItem $(".slidercard")[0]

	keyup: (e)->
		console.log e
		switch
			when  e.key is "ArrowLeft" then @left e
			when  e.key is "ArrowRight" then @right e
			when  e.key is "ArrowUp" then @up e
			when  e.key is "ArrowDown" then @down e


	left: (e)->
		if not @mainMenuIsSelected() && @firstItemIsSelected()
			@selectItem $("#mainmenu li:first-child")
		else if @itemIsSelected()
			@selectPrevSliderCard()

	right: (e)->
		if @mainMenuIsSelected()
			if $(".slidergroup.group_selected").length > 0
				@selectItem $(".group_selected .navigation_entrypoint")[0]
			else
				@selectItem $(".slidercard")[0]

		else if @itemIsSelected()
			@selectNextSliderCard()


	up: (e)->
		if @mainMenuIsSelected()
			@selectMenuPrev()
		else if @itemIsSelected()
			@selectPrevSlider()

# no
	down: (e)->
		if @mainMenuIsSelected()
			@selectMenuNext()
		else if @itemIsSelected()
			@selectNextSlider()

	selectPrevSliderCard: ()->
		@selectItem @getPrevTagByClass(".slidercard")
		@scrollToSelectedItem()

	selectNextSliderCard: ()->
		card = @getNextTagByClass(".slidercard");
		#return if the end of the row
		return if card.index() is 0
		@selectItem card
		@scrollToSelectedItem()

	selectPrevSlider: ()->
		currentGroup = $(".slidercard.navigation_selected").closest(".slidergroup")
		for x,i in $(".slidergroup")
			if x == currentGroup[0]
				return if i - 1 < 0
				prev = $($(".slidergroup").get(i - 1));
		return if not prev
		@selectItem $(prev).find(".slidercard")[0]
		@scrollToSliderGroup()
		@scrollToSelectedItem()

	scrollToSliderGroup: ()->
		beforeSliders = []
		afterSliders = []
		foundSelected = false
		for sg in $(".slidergroup")
			foundSelected = true if $(sg).hasClass("group_selected")
			beforeSliders.push sg if not foundSelected
			afterSliders.push sg if  foundSelected


		$(beforeSliders).addClass("hidden-out")
		$(afterSliders).removeClass("hidden-out")
		console.log "xxx", beforeSliders




	selectNextSlider: ()->
		currentGroup = $(".slidercard.navigation_selected").closest(".slidergroup")
		for x,i in $(".slidergroup")
			if x == currentGroup[0]
				next = $($(".slidergroup").get(i + 1));
		return if not next
		@selectItem $(next).find(".slidercard")[0]
		@scrollToSliderGroup()
		@scrollToSelectedItem()





	getNextTagByClass: (classname)->
		all = $(classname)
		found = false;
		for tag,i in all
			if found == false
				if $(tag).hasClass("navigation_selected")
					found = i
		$($(all).get(found + 1))

	getPrevTagByClass: (classname)->
		all = $(classname)
		found = false;
		for tag,i in all
			if found == false
				if $(tag).hasClass("navigation_selected")
					found = i
		$($(all).get(found - 1))








	scrollToSelectedItem: ()->
		slider = $(".slidercard.navigation_selected").parent(".slider")
		i = @getSelectedTag().index()
		w = @getSelectedTag().outerWidth(true)
		console.log w
		slider.css("position", "relative")
		slider.css("left", w * i * -1)


	firstItemIsSelected: ()->
		$(".slidercard.navigation_selected").index() == 0
	itemIsSelected: ()->
		$(".slidercard.navigation_selected").length > 0
	mainMenuIsSelected: ()->
		$("#mainmenu .navigation_selected").length > 0
	selectMenuNext: ()->
		return if not @mainMenuIsSelected()
		@selectItem @getNextTagByClass(".navigation_row")


	selectMenuPrev: ()->
		return if not @mainMenuIsSelected()
		@selectItem @getPrevTagByClass(".navigation_row")

	setEntryPoint: ()->
		@getSelectedTag().parent().find(".navigation_entrypoint").removeClass("navigation_entrypoint")
		@getSelectedTag().addClass("navigation_entrypoint")

	selectItem: (tag)->
		return if not tag
		return if tag.length == 0
		nextselecttion = tag
		#if last item and next item have not same parent
		if $(tag).parent()[0] != @getSelectedTag().parent()[0]
			entryPoint = $(tag).parent().find(".navigation_entrypoint")
			nextselecttion = entryPoint if entryPoint.length > 0

		@setEntryPoint()
		@getSelectedTag().removeClass(@selectionClass)
		$(nextselecttion).addClass(@selectionClass)
		# select the slidergroup
		if $("." + @selectionClass).hasClass("slidercard")
			sg = $("." + @selectionClass).closest(".slidergroup")
			if not $(sg).hasClass("group_selected")
				$(".slidergroup").removeClass("group_selected")
				$(sg).addClass "group_selected"
		$("body").trigger "eventselected"

	getSelectedTag: ()->
		$("." + @selectionClass)
