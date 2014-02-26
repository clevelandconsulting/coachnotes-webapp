describe "collegesController", ->
 Given -> module ("app")
 Given inject ($controller, $q, $timeout, $rootScope) ->
  @colleges = ['OSU','MSU']
  @collegeService = {
    all: ->,
  	getAll: -> ,
  	colleges: @colleges,
  	add: ->,
  	remove: ->,
  	select: ->,
  	selected: ->,
  }
  @d = $q.defer()
  #f =  => 
  #$timeout f, 100
  @rootScope = $rootScope
  
  spyOn(@collegeService,'getAll').andReturn(@d.promise)
  @subject = $controller "collegesController", {collegeService:@collegeService}
  
 #When -> @rootScope.$apply() 
 Then -> expect(@collegeService.getAll).toHaveBeenCalled()
  
 describe "list", ->
  When ->
   @d.resolve @colleges
   @rootScope.$apply() 
   @result = @subject.list
  Then -> expect(@result).toEqual(@colleges)
  
 describe "add()", ->
  Given -> 
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
   @college = "UM"
   
  describe "when the college service returns true", ->
   Given -> 
    spyOn(@collegeService,"select").andReturn(true)
    
   When -> @result = @subject.select(@college)
   Then -> expect(@collegeService.select).toHaveBeenCalledWith(@college)
   Then -> expect(@result).toBeTruthy()
   
 describe "getSelected()", ->
  Given ->
   @college = "UM"
   
  describe "when the college service returns a college", ->
   Given -> spyOn(@collegeService,"selected").andReturn(@college)
      
   When -> @result = @subject.getSelected()
   Then -> expect(@collegeService.selected).toHaveBeenCalled()
   Then -> expect(@result).toBe(@college)