Handler =
  command: (event) ->
    console.log "Command handler for command: #{event.command}"
    
    if event.command == 'goFavourite'
      ReSearch.Determinator.goFavourite(event.target.browserWindow.activeTab)
  
  validate: (event) ->
    console.log "Validate handler for command: #{event.command}"
    
    if event.command == 'goFavourite'
      event.target.disabled = !ReSearch.Determinator.isSearchPage(event.target.browserWindow.activeTab.url)
    else if event.command == 'goEngine'
      event.target.disabled = !ReSearch.Determinator.isSearchPage(event.target.browserWindow.activeTab.url)

safari.application.addEventListener("command", Handler.command, false)
safari.application.addEventListener("validate", Handler.validate, false)
