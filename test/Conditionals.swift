//if conditions must be true or false, 0 or 1 does not work
//operators: <,>,==,!= 
//operators: AND, &&, OR,||
//multiple statmensts can be nested

if true { //parenthesies are optional in swift
	//do something
}else if false{
	//do something else
}

//swift does not support fallthrough switch statement

//if a case is empty then add a break in it, else dont use break
//you can use ranges in cases like: 3...8 which will evalute a range from 3 to 8

switch someVal{
	case 1
		printin("one")
	case 3...8
		printin("range from 3 to 8")
	default
		break;
}

