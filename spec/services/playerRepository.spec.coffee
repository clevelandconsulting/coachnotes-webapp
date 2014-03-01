describe "playerRepository",->
 Given -> module ( "app" )
 
 Given inject ($injector) ->
  @subject = $injector.get "playerRepository"
 
 Then -> expect(@subject).toBeDefined()
 Then -> expect(@subject.path).toEqual('/api/v1/players')