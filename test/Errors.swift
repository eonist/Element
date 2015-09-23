





//Alternatively in function that is itself marked with throws keyword like this

throws {
    try rideTheDragon(quest.dragon)
} 


//In order to throw an error you use throw keyword like this


throw DragonError.DragonIsMissing

enum DragonError: ErrorType {
    case DragonIsMissing
    case NotEnoughMana(manaRequired: Int)
    ...
}
