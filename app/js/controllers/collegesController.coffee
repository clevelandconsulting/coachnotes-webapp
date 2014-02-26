class collegesController
 constructor: (@collegeService) ->
  @collegeService.getAll().then (colleges) =>
   @list = colleges
 
 add: (name) ->
  @collegeService.add(name)
  
 remove: (name) ->
  @collegeService.remove(name)
  
 select: (name) ->
  @collegeService.select(name)
  
 getSelected: () ->
  @collegeService.selected()
  
angular.module('app').controller 'collegesController', collegesController