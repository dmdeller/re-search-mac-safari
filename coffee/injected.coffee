ReSearchInjected =
  Handler:
    keyShortcut: (event) ->
      event.preventDefault()
      safari.self.tab.dispatchMessage('keyShortcut')
    
    message: (event) ->
      if event.name == 'bindKey'
        bindKey = event.message
        
        Mousetrap.reset()
        Mousetrap.bind(bindKey, ReSearchInjected.Handler.keyShortcut) unless bindKey == 'none'

safari.self.addEventListener("message", ReSearchInjected.Handler.message, false)

safari.self.tab.dispatchMessage('getKeyShortcutSetting')
