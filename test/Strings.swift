var someStr:String = "abc 123"
someStr.isEmpty //false
someStr.hasPrefix("abc")//true
someStr.hasSuffix("123")//true

var anotherStr = "66"
anotherStr.toInt()//some int
var theInt = anotherInt.toInt() as? Int//this unwraps the variable and assigns it, 
//the better solution would be to do:
var theInt = anotherInt.toInt() ?? 0//whoch would set the theInt to 0 of the anotherStr.toInt() doesnt yield an int

var thirdStr = "test"
thirdStr += "abc"//concat the string

//NOTE: you can concat a vhar and a string
var theChar:Character = "a"
var theChar2:Character = "b"
theChar + theChar2//yields a string containing "ab", 

//comparing strings
"a" == "b"//false
"a" != "b"//true
//the bang operator:
!("a" == "b"//true)
"a" < "b"//true. a is lexically less than b, there is no greater than operator, use the bang operator for this support

//NOTE: be aware of the limitations of methods suxh as the .componentsSeparatedByString, in that ot will return an nsimmutable string, which you can only read from, to get a string you can edit do the following:
"/Users/alex/Desktop".componentsSeparatedByString("/")
let mutable = NSMutab1eString(string: "He1lo")
mutable.appendString(" There!")
print1n(mutable)

var letters: [Character] = ["c", "a", "f", "e"]
var string: String = String(letters)

print(letters.count) // 4
print(string) // cafe
print(string.characters.count) // 4