class collegesController
 constructor: (@collegeService) ->
  @collegeService.get()
 
 list: ->
  @collegeService.colleges
  
 add: (name) ->
  @collegeService.add(name)
  
 remove: (name) ->
  @collegeService.remove(name)
  
 select: (name) ->
  @collegeService.select(name)
  
 getSelected: () ->
  @collegeService.selection
  
 flash: () ->
  error = @collegeService.lastError
  if error == 404
   "We're sorry, we were unable to process your request.  The resource was not found."
  
angular.module('app').controller 'collegesController', collegesController