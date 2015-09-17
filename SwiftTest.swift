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

println("hello world");//is the log or trace in swift

var someText:String = "and";
var newText:String = "the town is light \(someText) the city is bright" //string interpolation, you can also do math: \(someVarA * someVarB)
println(newText);


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
		println("one")
	case 3...8
		println("range from 3 to 8")
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


func someFunction(name:String,var key:String)->String{//params are constant by default, to make the mutable add the var infront of the param
	//doSomething
	key = key + "c"
	println("hello, \(someText)")
	return key;
}
someFunction("test","ab")

//NOTE: can params have default values? yes but you must name them
some()
some(data:"testing")


//array
var someArray:Array = [1,2,3]//mutable
let stringArray = ["a","some","this"]//immutable
var anotherArray:[String]
anotherArray = ["abc","123"]
Println("your value: \(anotherArray[0])")//"abc"
//adding items
anotherArray.append("test")
anotherArray += ["test"]
anotherArray.insert("hello",atIndex:2)
//remove
.removeAt(2)
.removeLast()
//find array length
.count
//.count = 0 can be written as:
.isEmpty
//
for theItem in anotherArray{
	Println("your value: \(theItem)")
}
//dictionaries aka associative arrays
var theDict=["color":"blue","type":"car"]
Println("your value: \(theDict["type"])")//"car"
theDict["color"] = "red"//change values
.updateValue("orange",forKey:"color")//change value, the long hand version, returns the old value,nil if key didnt exist 
theDict["material"] = "plastic"//add new key value pairs
theDict["color"] = nil//removes the value key pair
for (theKey,theValue) in theDict{
	Println("your value: \(value) and key: \(key)")
}
var anotherDict : [String]
anotherDict

//tuples almost like objects
var someTuple = ("test",22,10.2,"abc")
func testingTuples()->(String,Int){
	return ("test",55)
}
var res = testingTuples()
Println("your value: \(res.0) and \(res.1)")
var (name,num) = testingTuples()
Println("your value: \(name) and \(num)")
//named tuples. aka decomposing
func testingTuples2()->(name:String,num:Int){
	return ("test",55)
}


Println("your value: \(res.name) and \(res.num)")

//you cant use values that arent set
var someVal:Int
Println("your value: \(someVal)")//throws error
var someVal2:Int?//optional value the same as assigning = nil
Println("your value: \(someVal2)")//nil
someVal2 = 3
if someVal2 != nil {
	Println("your value: \(someVal2!)")//forced unwrapping with !, you do this if you know the value isnt nil, even though it isnt assigned on init of the var
}
/**
 * //the code bellow is a way swift can do basically this:
 * var res = theDict["someKeyNameThatDoesNotExist"] 
 * if res != nil {
 *		print the res
 * }else{
 * 	Println("your value: \("no val found for that key")")
 * }
 */

if var res : String = theDict["someKeyNameThatDoesNotExist"] {
	Println("your value: \(res)")
}else{
	Println("your value: \("no val found for that key")")
}
//enumerations:
//enums are simple classes that can be used like this:

enum CarsType{
	case Tractor
	case Sports
	case Sedan
	//or case Tractor, Sports,Sedan
}

var johnLikes:CarType
johnLikes = CarType.Sedan
johnLikes = .Sedan

switch johnLikes{
	case .Sedan
		Println("he likes sedan")
	case .Sports
		Println("he likes sport cars")
	case .Tractor
		Println("he likes tractors")
	default
		break;
}

//execute a method via a parameter

let someMethod = {
	Println("your value: something")
}

func anotherMethod( theMethod : ()->() ){
	for i in 0...5 {
		theMethod()//performs this method 5 times
	}
}
anotherMethod(someMethod)
anotherMethod({Println("hello")})//hello 5 times

//closure method passed to the sort method of swift:
func lowestToHighest(a:Int,b:Int)->Bool{
	return a < b;
}
//convert this to a clouser method:
let lowToHig{(a:Int,b:Int)->Bool in
	return a < b;
}

