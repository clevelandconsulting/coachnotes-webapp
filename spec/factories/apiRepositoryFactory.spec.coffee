describe "apiRespository", ->

 Given -> module("app")
 
 Given inject ($injector, $http, $q, $httpBackend, $rootScope, _apiModelFactory_) ->
  @http = $http
  @q = $q
  @httpBackend = $httpBackend
  @rootScope = $rootScope 
  @objectArrayService = $injector.get 'objectArrayService'
  @apiModelFactory = _apiModelFactory_
  @apiRepositoryFactoryFactory = $injector.get 'apiRepositoryFactory', {$http:@http,$q:@a,objectArrayService:@objectArrayService}
  
  @obj1 = {attribute1: 'somevalue1', attribute2: 'somevalue2'}
  @obj2 = {attribute1: 'somevalue1a', attribute2: 'somevalue2a'}
  @newObj = {attribute1:'newvalue',attribute2:'newvalue2'}
  @items = [@obj1,@obj2]
  @itemsAsModel = []
  for item in @items
   @itemsAsModel.push new @apiModelFactory item
   
  @path = 'somePath'
  @subject = new @apiRepositoryFactoryFactory() #(@http,@q,objectArrayService)
  
  @subject.path = @path
  
 When -> 
 
 Then -> expect(@subject).toBeDefined()
 
 #####################################################################
 #
 #    GET
 #
 #####################################################################
 
 describe "get() with a valid response", ->
  Given ->
   @httpBackend.when('GET',@path).respond(@items)
     
  When -> 
   @subject.get()
   @httpBackend.flush()
   @rootScope.$apply()
   
  Then -> @httpBackend.expectGET(@path)
  Then -> expect(@subject.items).toEqual(@itemsAsModel)
  
 describe "get() with an invalid response", ->
  Given ->
   @httpBackend.when('GET',@path).respond (method, url, data, headers) -> [404, '', '']
     
  When -> 
   @subject.get()
   @httpBackend.flush()
   @rootScope.$apply()
   
  Then -> @httpBackend.expectGET(@path)
  Then -> expect(@subject.items).toEqual([])
  
  
  
 #####################################################################
 #
 #    ADD
 #
 #####################################################################
   
 describe "add()", ->
  Given ->
   @model = new @apiModelFactory(@newObj)
   @subject.items = @items
   @httpBackend.when("POST",@path).respond(@newObj)
   
  describe "when adding a new item" , ->
   When ->
    @subject.add(@newObj)
    @httpBackend.flush()
    @rootScope.$apply()
   
   Then -> @httpBackend.expectPOST(@path, @newObj)
   Then -> expect(@subject.items).toContain(@model)
  
  describe "when adding an item already in the list", ->
   When ->
    @expectedItems = @subject.items
    @item = @obj1
    @subject.add(@item)
    @httpBackend.flush()
    @rootScope.$apply()
    
   Then -> @httpBackend.expectPOST(@path, @item)
   Then -> expect(@subject.items).toEqual(@expectedItems)
   
 #####################################################################
 #
 #    SELECT
 #
 #####################################################################
 
 describe "select()", ->
  Given -> @subject.items = @items
   
  describe "when called with a item in the list", ->
   Given -> @item = @obj1
   When -> @subject.select(@item)
   Then -> expect(@subject.selection).toEqual(@item)
   
  describe "when called with an item not in the list", ->
   Given ->
   When -> @subject.select(@newObj)
   Then -> expect(@subject.selection).not.toEqual(@newObj)
   
  describe "when called with nothing", ->
   Given ->
   When -> @subject.select()
   Then -> expect(@subject.selection).not.toBeDefined()
   
   
 #####################################################################
 #
 #    REMOVE
 #
 #####################################################################
 
 describe "remove()", ->
  Given -> 
   @subject.items = @items
   
  describe "with successful http response", ->
   Given ->
    @httpBackend.when("DELETE",@path+'/1').respond (method, url, data, headers) -> [204, '', '']
    @httpBackend.when("DELETE",@path+'/3').respond (method, url, data, headers) -> [204, '', '']
   
   describe "when called with an item in the list", ->
    Given -> @item = @obj1
    When -> 
     @subject.remove(@item,1)
     @httpBackend.flush()
     @rootScope.$apply()
    
    Then -> @httpBackend.expectDELETE(@path+'/1','')
    Then -> expect(@subject.items).not.toContain(@item)
    Then -> expect(@subject.items).toContain(@obj2)
   
   describe "when called with an item not in the list", ->
    Given ->
    When -> 
     @subject.remove(@newObj,3)
     @httpBackend.flush()
     @rootScope.$apply()
    
    Then -> @httpBackend.expectDELETE(@path+'/3','')
    Then -> expect(@subject.items).toEqual(@items)
  
  describe 'with unsuccessful http response', ->
   Given ->
    @httpBackend.when("DELETE",@path+'/1').respond (method, url, data, headers) -> [404, '', '']
    
   When ->
    @subject.remove(@obj1,1)
    @httpBackend.flush()
    @rootScope.$apply()
    
   Then -> @httpBackend.expectDELETE(@path+'/1','')
   Then -> expect(@subject.items).toEqual(@items)
   Then -> expect(@subject.lastError).toEqual(404)