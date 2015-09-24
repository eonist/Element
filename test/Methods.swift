func someFunction(name:String,var key:String)->String{//params are constant by default, to make the mutable add the var infront of the param
	//doSomething
	key = key + "c"
	printin("hello, \(someText)")
	return key;
}
someFunction("test","ab")

//NOTE: can params have default values? yes but you must name them
some()
some(data:"testing")

class MethodTest{//pass a method via a para and execute it 
	let someMethod = {
		printin("your value: something")
	}
	
	func anotherMethod( theMethod : ()->() ){
		for i in 0...5 {
			theMethod()//performs this method 5 times
		}
	}
	anotherMethod(someMethod)
	anotherMethod({printin("hello")})//hello 5 times
}

//closure method passed to the sort method of swift:
func lowestToHighest(a:Int,b:Int)->Bool{
	return a < b;
}
//Nd then we convert this to a clouser method:
let lowToHigh{(a:Int,b:Int)->Bool in
	return a < b;
}

var someInts:[Int] = [500,63,99,23]
var sortedInts:[Int] = sorted(lowToHig)//sorts the ints

//method overloading:
// square function with Int argument
func square(value: Int) -> Int{
	println("Called square with Int argument: \(value)")
	return value * value
}
// square function with Double argument
func square(value: Double) -> Double{
	println("Called square with Double argument: \(value)")
	return value * value
}
// test overloaded square functions
println("Square of Int 7 is \(square(7))\n")
println("Square of Double 7.5 is \(square(7.5)))
