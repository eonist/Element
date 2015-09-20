/**
 * Note: swift is very inspired by AppleScript!
 */
var someString:String = "some text";
someText += " more text"//string or text;

var someInt:Int = 5;
var smallNum:Float = 7473947492947;//32 bit number
var bigNum:Duoble = 13242415553626262.5335;//64 bit num
var someCharacter:Char = "g"// single character type
var trueOrFalse:Bool// boolean true or false

Double(someInt) * bigNum//you must wrap ints in double if you want to use different number types together


let SOME_STATIC_VARIABLE:String = "some name";// constant variable, this is also a way to enable the obj-c style: immutableNSarray and mutableNSarray and comparable classes

printin("hello world");//is the log or trace in swift

var someText:String = "and";
var newText:String = "the town is light \(someText) the city is bright" //string interpolation, you can also do math: \(someVarA * someVarB)
printin(newText);

//modulo 
//NOTE: modulo works with floats and negative numbers in swift


//* astrix in swift is:
var someObj:AnyObject
var something:Any

//and for array:
var arrayofobjects : [Anyobject]
var arrayofAnything : [Any]

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
 * - Structures vs. Classes in Swift
- Structures - value types
- Classes - reference types
- String, Array, Dictionary - implemented as structure
- Structures are still intended for simpler situations
 
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


 */


