describe "collegesController", ->
 Given -> module ("app")
 Given inject ($controller, $q, _collegeRepository_ ) ->
  @colleges = ['OSU','MSU']
  #cr = angular.mock.inject _collegeRepository_
  #console.log cr
  @collegeRepository = { 
   path: '/api/v1/colleges', 
   get: -> 
  }
  @playerRepository = { 
   path:'',
   get: -> 
  }

  spyOn(@collegeRepository, "get")
  @subject = $controller "collegesController", {collegeRepository:@collegeRepository, playerRepository:@playerRepository}
 
 When -> 
 
 Then -> expect(@collegeRepository.get).toHaveBeenCalled()
  
 describe "list()", -> 
  Given -> 
   @collegeRepository.getColleges = -> 
   spyOn(@collegeRepository,'getColleges').andReturn @colleges

  When -> @result = @subject.list()
  Then -> expect(@result).toEqual(@colleges)
  
 describe "add()", ->
  Given -> 
   @collegeRepository.add = ->
   @college = "UM"
   
  describe "when the college service returns true", ->
   Given -> spyOn(@collegeRepository,'add').andReturn true
   
   When -> @result = @subject.add(@college)
   Then -> expect(@collegeRepository.add).toHaveBeenCalledWith(@college)
   Then -> expect(@result).toBeTruthy()
  
  describe "when the college service returns false", ->
   Given -> spyOn(@collegeRepository,'add').andReturn false
   
   When -> @result = @subject.add(@college)
   Then -> expect(@collegeRepository.add).toHaveBeenCalledWith(@college)
   Then -> expect(@result).toBeFalsy()
  
  
 describe "remove()", ->
  Given ->
   @collegeRepository.remove = ->
   @college = {name: "UM" }
   
  describe "when the college service returns true", ->
   Given -> spyOn(@collegeRepository,'remove').andReturn true
   
   When -> @result = @subject.remove(@college)
   Then -> expect(@collegeRepository.remove).toHaveBeenCalledWith(@college)
   Then -> expect(@result).toBeTruthy()
   
  describe "when the college service returns false", ->
   Given -> spyOn(@collegeRepository,'remove').andReturn false
   
   When -> @result = @subject.remove(@college)
   Then -> expect(@collegeRepository.remove).toHaveBeenCalledWith(@college)
   Then -> expect(@result).toBe(false)
   
  describe "when the college to remove is selected", ->
   Given ->
    @collegeRepository.selection = @college 
    @collegeRepository.select = ->
    spyOn(@collegeRepository,'remove').andReturn true
    spyOn(@collegeRepository,'select')
    
   When -> @result = @subject.remove(@college)
   Then -> expect(@collegeRepository.select).toHaveBeenCalledWith()
   
 describe "select()", ->
  Given ->
   @collegeRepository.select = ->
   @college = {name: "UM", id:2, resources: { players: @collegeRepository.path + '/2/players' } }
   
  describe "when the college service returns true", ->
   Given -> 
    spyOn(@collegeRepository,"select").andReturn(true)
    spyOn(@playerRepository,"get")
    
   When -> @result = @subject.select(@college)
   Then -> expect(@collegeRepository.select).toHaveBeenCalledWith(@college)
   Then -> expect(@result).toBeTruthy()
   Then -> expect(@playerRepository.path).toEqual(@collegeRepository.path + '/2/players')
   Then -> expect(@playerRepository.get).toHaveBeenCalled()
   
   
 describe "hasSelection() when something is selected", ->
  Given ->  @collegeRepository.selection = {"name":"OSU","id":1,"resources":{"players":"/api/v1/colleges/1/players"}}
  When -> @result = @subject.hasSelection()
  Then -> expect(@result).toBeTruthy

 describe "hasSelection() when selection is undefined", ->
  Given ->  @collegeRepository.selection = undefined
  When -> @result = @subject.hasSelection()
  Then -> expect(@result).toBe(false)

 describe "hasSelection() when selection is null", ->
  Given ->  @collegeRepository.selection = null
  When -> @result = @subject.hasSelection()
  Then -> expect(@result).toBe(false)
  
 describe "getSelected()", ->
  Given ->
   @college = {name: "UM"}
   @collegeRepository.selection = @college
   
  describe "when the college service returns a college", ->
   When -> @result = @subject.getSelected()
   Then -> expect(@result).toBe(@college)
   
 describe "flash() when college service is a 404", ->
  Given ->
   @collegeRepository.lastError = 404
   
  When -> @result = @subject.flash()
  Then -> expect(@result).toEqual("We're sorry, we were unable to process your request.  The resource was not found.")