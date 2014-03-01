angular.module('app').factory 'apiRepositoryFactory', ['$http','$q','objectArrayService', ($http, $q, objectArrayService) ->
 class apiRepositoryFactory

	 get: ->
	  @d = $q.defer();
	  $http.get(@path).success (data) =>
	   @d.resolve data
	   @items = data
	  .error (data, code) =>
	   @items = []
	  
	  @d.promise
	  
	 add: (item) ->  
	  @d = $q.defer();
	  $http.post(@path, item ).success (data) =>
	   @d.resolve data
	   console.log @items, data
	   if @items? 
	    if !objectArrayService.inArray @items, data
	     @items.push data
	   else 
	    @items = [data]
	   
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