this.ReSearch.Determinator =
  goFavourite: (tab) ->
    console.log "hi, #{tab.url}"
    
    redirectURL = this.redirectURL(tab.url)
    if redirectURL?
      tab.url = redirectURL
    else
      alert 'Sorry, this page is not supported by Re-Search.'
  
  isSearchPage: (currentURL) ->
    this.redirectURL(currentURL)?
  
  # Given a current search URL, find and return an equivalent search URL with a different search engine
  redirectURL: (currentURL) ->
    engines = ReSearch.Config.engines()
    
    if engines.count == 0
      console.log "No engines"
      return
    
    urlComponents = purl(currentURL)
    currentURLHostPart = urlComponents.attr('host');
    currentURLPathPart = urlComponents.attr('relative')
    
    for engine in engines
      continue unless engine.queryPart? and engine.domainPart?
      continue unless _.endsWith(currentURLHostPart, engine.domainPart)
      
      pageQuery = this.queryString(engine.queryPart, currentURLPathPart)
      continue unless pageQuery? and pageQuery.length > 0
      
      redirectEngine = this.redirectEngine(engine.id)
      continue unless redirectEngine?
      
      redirectURL = this.engineQueryURL(redirectEngine.redirectURL, pageQuery)
      continue unless redirectURL?
      
      return redirectURL
    
    return null
  
  # Given a pattern and a relative URL, figure out and return the plain text search terms
  queryString: (engineQueryPart, pagePathPart) ->
    unless _.str.include(engineQueryPart, ReSearch.queryToken)
      console.log "queryPart doesn't contain token: #{engineQueryPart}"
      return
    
    engineQueryPartParts = engineQueryPart.split(ReSearch.queryToken)
    engineQueryFirstPart = _.first(engineQueryPartParts)
    engineQueryLastPart = _.last(engineQueryPartParts)
    
    if engineQueryLastPart == engineQueryFirstPart or !engineQueryLastPart?
      engineQueryLastPart = ''
    
    unless _.str.include(pagePathPart, engineQueryFirstPart)
      console.log "domain matched, but current URL: #{pagePathPart} doesn't contain first part of queryPart: #{engineQueryFirstPart}"
      return
        
    if engineQueryLastPart.length > 0 and !_.str.include(pagePathPart, engineQueryLastPart)
      console.log "domain matched, but current URL: #{pagePathPart} doesn't contain last part of queryPart: #{engineQueryLastPart}"
      return
    
    encodedQuery = pagePathPart
    
    # Remove part before token
    encodedQuery = _.strRight(encodedQuery, engineQueryFirstPart)
    
    # Remove part after token (if any)
    if engineQueryLastPart.length > 0
      encodedQuery = _.strLeft(encodedQuery, engineQueryLastPart)
    
    # Remove all text after any of these
    for stopSymbol in ['&', '/', '?']
      encodedQuery = _.strLeft(encodedQuery, stopSymbol)
    
    decodedQuery = encodedQuery
    decodedQuery = decodedQuery.replace(/\+/g, ' ')
    decodedQuery = decodeURIComponent(decodedQuery)
    
    return decodedQuery
  
  # Given a current search engine ID, determine which search engine to redirect to
  redirectEngine: (currentID) ->
    favouriteID = ReSearch.Config.Engine.ID.favourite()
    
    if currentID == favouriteID
      if currentID == ReSearch.Config.Engine.ID.DuckDuckGo
          console.log "Current search page and favourite are both DuckDuckGo; redirecting to Google instead"
          
          return ReSearch.Config.Engine.Google()
      else
          console.log "Current search page and favourite are the same; redirecting to DuckDuckGo instead"
          
          return ReSearch.Config.Engine.DuckDuckGo()
    else
      return ReSearch.Config.Engine.favourite()

  # Given a search engine redirect URL pattern and a query, return a URL to redirect to
  engineQueryURL: (engineRedirectURL, query) ->
    encodedQuery = encodeURIComponent(query)
    #encodedQuery.replace(/%20/g, '+')
    
    unless _.str.include(engineRedirectURL, ReSearch.queryToken)
        console.log "redirectURL does not contain token: #{engineRedirectURL}"
        return null
    
    url = engineRedirectURL.replace(ReSearch.queryToken, encodedQuery)
    
    return url
