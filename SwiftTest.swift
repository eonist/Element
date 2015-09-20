/**
 * TODO: add the wiki of this project to GitSync ICloud integration
 * TODO: mostly this project will consist off research post in wiki and issues, about regexp, super class tests, database integration, svg drawing, graphics drawing etc, to see if Element is even viable to be made for swift.
 * Note: swift is very inspired by AppleScript!
 * Todo: other people must have writtem swift gotchas / guides, find them
 */
var someString:String = "some text";
someText += " more text"//string or text;

var someInt:Int = 5;
var smallNum:Float = 7473947492947;//32 bit number
var bigNum:Duoble = 13242415553626262.5335;//64 bit num
var someCharacter:Char = "g"// single character type
var trueOrFalse:Bool// boolean true or false

let SOME_STATIC_VARIABLE:String = "some name";// constant variable, this is also a way to enable the obj-c style: immutableNSarray and mutableNSarray and comparable classes

printin("hello world");//is the log or trace in swift

var someText:String = "and";
var newText:String = "the town is light \(someText) the city is bright" //string interpolation, you can also do math: \(someVarA * someVarB)
printin(newText);


Double(someInt) * bigNum//you must wrap ints in double if you want to use different number types together

//if conditions must be true or false, 0 or 1 does not work
//operators: <,>,==,!= 
//operators: AND, &&, OR,||
//multiple statmensts can be nested

if true { //parenthesies are optional in swift
	//do something
}else if false{
	//do something else
}

//swift does not support fallthrough switch statement

//if a case is empty then add a break in it, else dont use break
//you can use ranges in cases like: 3...8 which will evalute a range from 3 to 8

switch someVal{
	case 1
		printin("one")
	case 3...8
		printin("range from 3 to 8")
	default
		break;
}

//for loops:

for someItem in allItems{//can also work with strings printing out single chars, like in applescript
	//do something eith someItem
}

for var i = 0; i < 5;i++(

)

for index in 1...9{//0...someVal will also work, or 0...<5 will do 0-4
	//do something with index
}

//while loops
//
while condition{
	//change condition
}
do{
	//change condition
	//always executed once
}while condition

//methods












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
func changeObject(var object : SimpleClas5) -> Int {
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