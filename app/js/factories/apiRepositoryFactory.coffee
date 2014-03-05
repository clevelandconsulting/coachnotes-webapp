typeIsArray = ( value ) ->
    value and
        typeof value is 'object' and
        value instanceof Array and
        typeof value.length is 'number' and
        typeof value.splice is 'function' and
        not ( value.propertyIsEnumerable 'length' )


angular.module('app').factory 'apiRepositoryFactory', ['$http','$q','objectArrayService', 'apiModelFactory', ($http, $q, objectArrayService, apiModelFactory) ->
 class apiRepositoryFactory
 	constructor: ->
 	 @items = []
 	  
  get: ->
   @d = $q.defer();
   $http.get(@path).success (data) =>
    @items = []
    if typeIsArray data
     for obj in data
      @items.push new apiModelFactory obj
    else
     @items.push new apiModelFactory data
     
    @d.resolve @items
   .error (data, code) =>
    @items = []
   
   @d.promise
   
  add: (item) ->  
   @d = $q.defer();
   $http.post(@path, item ).success (data) =>
    model = new apiModelFactory(data)
    @d.resolve model
    if @items? 
     if !objectArrayService.inArray @items, model
      @items.push model
    else 
     @items = [model]
    
   @d.promise
   
  remove: (item,id) -> 
   $http.delete(@path + '/' + id).success (data) =>
     @items = objectArrayService.deleteFromArray(@items,item)
   .error (data, code) =>  
    @lastError = code  
  
  select: (item) ->
   if item?
    if objectArrayService.inArray @items, item
     @selection = item
   else   
    @selection = undefined
]