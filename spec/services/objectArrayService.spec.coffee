describe "objectArrayService", ->
 Given -> module('app')
 
 Given inject ($injector) ->
  @subject = $injector.get('objectArrayService')
  @obj1 = {name:'OSU', id: 1};
  @obj2 = {name:'MSU', id: 2}
  @myArray = [@obj1,@obj2]
  
 describe "findByMatchingProperties() with valid property", ->
  When -> @result = @subject.findByMatchingProperties(@myArray,{name:@obj1.name})
  Then -> expect(@result).toEqual([@obj1])
  
 describe "findByMatchingProperties() with invalid property", ->
  When -> @result = @subject.findByMatchingProperties(@myArray,{name:'UM'})
  Then -> expect(@result).toEqual([])
  
 describe "inArray() with valid property", ->
  When -> @result = @subject.inArray(@myArray,{name:@obj1.name})
  Then -> expect(@result).toBe(true)
  
 describe "inArray() with invalid property", ->
  When -> @result = @subject.inArray(@myArray,{name:'UM'})
  Then -> expect(@result).toBe(false)
  
 describe "deleteFromArray() with valid property", ->
  When -> @result = @subject.deleteFromArray(@myArray,{name:@obj1.name})
  Then -> expect(@result).not.toContain(@obj1)
  Then -> expect(@result).toContain(@obj2)
  