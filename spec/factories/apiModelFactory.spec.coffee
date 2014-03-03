describe "apiModelFactory", ->
 Given -> module ('app')
 Given inject ($injector, _apiResourceFactory_ ) ->
  @apiResourceFactory = _apiResourceFactory_
  @subject = $injector.get "apiModelFactory", _apiResourceFactory_
  
 Then -> expect(@subject).toBeDefined()
 
 describe "generating a new model with valid json", ->
  Given -> 
   @name = 'OSU'
   @id = 1
   @players = '/api/v1/colleges/1/players'
   @json = { name: @name, id: @id, resources: { players: @players } }
   
  When -> @collegeModel = new @subject(@json)
  
  Then -> expect(@collegeModel.data.id).toBe(@id)
  Then -> expect(@collegeModel.data.name).toBe(@name)
  Then -> expect(@collegeModel.resources.players.url).toBe(@players)