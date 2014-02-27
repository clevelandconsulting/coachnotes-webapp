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
  @colleges = [{name:'OSU', id: 1},{name:'MSU', id: 2}]
  @subject = $injector.get 'collegeService', {$http: @http, $q: @q, objectArrayService:$injector.get 'objectArrayService'}
 
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
    
   Then -> @httpBackend.expectPOST(@path, {name:'OSU'})
   Then -> expect(@subject.colleges).toEqual(@expectedColleges)
  
 describe "select()", ->
  Given -> @subject.colleges = @colleges
   
  describe "when called with a college in the list", ->
   Given -> @college = {name:'OSU'}
   When -> @subject.select(@college)
   Then -> expect(@subject.selection).toEqual(@college)
   
  describe "when called with a college not in the list", ->
   Given -> @college = {name:'UM'}
   When -> @subject.select(@college)
   Then -> expect(@subject.selection).not.toEqual(@college)
   
 describe "remove()", ->
  Given -> 
   @subject.colleges = @colleges
   
  describe "with successful http response", ->
   Given ->
    @httpBackend.when("DELETE",@path+'/1').respond (method, url, data, headers) -> [204, '', '']
    @httpBackend.when("DELETE",@path+'/3').respond (method, url, data, headers) -> [204, '', '']
   
   describe "when called with a college in the list", ->
    Given -> @college = {name:'OSU', id: 1}
    When -> 
     @subject.remove(@college)
     @httpBackend.flush()
     @rootScope.$apply()
    
    Then -> @httpBackend.expectDELETE(@path+'/1','')
    Then -> expect(@subject.colleges).not.toContain(@college)
    Then -> expect(@subject.colleges).toContain({name: 'MSU', id: 2})
   
   describe "when called with a college not in the list", ->
    Given -> @college = {name:'UM', id: 3}
    When -> 
     @subject.remove(@college)
     @httpBackend.flush()
     @rootScope.$apply()
    
    Then -> @httpBackend.expectDELETE(@path+'/3','')
    Then -> expect(@subject.colleges).toEqual(@colleges)
  
  describe 'with unsuccessful http response', ->
   Given ->
    @college = {name:'OSU', id: 2}
    @httpBackend.when("DELETE",@path+'/2').respond (method, url, data, headers) -> [404, '', '']
    
   When ->
    @subject.remove(@college)
    @httpBackend.flush()
    @rootScope.$apply()
    
   Then -> @httpBackend.expectDELETE(@path+'/2','')
   Then -> expect(@subject.colleges).toEqual(@colleges)
   Then -> expect(@subject.lastError).toEqual(404)