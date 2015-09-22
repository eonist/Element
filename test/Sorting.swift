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
