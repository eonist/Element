
/*
 * Structures in Swift
 * Structures are value types (pass by value)
 * when assigned to another variable, or passed to a
 * function, a structure's value is copied
 * Classes are reference types (pass by reference)
 * when assigned to another variable, or passed to a
 * function, a reference to the original object is passed
 * NOTE: structs does not support heritance
 * NOTE: you get automated param suggestions for variables when using structs
 * NOTE: structs are great as dataContainers that wont be needing heritance
 */

// Playground - Pass By Reference
class SimpleClass {//replacing the class with struct makes this a struct which behave like a copy not a reference
	var value : Int = 99
}
// Simple function that changes an object
func changeObject(var object : SimpleClass) -> Int {
	object.value += 1000
	return obj ect.value
}
// create a new instance (reference type)
var myobject = SimpleClass()
// pass the object into the function - Pass by Reference
changeobject(myobject)

// the original object has been changed.
myobject.value//1099


/*

- Structures vs. Classes in Swift
- Structures - value types
- Classes - reference types
- String, Array, Dictionary - implemented as structure
- Structures are still intended for simpler situations
 
 */



//modulo 
//NOTE: modulo works with floats and negative numbers in swift






//* astrix in swift is:
var someObj:AnyObject
var something:Any

//and for array:
var arrayofobjects : [Anyobject]
var arrayofAnything : [Any]