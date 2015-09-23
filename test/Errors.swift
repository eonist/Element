

//NOTE: Syntax is a bit different: do-catch + try + defer vs traditional try-catch-finally syntax.
//NOTE: Swift exceptions are not compatible with ObjC exceptions. Your do-catch block will not catch any NSException, and vice versa, for that you must use ObjC.
//NOTE: guard statement (using guard keyword) which let you write little less if/else code than in normal error checking/signaling code.
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

//Excerpt From: Apple Inc. “Using Swift with Cocoa and Objective-C (Swift 2 Prerelease).” iBooks.
//Example: (from the book)

NSFileManager *fileManager = [NSFileManager defaultManager];
NSURL *URL = [NSURL fileURLWithPath:@"/path/to/file"];
NSError *error = nil;
BOOL success = [fileManager removeItemAtURL:URL error:&error];
if (!success && error){
    NSLog(@"Error: %@", error.domain);
}


//The equivalent in swift will be:

let fileManager = NSFileManager.defaultManager()
let URL = NSURL.fileURLWithPath("path/to/file")
do {
    try fileManager.removeItemAtURL(URL)
} catch let error as NSError {
    print ("Error: \(error.domain)")
}

//Throwing an Error:
//objc
*errorPtr = [NSError errorWithDomain:NSURLErrorDomain code:NSURLErrorCannotOpenFile userInfo: nil]
Will be automatically propagated to the caller:
//swift
throw NSError(domain: NSURLErrorDomain, code: NSURLErrorCannotOpenFile, userInfo: nil)


//From Apple books, The Swift Programming Language it's seems erros should be handle using enum.