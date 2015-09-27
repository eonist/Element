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
/**
 * If your dictionary is a constant, you know exactly what’s there. In that case, a forced unwrap like above is fine. If you have a dictionary where you may add or delete elements from the dictionary, make sure you check for nil.
 */
if piePrice["Apple"] != nil {
    let extPrice = piePrice["Apple"]! * slices
    print("\(slices) slices of Apple Pie is \(extPrice)")
}

//or more compactly with optional chaining
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

for myValue  in toppings.values{
    print ("Value =  \(myValue)")
}
for (myKey,myValue) in toppings {
    print("\(myKey) \t \(myValue)")
}
//make a 10% price increase
for myKey  in toppings.keys{
    toppings[myKey] = toppings[myKey]! * 1.10
}


/**
 * Sometimes we need an array of the keys or values, since a particular API requires an array. We can use the .keys or .values to create an array:
 */
var valuesArray = [Double](toppings.values)