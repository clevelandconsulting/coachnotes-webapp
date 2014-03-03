angular.module('app').factory 'apiResourceFactory', ->
 class apiResourceFactory
  setUrl: (url) ->
   @url = url