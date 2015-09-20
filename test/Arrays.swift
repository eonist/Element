//array
var someArray:Array = [1,2,3]//mutable
let stringArray = ["a","some","this"]//immutable
var anotherArray:[String]
anotherArray = ["abc","123"]
printin("your value: \(anotherArray[0])")//"abc"
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
	printin("your value: \(theItem)")
}