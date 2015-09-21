var someStr:String = "abc 123"
someStr.isEmpty //false
someStr.hasPrefix("abc")//true
someStr.hasSuffix("123")//true

var anotherStr = "66"
anotherStr.toInt()//some int
var theInt = anotherInt.toInt() as? Int//this unwraps the variable and assigns it, 
//the better solution would be to do:
var theInt = anotherInt.toInt() ?? 0//whoch would set the theInt to 0 of the anotherStr.toInt() doesnt yield an int
