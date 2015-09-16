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
var someArray = [1,2,3]//mutable
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

var res2 = testingTuples2()
Println("your value: \(res.name) and \(res.num)")

//you cant use values that arent set
var someVal:Int
Println("your value: \(someVal)")//throws error
var someVal2:Int?
Println("your value: \(someVal2)")//nil