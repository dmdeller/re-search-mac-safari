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
    
    regex = engineQueryPart.replace(ReSearch.queryToken, "(.+?)") + "/i"
    matches = pagePathPart.match(regex)
    
    if matches.length == 0
      console.log "domain matches, but current URL: #{pagePathPart} doesn't match regular expression: #{regex}"
      return
    
    encodedQuery = _.first(matches)
    decodedQuery = decodeURIComponent(encodedQuery)
    
    return decodedQuery
