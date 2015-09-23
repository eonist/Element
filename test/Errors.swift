

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


//From Apple books, The Swift Programming Language it's seems erros should be handle using enum
enum ServerResponse {
    case Result(String, String)
    case Error(String)
}

let success = ServerResponse.Result("6:00 am", "8:09 pm")
let failure = ServerResponse.Error("Out of cheese.")

switch success {
case let .Result(sunrise, sunset):
    let serverResponse = "Sunrise is at \(sunrise) and sunset is at \(sunset)."
case let .Error(error):
    let serverResponse = "Failure...  \(error)"
}



//Excerpt From: Apple Inc. “Using Swift with Cocoa and Objective-C.” iBooks. https://itun.es/br/1u3-0.l

//And the books also encourage you to use cocoa error pattern from Objective-C (NSError Object)

Error reporting in Swift follows the same pattern it does in Objective-C, with the added benefit of offering optional return values. In the simplest case, you return a Bool value from the function to indicate whether or not it succeeded. When you need to report the reason for the error, you can add to the function an NSError out parameter of type NSErrorPointer. This type is roughly equivalent to Objective-C’s NSError **, with additional memory safety and optional typing. You can use the prefix & operator to pass in a reference to an optional NSError type as an NSErrorPointer object, as shown in the code listing below.
var writeError : NSError?
let written = myString.writeToFile(path, atomically: false,
    encoding: NSUTF8StringEncoding,
    error: &writeError)
if !written {
    if let error = writeError {
        println("write failure: \(error.localizedDescription)")
    }
}


//In development, you can use assert to catch any errors which might appear, and need to be fixed before going to production.
//The classic NSError approach isn't altered, you send an NSErrorPointer, which gets populated.
//Brief example:

var error: NSError?
var contents = NSFileManager.defaultManager().contentsOfDirectoryAtPath("/Users/leandros", error: &error)
if let error = error {
    println("An error occurred \(error)")
} else {
    println("Contents: \(contents)")
}

