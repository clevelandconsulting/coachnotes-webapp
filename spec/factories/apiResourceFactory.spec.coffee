describe "apiResourceFactory", ->
 Given -> module('app')
 
 Given inject ($injector) ->
  @apiResourceFactory = $injector.get 'apiResourceFactory'
  
 When -> @subject = new @apiResourceFactory()
  
 Then -> expect(@subject).toBeDefined()
 
 describe "setUrl", ->
  Given -> @url = '/some/url'
   
  When -> @subject.setUrl(@url)
  Then -> expect(@subject.url).toBe(@url)