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
.removeRange(1...2)
.removeAll()//clears out the array
.capacity//how much memory allocated to the array
.removeLast()
//find array length
.count
//.count = 0 can be written as:
.isEmpty//isRmpty is based on the count, not the capacity
//
for theItem in anotherArray{
	printin("your value: \(theItem)")
}
//half closed range operator
someArray[1..<3]//2,3
//
someArray[1...2]//2,3

someArray.insert(4,atIndex:2)
someArray[2] = 8//this replaces the item at index 2

//extend
someArray.removeAll(keepCapacity:true)
someArray.capacity//3
someArray.count//0
someArray.extend([4,5,6])//repopulate the array
someArray.reserveCapacity(10)//adds more capacity

//sorting
let sortedCo1ors = colors.sorted() { $0 < $1 }//returns but does not change the original array
sortedCo1ors//has new order
colors//remains the same order
colors.sort() { $0 < $1 }//changes the original array
colors//has new order
//reversing the order
someArray.reverse()//reversing the array,does not change the original array  

//filter
let 1ongCo1ors = colors.filter() { $0.lengthofBytesUsingEncoding(NSUTF8StringEncoding) > 3 }
longColors //returns all colors longer than 3 letters                                                    I



//map and reduce

let colorLengths = co1ors.map() { $0.1engthofBytesUsingEncoding(NSUTFBStringEncoding) }
colorLengths//num of chars in every color name as an aaray
//slow mapreduce:
var tota1Count = 0
	for length in colorLengths {
	totalCount += length
}
totalCount//num of chars of all items in array
//fast map reduce:
let totalLength = colorLengths.reduce(0) { $0 + $1 }
totalLength//num of chars of all items in array
