class TuppleTest{
	//tuples almost like objects
	var someTuple = ("test",22,10.2,"abc")
	func testingTuples()->(String,Int){
		return ("test",55)
	}
	var res = testingTuples()
	printin("your value: \(res.0) and \(res.1)")
	var (name,num) = testingTuples()
	printin("your value: \(name) and \(num)")
	//named tuples. aka decomposing
	func testingTuples2()->(name:String,num:Int){//returns a tuple containing two values
		return ("test",55)
	}
	
	
	printin("your value: \(res.name) and \(res.num)")
	
	//you cant use values that arent set
	var someVal:Int
	printin("your value: \(someVal)")//throws error
	var someVal2:Int?//optional value the same as assigning = nil
	printin("your value: \(someVal2)")//nil
	someVal2 = 3
	if someVal2 != nil {
		printin("your value: \(someVal2!)")//forced unwrapping with !, you do this if you know the value isnt nil, even though it isnt assigned on init of the var
	}
}