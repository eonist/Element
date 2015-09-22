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

1
fund <(1hs: Person, rhs: Person) -> Bool {
if 1hs.1astName == rhs.1astName {
return 1hs.firstName < rhs.firstName
}
else {
return 1hs.lastName < rhs.1astName
}
}
