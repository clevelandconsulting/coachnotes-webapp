class collegesController
 constructor: (@collegeRepository, @playerRepository, @objectArrayService) ->
  @collegeRepository.get()
  @error = ''
 
 list: ->
  @collegeRepository.getColleges()
  
 add: (name) ->
  @collegeRepository.add(name)
  
 remove: (college) ->
  if @collegeRepository.selection? and @objectArrayService.inArray([@collegeRepository.selection],college)
   @collegeRepository.select()
  result = @collegeRepository.remove(college)
  
  
 select: (college) ->
  result = @collegeRepository.select(college)
  @loadPlayers()
  
  result
  
 hasSelection: ->
  @collegeRepository.selection?
  
 getError: ->
  if @error? and @error != ''
   @error
  else if @collegeRepository.lastError? and @collegeRepository.lastError != 0 and @collegeRepository.lastError != ''
   if @collegeRepository.lastError == 404
    "We're sorry, we were unable to process your request.  The resource was not found."
   else
    @collegeRepository.lastError
  
 hasError: -> 
  return ( @error? and @error != '' ) or ( @collegeRepository.lastError? and @collegeRepository.lastError != 0 and @collegeRepository.lastError != '')
  
 getSelected: ->
  @collegeRepository.selection
  
 loadPlayers: ->
  try 
   @playerRepository.path = @collegeRepository.selection.getResource('players').url
   @playerRepository.get()  
  catch e
    @error = e.message 
    
 flash: ->
  @getError()
  
  
angular.module('app').controller 'collegesController', collegesController