Handler =
  command: (event) ->
    console.log "Command handler for command: #{event.command}" if ReSearch.debug
    
    if event.command == 'goFavourite'
      ReSearch.Determinator.goFavourite(event.target.browserWindow.activeTab)
    else if event.command == 'goEngine'
      # Workaround: event.target.browserWindow is null - not sure why - so we have to get it from safari.application instead
      ReSearch.Determinator.goEngine(safari.application.activeBrowserWindow.activeTab, event.target.identifier)
  
  validate: (event) ->
    console.log "Validate handler for command: #{event.command}" if ReSearch.debug
    
    currentURL = try event.target.browserWindow.activeTab.url catch then null
    
    if event.command == 'goFavourite'
      event.target.disabled = !ReSearch.Determinator.isSearchPage(currentURL) or ReSearch.Determinator.isFavouriteEngine(currentURL)
    else if event.command == 'choose'
      event.target.disabled = !ReSearch.Determinator.isSearchPage(currentURL)
    else if event.command == 'goEngine'
      currentURL = safari.application.activeBrowserWindow.activeTab.url
      engine = ReSearch.Config.engineForID(event.target.identifier)
      
      # Workaround: see above
      event.target.disabled = ReSearch.Determinator.isPageBelongingToEngine(currentURL, engine)

safari.application.addEventListener("command", Handler.command, false)
safari.application.addEventListener("validate", Handler.validate, false)
