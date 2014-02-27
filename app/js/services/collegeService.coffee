class collegeService
 constructor: ($http, $q, _objectArrayService_) ->
  @http = $http
  @q = $q
  @objectArrayService = _objectArrayService_
  
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
    if !@objectArrayService.inArray @colleges, data
     @colleges.push data
   else 
    @colleges = [data]
   
  @d.promise
  
 remove: (college) -> 
  @http.delete('/api/v1/colleges/' + college.id ).success (data) =>
    @colleges = @objectArrayService.deleteFromArray(@colleges,college)
  .error (data, code) =>  
   @lastError = code    
   
 select: (college) ->
  if @objectArrayService.inArray @colleges, college
   @selection = college
  
angular.module('app').service 'collegeService', collegeService