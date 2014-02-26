class collegeService
 constructor: ($http, $q) ->
  @http = $http
  @q = $q
  
 getAll: ->
  @d = @q.defer();
  @http.get('api/v1/colleges').success (data) =>
   @d.resolve data
  
  @d.promise
   
 #getAll: -> 
 # if @colleges == null
 #  @promise = @all()
 #  @promise.then (data) => @promise = data
  
 # @promise
  
  #result = @http.get('api/v1/colleges')
  #console.log result
 
angular.module('app').service 'collegeService', collegeService