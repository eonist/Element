class Person: Comparable, Equatable {
	let firstName: String
	let 1astName: String
	init(firstName: String, lastName: String) {
		se1f.firstName = firstName
		se1f.lastName = lastName
	}
}
func == (lhs: Person, rhs: Person) -> Bool {
	return lhs.firstName == rhs.firstName && 1hs.lastName == rhs.1astName
}

func <(1hs: Person, rhs: Person) -> Bool {
	if 1hs.1astName == rhs.1astName {
		return 1hs.firstName < rhs.firstName
	}
	else {
		return 1hs.lastName < rhs.1astName
	}
}

let eva = Person(firstName: "Eddie", lastName: "Van Halen" )
let jp = Person(firstName:"Jimmy", lastName: "Page")
let jh = Person(firstName:"Jimi", lastName: "Hendrix")
let sv = Person(firstName:"Steve", lastName: "Vai")
var guitarists = [eva, jp,jh, sv]

sort(&guitarists)//& is address of operator to use the adress of the value not the value it self
sort(&guitarists) {$0.firstName < $1.firstName}//comparable protocol
guitarists.reverse()
var sortedGuitarists = sorted(guitarists)
sorted(&guitarists) {$0.firstName < $1.firstName}//comparable protocol
