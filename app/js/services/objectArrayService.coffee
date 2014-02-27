#function findByMatchingProperties(set, properties) {
#    return set.filter(function (entry) {
#        return Object.keys(properties).every(function (key) {
#            return entry[key] === properties[key];
#        });
#    });
#}

class objectArrayService
 findByMatchingProperties: (set,properties) ->
  set.filter (entry) -> Object.keys(properties).every (key) -> entry[key]==properties[key]
  
 inArray: (set,properties) -> 
  result = @findByMatchingProperties set, properties
  result.length > 0
  
 deleteFromArray: (set,properties) ->
  i = 0
  set.filter (entry) -> 
   matches = true
   Object.keys(properties).every (key) -> 
    if entry[key]!=properties[key]
     matches = false
   
   if matches
    set.splice(i,1)
   
   i++
  
  set
  
angular.module('app').service 'objectArrayService', objectArrayService