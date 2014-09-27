this.ReSearch.Config =
  _engines: []
  
  setDefaultEngines: (engines) ->
    this._engines = engines
    
  engines: ->
    this._engines
