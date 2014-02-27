class collegeService
 constructor: ($http, $q) ->
  @http = $http
  @q = $q
  
 get: ->
  @d = @q.defer();
  @http.get('/api/v1/colleges').success (data) =>
   @d.resolve data
   @colleges = data
  
  @d.promise

 add: (name) ->  
  @d = @q.defer();
  @http.post('/api/v1/colleges', {name:name} ).success (data) =>
   @d.resolve data
   if @colleges? 
    if !(data in @colleges)
     @colleges.push data
   else 
    @colleges = [data]
   
  @d.promise
  
 select: (name) ->
  @selection = name
  
angular.module('app').service 'collegeService', collegeService