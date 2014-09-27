Handler =
  command: (event) ->
    console.log "so i got a command right, it were #{event.command}"
    if event.command == 'go_favourite'
      ReSearch.Determinator.goFavourite(event.target.browserWindow.activeTab)
  
  validate: (event) ->
    

safari.application.addEventListener("command", Handler.command, false)
safari.application.addEventListener("validate", Handler.validate, false)
