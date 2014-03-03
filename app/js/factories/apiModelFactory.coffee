angular.module('app').factory 'apiModelFactory', [ 'apiResourceFactory', (apiResourceFactory) ->
 class apiModelFactory
  constructor: (json) ->
   @resources = {}
   @data = {}
   Object.keys(json).every (key) =>
    if key != 'resources'
     @data[key] = json[key]
    else
     @addResources json[key]
    
  addResources: (resources) ->
   Object.keys(resources).every (key) => 
    @resources[key] = new apiResourceFactory()
    @resources[key].setUrl resources[key]
    
  getResource: (name) ->
   if @resources[name]?
    @resources[name]
   else
    throw new Error 'No resource named ' + name + ' found.'
]