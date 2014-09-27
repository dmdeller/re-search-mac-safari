this.ReSearch.Determinator =
  goFavourite: (tab) ->
    console.log "hi, #{tab.url}"
    
    this.redirectURL(tab.url)
  
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
      
      alert("your query was: #{pageQuery}")
      return
      
      #redirectEngine = [self redirectEngineForID:[self.sharedDefaults objectForKey:kDefaultsFavouriteEngineID] inEngines:engines currentEngineID:engineData[kEngineID]];
      redirectEngine = engine
      
      continue unless redirectEngine?
      
      #NSURL *redirectURL = [self redirectURLForEngineRedirectURL:redirectEngineData[kEngineRedirectURL] query:pageQuery];
      redirectURL = null
      
      continue unless redirectURL?
      return redirectURL
    
    alert 'Sorry, this page is not supported by Re-Search.'

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
