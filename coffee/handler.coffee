Handler =
  command: (event) ->
    console.log "Command handler for command: #{event.command}"
    
    if event.command == 'goFavourite'
      ReSearch.Determinator.goFavourite(event.target.browserWindow.activeTab)
    else if event.command == 'goEngine'
      console.log 'go engine'
  
  validate: (event) ->
    console.log "Validate handler for command: #{event.command}"
    
    currentURL = event.target.browserWindow.activeTab.url
    
    if event.command == 'goFavourite'
      event.target.disabled = !ReSearch.Determinator.isSearchPage(currentURL) or ReSearch.Determinator.isFavouriteEngine(currentURL)
    else if event.command == 'goEngine'
      event.target.disabled = !ReSearch.Determinator.isSearchPage(currentURL)

safari.application.addEventListener("command", Handler.command, false)
safari.application.addEventListener("validate", Handler.validate, false)
