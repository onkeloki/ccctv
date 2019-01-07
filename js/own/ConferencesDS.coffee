class ConferencesDS extends BaseComponent
	constructor: (@tag)->
		@all_conferences = "/jsondata/conferences.json"
		@rawDatas = {}
		@bySlug = {}
		@byAcronym = {}
		@eventsByAcronym = {}
		@eventsByGuid = {}
		@acronymToTags = {}

	reload: (successCb, fault)->
		@_get
			url: @all_conferences
			success: (json)=>
				for conf in json.conferences
					@byAcronym[conf.acronym] = conf
					arr = conf.slug.split("/")
					createPartInObject = (arr, o)=>
						o[arr[0]] = {} if not o[arr[0]]
						newRoot = o[arr[0]]
						arr.shift()
						if arr.length > 1
							createPartInObject(arr, newRoot)
						else
							newRoot[conf.acronym] = conf
					createPartInObject(arr, @bySlug)
				if successCb
					successCb()

	loadRecordings: (eventGUid, successCb)->
		$(".navigation_selected ").addClass("navigation_clicked")
		if @eventsByGuid[eventGUid].recordings
			successCb @eventsByGuid[eventGUid]
			return
		@_get
			url: "https://media.ccc.de/public/events/" + eventGUid
			success: (json)=>
				console.log "RECORDINGS", json.recordings
				@eventsByGuid[eventGUid].recordings = json.recordings
				if successCb
					successCb(@eventsByGuid[eventGUid])




	depploadEventsByAcronym: (acronym, successCb)->
		@_get
			url: @byAcronym[acronym].url
			success: (conf)=>
				@eventsByAcronym[conf.acronym] = conf.events
				@byAcronym[conf.acronym].events = conf.events
				@byAcronym[conf.acronym].tags = {}
				for event in conf.events
					@eventsByGuid[event.guid] = event
					for t in event.tags
						if not $.isNumeric(t) && t != conf.acronym
							if not @byAcronym[conf.acronym].tags[t]
								@byAcronym[conf.acronym].tags[t] = []

							@byAcronym[conf.acronym].tags[t].push(event)

				if successCb
					successCb @byAcronym[conf.acronym]

