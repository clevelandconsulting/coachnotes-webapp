#@collegeService = {
#  	getAll: ->,
#  	add: ->,
#  	remove: ->,
#  	select: ->,
#  	selected: ->,
#  }

describe "collegeService", ->
 Given -> module("app")
 
 Given inject ($injector, $http, $q) ->
  @http = $http
  @q = $q
  @path = "api/v1/colleges"
  @subject = $injector.get 'collegeService', {$http: @http, $q: @q}
 
 describe "getAll()", ->
  Given inject ($httpBackend, $rootScope) ->
   @httpBackend = $httpBackend
   @rootScope = $rootScope
   @colleges = ['OSU','MSU'];
   @httpBackend.when("GET", @path).respond(@colleges);
   #@h = spyOn(@http, 'get').andCallThrough() #.andReturn(@colleges)
   
  When -> 
   @promise = @subject.getAll().then (data) => @result = data
   
   @httpBackend.flush()
   @rootScope.$apply()
   
   
  Then -> @httpBackend.expectGET(@path);
  Then -> expect(@result).toEqual(@colleges)