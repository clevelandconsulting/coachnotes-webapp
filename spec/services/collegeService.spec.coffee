#@collegeService = {
#  	getAll: ->,
#  	add: ->,
#  	remove: ->,
#  	select: ->,
#  	selected: ->,
#  }

describe "collegeService", ->
 Given -> module("app")
 
 Given inject ($injector, $http, $httpBackend, $rootScope, $q) ->
  @http = $http
  @q = $q
  @httpBackend = $httpBackend
  @rootScope = $rootScope
  @path = "/api/v1/colleges"
  @colleges = ['OSU','MSU']
  @subject = $injector.get 'collegeService', {$http: @http, $q: @q}
 
 describe "get()", ->
  Given ->
   @httpBackend.when("GET", @path).respond(@colleges)
      
  When -> 
   @subject.get()
   @httpBackend.flush()
   @rootScope.$apply()
   
  Then -> @httpBackend.expectGET(@path)
  Then -> expect(@subject.colleges).toEqual(@colleges)
  
 describe "add()", ->
  Given ->
   @subject.colleges = @colleges
   @college = 'UM'
   @httpBackend.when("POST",@path).respond({name: @college})
   
  describe "when adding a new college" , ->
   When ->
    @subject.add('um')
    @httpBackend.flush()
    @rootScope.$apply()
   
   Then -> @httpBackend.expectPOST(@path, {name: 'um'})
   Then -> expect(@subject.colleges).toContain({name: @college})
  
  describe "when adding a college already in the list", ->
   When ->
    @expectedColleges = @subject.colleges
    @subject.add('OSU')
    @httpBackend.flush()
    @rootScope.$apply()
    
   Then -> @httpBackend.expectPOST(@path, {name: 'OSU'})
   Then -> expect(@subject.colleges).toEqual(@expectedColleges)
  
 describe "select()", ->
  Given -> @subject.colleges = @colleges
   
  describe "when called with a college in the list", ->
   Given -> @college = {name: 'OSU'}
   When -> @subject.select(@college)
   Then -> expect(@subject.selection).toBe(@college)
   