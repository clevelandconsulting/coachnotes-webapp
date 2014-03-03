describe "apiNameIdRepositoryFactory", ->
 Given -> module("app")
 
 Given inject ($injector, $http, $httpBackend, $rootScope, $q, _apiRepositoryFactory_, _apiModelFactory_) ->
  @http = $http
  @q = $q
  @httpBackend = $httpBackend
  @rootScope = $rootScope
  @path = "/api/v1/colleges"
  @colleges = [{name:'OSU', id: 1},{name:'MSU', id: 2}]
  @mockapiRepositoryFactory = angular.mock.inject _apiRepositoryFactory_
  @apiModelFactory = _apiModelFactory_
  @apiNameIdRepositoryFactoryFactory = $injector.get 'apiNameIdRepositoryFactory', {apiRepositoryFactory:@mockapiRepositoryFactory}
  @subject = new @apiNameIdRepositoryFactoryFactory()
  @subject.path = @path
  
 Then -> expect(@subject.get).toBeDefined()
 Then -> expect(@subject.path).toEqual(@path)
 
 #----------------------------------------------------------------------
 #
 #    getColleges
 #
 #----------------------------------------------------------------------
 
 describe "getColleges()", ->
  Given ->
   @subject.items = @colleges
   
  When -> @result = @subject.getColleges()
  Then -> expect(@result).toBe(@colleges)
  
 #----------------------------------------------------------------------
 #
 #    ADD -- OVERRIDES BASE
 #
 #----------------------------------------------------------------------
  
 describe "add()", ->
  Given ->
   @subject.colleges = @colleges
   @college = 'UM'
   @httpBackend.when("POST",@path).respond({name: @college})
   
  describe "when adding a new college" , ->
   When ->
    @subject.add('um')
    @model = new @apiModelFactory({name: 'UM'})
    @httpBackend.flush()
    @rootScope.$apply()
   
   Then -> @httpBackend.expectPOST(@path, {name: 'um'})
   Then -> expect(@subject.items).toContain(@model)
  
  describe "when adding a college already in the list", ->
   When ->
    @expectedColleges = @subject.colleges
    @subject.add('OSU')
    @httpBackend.flush()
    @rootScope.$apply()
    
   Then -> @httpBackend.expectPOST(@path, {name:'OSU'})
   Then -> expect(@subject.colleges).toEqual(@expectedColleges)
   
 

 
 #----------------------------------------------------------------------
 #
 #    REMOVE -- OVERRIDES BASE
 #
 #----------------------------------------------------------------------
 
 describe "remove()", ->
  Given -> 
   @subject.items = @colleges
   
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
    Then -> expect(@subject.items).not.toContain(@college)
    Then -> expect(@subject.items).toContain({name: 'MSU', id: 2})
   
   describe "when called with a college not in the list", ->
    Given -> @college = {name:'UM', id: 3}
    When -> 
     @subject.remove(@college)
     @httpBackend.flush()
     @rootScope.$apply()
    
    Then -> @httpBackend.expectDELETE(@path+'/3','')
    Then -> expect(@subject.items).toEqual(@colleges)
  
  describe 'with unsuccessful http response', ->
   Given ->
    @college = {name:'OSU', id: 2}
    @httpBackend.when("DELETE",@path+'/2').respond (method, url, data, headers) -> [404, '', '']
    
   When ->
    @subject.remove(@college)
    @httpBackend.flush()
    @rootScope.$apply()
    
   Then -> @httpBackend.expectDELETE(@path+'/2','')
   Then -> expect(@subject.items).toEqual(@colleges)
   Then -> expect(@subject.lastError).toEqual(404)
 