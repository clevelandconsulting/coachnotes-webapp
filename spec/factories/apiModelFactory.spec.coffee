describe "apiModelFactory", ->
 Given -> module ('app')
 Given inject ($injector, _apiResourceFactory_ ) ->
  @apiResourceFactory = _apiResourceFactory_
  @players = '/api/v1/colleges/1/players'
  @data = {}
  @playersResource = new @apiResourceFactory()
  @playersResource.setUrl @players
  @modelFactory = $injector.get "apiModelFactory", _apiResourceFactory_
   
 Then -> expect(@modelFactory).toBeDefined()

 describe "generating a new model with valid json", ->
  Given -> 
   @data.name = 'OSU'
   @data.id = 1
   @json = { name: @data.name, id: @data.id, resources: { players: @players } }
   
  When -> @subject = new @modelFactory(@json)
  
  Then -> expect(@subject.data.id).toBe(@data.id)
  Then -> expect(@subject.data.name).toBe(@data.name)
  Then -> expect(@subject.resources.players).toEqual(@playersResource)
  
  
  describe "getResource() with a valid resource name", ->
   Given -> @resourceName = 'players'
   
   When -> @result = @subject.getResource(@resourceName)
   Then -> expect(@result).toEqual(@playersResource)
  
  describe "getResource() with an invalid resource name", ->
   Given -> @resourceName = 'something-not-valid'
   
   Then -> expect(-> @subject.getResource(@resourceName)).toThrow()
   