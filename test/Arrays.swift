//array
var someArray:Array = [1,2,3]//mutable
let stringArray = ["a","some","this"]//immutable
var anotherArray:[String]
anotherArray = ["abc","123"]
printin("your value: \(anotherArray[0])")//"abc"
//adding items
anotherArray.append("test")
//plus equal mutating operator,concatinates 2 arrays, 
//non array items wont work
//the items we concat are restricted by the same types that the oroginal array had
anotherArray += ["test"]

anotherArray.insert("hello",atIndex:2)
//remove at index
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
//half closed range operator
someArray[1..<3]//2,3
//
someArray[1..2]//2,3

someArray.insert(4,atIndex:2)
someArray.[2] = 8//this replaces the item at index 2
