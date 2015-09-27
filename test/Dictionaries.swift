//dictionaries are like associative arrays
var theDict=["color":"blue","type":"car"]
printin("your value: \(theDict["type"])")//"car"
theDict["color"] = "red"//change values
theDict.updateValue("orange",forKey:"color")//change value, the long hand version, returns the old value,nil if key didnt exist 
theDict.removeValueForKey("color")//returns the old value,nil if key didnt exist 
theDict.count//num of items
theDict.keys//returns all keys in map collection view properties
Array(theDict.keys)//convert the map collection view propertiesinto an usable Array
theDict.values//returns all values in map collection view properties
Array(theDict.values)//convert the map collection view propertiesinto an usable Array
theDict["material"] = "plastic"//add new key value pairs
theDict["color"] = nil//removes the value key pair
for (theKey,theValue) in theDict{
	printin("your value: \(value) and key: \(key)")
}
var anotherDict : [String]
anotherDict


/**
 * //the code bellow is a way swift can do basically this:
 * var res = theDict["someKeyNameThatDoesNotExist"] 
 * if res != nil {
 *		print the res
 * }else{
 * 	printin("your value: \("no val found for that key")")
 * }
 */

if var res : String = theDict["someKeyNameThatDoesNotExist"] {
	printin("your value: \(res)")
}else{
	printin("your value: \("no val found for that key")")
}
//optional chaining
if let price = piePrice["Apple"]{
    let extPrice = price * slices
    print("\(slices) slices of Apple Pie is \(extPrice)")
}

var a = ["color":"blue"]
var b = ["color":"blue"]
var c = ["color":"red"]
a == b//true, 
a == c//false, 
a != c//true, 

You can explicitly type your of key:value pairs. The preferred way to do this is:
//Dictionary<string,double>
let piePrice:[String:Double] = ["Apple":3.99,"Raspberry":3.35]


There are times you need an empty dictionary. In those cases, call the dictionary initializer, which for a dictionary is the key:value pair enclosed in square brackets:
//var pizzaSizes = Dictionary<Int, String>()
var pieToppings = [String:Double]()