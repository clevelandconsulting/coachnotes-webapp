class collegesController
 constructor: (@collegeRepository, @playerRepository, @objectArrayService) ->
  @collegeRepository.get()
 
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
  @playerRepository.path = college.resources.players.url
  @playerRepository.get()
  
  result
  
 hasSelection: ->
  @collegeRepository.selection?
  
 getSelected: () ->
  @collegeRepository.selection
  
 flash: () ->
  error = @collegeRepository.lastError
  if error == 404
   "We're sorry, we were unable to process your request.  The resource was not found."
  
angular.module('app').controller 'collegesController', collegesController