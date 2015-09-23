

//NOTE: Syntax is a bit different: do-catch + try + defer vs traditional try-catch-finally syntax.
//NOTE: Swift exceptions are not compatible with ObjC exceptions. Your do-catch block will not catch any NSException, and vice versa, for that you must use ObjC.
//this line should normally be present do-catch block like this



do {
    try rideTheDragon(redDragon) 
} catch DragonError.DragonIsMissing {
    // Error-handling
} catch DragonError.NotEnoughMana(let manaRequired) {
    // More error-handlng
} catch {
    // Catch all error-handling
}



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
