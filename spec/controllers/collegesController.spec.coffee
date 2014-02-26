describe "collegesController", ->
 Given -> module ("app")
 Given inject ($controller, $q) ->
  @colleges = ['OSU','MSU']
  @collegeService = { get: -> }
  @controller = $controller
  spyOn(@collegeService,'get')#.andReturn(@d.promise)
 
 When -> @subject = @controller "collegesController", {collegeService:@collegeService}
   
 Then -> expect(@collegeService.get).toHaveBeenCalled()
  
 describe "list()", -> 
  Given -> @collegeService.colleges = @colleges 
  When -> @result = @subject.list()
  Then -> expect(@result).toEqual(@colleges)
  
 describe "add()", ->
  Given -> 
   @collegeService.add = ->
   @college = "UM"
   
  describe "when the college service returns true", ->
   Given -> spyOn(@collegeService,'add').andReturn true
   
   When -> @result = @subject.add(@college)
   Then -> expect(@collegeService.add).toHaveBeenCalledWith(@college)
   Then -> expect(@result).toBeTruthy()
  
  describe "when the college service returns false", ->
   Given -> spyOn(@collegeService,'add').andReturn false
   
   When -> @result = @subject.add(@college)
   Then -> expect(@collegeService.add).toHaveBeenCalledWith(@college)
   Then -> expect(@result).toBeFalsy()
  
  
 describe "remove()", ->
  Given ->
   @collegeService.remove = ->
   @college = "UM"
   
  describe "when the college service returns true", ->
   Given -> spyOn(@collegeService,'remove').andReturn true
   
   When -> @result = @subject.remove(@college)
   Then -> expect(@collegeService.remove).toHaveBeenCalledWith(@college)
   Then -> expect(@result).toBeTruthy()
   
  describe "when the college service returns false", ->
   Given -> spyOn(@collegeService,'remove').andReturn false
   
   When -> @result = @subject.remove(@college)
   Then -> expect(@collegeService.remove).toHaveBeenCalledWith(@college)
   Then -> expect(@result).toBeFalsy()
   
 describe "select()", ->
  Given ->
   @collegeService.select = ->
   @college = "UM"
   
  describe "when the college service returns true", ->
   Given -> 
    spyOn(@collegeService,"select").andReturn(true)
    
   When -> @result = @subject.select(@college)
   Then -> expect(@collegeService.select).toHaveBeenCalledWith(@college)
   Then -> expect(@result).toBeTruthy()
   
 describe "getSelected()", ->
  Given ->
   @collegeService.selected = ->
   @college = "UM"
   
  describe "when the college service returns a college", ->
   Given -> spyOn(@collegeService,"selected").andReturn(@college)
      
   When -> @result = @subject.getSelected()
   Then -> expect(@collegeService.selected).toHaveBeenCalled()
   Then -> expect(@result).toBe(@college)