go_favourite = (tab) ->
  alert("hi, #{tab.url}")

handler =
  command: (event) ->
    console.log "so i got a command right, it were #{event.command}"
    if event.command == 'go_favourite'
      go_favourite(event.target.browserWindow.activeTab)
  
  validate: (event) ->
    

safari.application.addEventListener("command", handler.command, false)
safari.application.addEventListener("validate", handler.validate, false)