var someInts:[Int] = [500,63,99,23]
var sortedInts:[Int] = sorted(lowToHig)//sorts the ints

//classes:
class Person{
	//properties accessabøe outside a class:
	var name:String = "Paul"//values must be set if you use a class aka initialized
	let age:Int = 77;
	/**
 	 * NOTE: initializers are optional you can still use this object without passing params
	 */
	func init(name:String,age:Int){//class initializer w/ params
		self.name = name;//self refers to properties outside the method bit inside the class, aka this in other languages
		self.age = age;
	}
	//methods accessable outside a class:
	func desc()->String{
		return name + ", " + age
	}
	func deinit(){//system calls this method when an object is not used anymor
		//usefull if you need to close a connection to a database at the end of a lifetime of the ojb etc
		//needs more research
	}
}


newPerson.name = "Pete"
newPerson.age = 25
Println("your value: \(newPerson.desc())")

//
/**
 * class inheritance: super class and sub class
 * NOTE: if you mark a class final like:"final class Employee" then it cant be overriden by inheritance
 */
 class Employee:Person{
 	var sallary:Int
 	var firstName:String = "Jo"
 	var lastName:String = "Socrates"
 	lazy var bonus : Int = calcBonus()//lazy makes the prop not init it self before something tries to access it. think of it almost as a method with a return var, his is just a handy way of doing things, nothing revolutionary
 	//property observere
 	var nickName:String = "Joey"{
 		willSet{//called before you set a value
 			Println("your value: \(newValue)")
 		}
 		didSet(oldNickName){//called after you set a value, the oldNickName enables you to rename the default oldValue
 			Println("your value: \(oldNickName)")
 		}
 	}
 	overide init(sallery:Int){
 		self.sallery = sallery;
 		
 		super.init()
 	}
 	func calcBonus()->Int{
		return 5+2
	}		
 	overide func desc()->String{
 		return super.description + " " + sallery
 	}
 	final func sallery()->Int{//final methods cant be overridden, but are still accesible from outside the class
		return sallary
	}
	/**
	 * computed properties, aka getters and setters?
 	 */
 
 	var fullName:String {
	 	get{//getter
			 return firstName + " " + lastName 	
	 	}
		set{//setter
			 var fullNameArray = newValue.componentsSeperatedByString(" ")//newValue is the value you resive from the setter
			 firstName = fullNameArray[0]
			 lastName = fullNameArray[1]
	 	}
	 }
	 var occupation:String{//same as getter just "shorthand"
	 	return = "Quant"
	 }
 }
 var sammy:Employee = Employee(name:"Sammy")
 Println("your value: \(sammy.sallery)")
 Println("your value: \(sammy.desc)")
 Println("your value: \(sammy.fullName)")
 /**
 * public static constant methods and properties:

 */
 class StringUtil{
 	class var STRING_UTIL_NAME = "string util"//this is what is typically refered to as a public staic constant in other languages and is accessible from the class it self, not instances of it
 	/**
 	 * Returns a list of text items by splitting a text at every delimiter
	 */
	class func split(string, delimiter)->Array{
		return string.componentsSeperatedByString(delimiter)
	}
	/**
 	* NOTE: you cant access instance level variables when using public static constants
	 */
	class func name(){
		return STRING_UTIL_NAME
	}
 }
StringUtil.name//string util
StringUtil.split("abc 123"," ")[0]//"123"

//Access levels in Swift 
//private only accessible from within the same source code file 
//internal This is the default accessible across multiple code files, but must be compiled together into the same module 
//public accessible from any module that has imported yours 

//Changing access levels public 
class Player {
//properties no modifier, will default to internal 
var name: String 
var score Int 
//public methods 
public func description {
	printin ("Player V (name) has a score of V (score)") 

}
	private methods 
	private func calculateBonus {
	
	}
	
	}