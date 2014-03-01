describe "collegeRepository",->
 Given -> module ( "app" )
 
 Given inject ($injector) ->
  @subject = $injector.get "collegeRepository"
 
 Then -> expect(@subject).toBeDefined()
 Then -> expect(@subject.path).toEqual('/api/v1/colleges')