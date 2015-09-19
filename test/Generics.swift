//Generics
//NOTE: generics are better than using any or anyobject in that they keep the type that was passed to them

class SimpleC1ass {
	var singleProperty : String = "A string"
}
let myInts  = [123,456,789,345,678,234]
let myStrings = ["red","green","blue"]
let myobjects = [SimpleClass(),SimpleClass(),SimpleClass()]
func displayArray<T>(theArray : [T]) -> T {
	println(Printing the array:)
	for eachitem in theArray {
		print(eachitem)
		print("  :  ")
	}
	println()
	let finalElement : T = theArray[theArray.count-1]
	return finalElement
}
var finalInt = displayArray(myInts)
++finalInt
var finalString = displayArray(myStrings)
finalString.uppercaseString

