angular.module('app').factory 'apiNameIdRepositoryFactory', (_apiRepositoryFactory_) ->

 class apiNameIdRepositoryFactory extends _apiRepositoryFactory_
	 constructor: ->
	  
	 add: (name) ->  
	  super({name: name});
	  
	 remove: (college) -> 
	  super(college,college.id)
	  
	 getColleges: ->
	  @items 
