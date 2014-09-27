this.ReSearch.Determinator =
  goFavourite: (tab) ->
    console.log "hi, #{tab.url}"
    console.log "engines:"
    console.log ReSearch.Config.engines()
  
  redirectURLForCurrentSearchPageURL: (currentURL) ->
#       *errorRef = nil;
#       
#       [self.sharedDefaults synchronize];
#       
#       NSArray *engines = [self.sharedDefaults objectForKey:kDefaultsAllEngines];
#       NSString *currentURLHostPart = currentURL.host;
#       NSString *currentURLPathPart = [NSString stringWithFormat:@"%@?%@", currentURL.path, currentURL.query];
#       
#       if (engines.count == 0)
#       {
#           NSLog(@"%@: Couldn't find defaults!!! %@", self.class, self.sharedDefaults.dictionaryRepresentation);
#           
#           NSError *error = [NSError errorWithDomain:SearchDeterminatorErrorDomain code:0 userInfo:@{
#               NSLocalizedDescriptionKey: @"Please open the Re-Search app before using the extension.",
#           }];
#           
#           *errorRef = error;
#           
#           return nil;
#       }
#       
#       for (NSDictionary *engineData in engines)
#       {
#           if (engineData[kEngineQueryPart] == nil || [engineData[kEngineQueryPart] isKindOfClass:NSNull.class])
#           {
#               continue;
#           }
#           else if ([currentURLHostPart hasSuffix:engineData[kEngineDomainPart]])
#           {
#               NSString *engineQueryPart = engineData[kEngineQueryPart];
#               
#               NSString *pageQuery = [self queryStringForEngineQueryPart:engineQueryPart pagePathPart:currentURLPathPart];
#               if (pageQuery.length > 0)
#               {
#                   NSDictionary *redirectEngineData = [self redirectEngineForID:[self.sharedDefaults objectForKey:kDefaultsFavouriteEngineID] inEngines:engines currentEngineID:engineData[kEngineID]];
#                   if (redirectEngineData != nil)
#                   {
#                       NSURL *redirectURL = [self redirectURLForEngineRedirectURL:redirectEngineData[kEngineRedirectURL] query:pageQuery];
#                       if (redirectURL != nil)
#                       {
#                           return redirectURL;
#                       }
#                   }
#               }
#           }
#       }
#       
#       NSError *error = [NSError errorWithDomain:SearchDeterminatorErrorDomain code:0 userInfo:@{
#           NSLocalizedDescriptionKey: @"Sorry, this page is not supported by Re-Search.",
#       }];
#       
#       *errorRef = error;
#       
#       return nil;
