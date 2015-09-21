//ints
var someInt:Int = 33
someInt.predessor()//32
someInt.successor()//34
someInt.advanceBy(2)//35,returns the value doesnt set the value
someInt.advanceBy(-2)//31,returns the value doesnt set the value
someInt.distanceTo(40)//7


var (result, overflowed) = Int.addWithoverflow(12, 34)
result 
overflowed
(result, overflowed) = Int.subtractWithoverflow(-128, 256)
result
overflowed
(result, overflowed) = Int.multiplyWithoverflow(128, 1024)
result
overflowed
(result, overflowed) = Int.divideWithoverflow(22, 7)
result
overflowed
Int.max
Int.min


(result, overflowed) = Int.multiplyWithoverflow(Int.max,
Int.max)
result
overflowed
Int8.min
IntB.max

Int16.min
Int16.max
Int32.min
Int32.max
Int64.min
Int64.max



//floats and doubles

let pi = 3.14159
let f_pi: Float = 3.141592
sizeofValue(pi)
sizeofValue(f_pi)
pi.advancedBy(1)
pi.advancedBy(-2)
pi.distanceTo(2.0)
Double.abs(2.0)
Double.abs(-2.0)
Float.abs(2.0)
Float.abs(-2.0)


