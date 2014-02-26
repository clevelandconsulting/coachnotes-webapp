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
  @subject = $injector.get 'collegeService', {$http: @http, $q: @q}
 
 describe "get()", ->
  Given ->
   @colleges = ['OSU','MSU']
   @httpBackend.when("GET", @path).respond(@colleges)
      
  When -> 
   @subject.get()
   @httpBackend.flush()
   @rootScope.$apply()
   
  Then -> @httpBackend.expectGET(@path)
  Then -> expect(@subject.colleges).toEqual(@colleges)
  
 describe "add()", ->
  Given ->
   @college = 'UM'
   @httpBackend.when("POST",@path).respond(@college)
   
  When ->
   @subject.add(@college)
   @httpBackend.flush()
   @rootScope.$apply()
   
  Then -> @httpBackend.expectPOST(@path, {name: @college})
  Then -> expect(@subject.colleges).toContain(@college)
  