this.ReSearch.Config =
  _engines: []
  
  setDefaultEngines: (engines) ->
    this._engines = engines
    
  engines: ->
    this._engines
  
  engineForID: (id) ->
    for engine in this.engines()
      if engine.id == id
        return engine
    
    console.log "Could not find engine for ID: #{id}"
    return null
  
  Engine:
    ID:
      DuckDuckGo: '11A7CF8D-9908-4D9E-B38C-68DD7E118958'
      Google: '7A8141DE-CC69-46F0-B913-2719102ED88B'
      favourite: ->
        safari.extension.settings.favouriteEngine
    DuckDuckGo: ->
      ReSearch.Config.engineForID(this.ID.DuckDuckGo)
    Google: ->
      ReSearch.Config.engineForID(this.ID.Google)
    favourite: ->
      ReSearch.Config.engineForID(this.ID.favourite())
