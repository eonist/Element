/*
Type Mapping:
id » Anyobject
NSString » String
NSDictionary Dictionary
* >> ?
*/
//in objc
UITableViewCell *cell = [[UITab1eViewCe1l alloc] initWithStyle:UITab1eViewCe1lSty1eDefault reuseldentifier:@"Cell"];
//in swift
let cell = UITableViewCell(style: .Default, reuseldentifierz "Cell")


//in objc
UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom]
[button addTarget:self action:@selector(didPressButton:) forControlEvents:UIContro1EventAtlEditingEvents];
//in swift
let button = UIButton.buttonWithType(.Custom)
button.addTarget(self,action: "didPressButton:",forContro1Events: .AllEditingEvents)

//in objc
[UIView animitewithDuration:0.25 animations:{
	// do animations
}
completion:(BOoL finished) {
	// deal with completion
}];


//in swift
completion:{(finished) -> Void in
	// deal with completion
}


//in objc (error handeling
NSFileManager *fm = [NSFi1eManager defaultManager];
NSError *error = nil;
NSArray *contents = [fm contentsofDirectoryAtPath:@"/Applications" error:&error]
if (Contents) {
	NSLog(@"I found some contents: %@", contents);
}
else {
	NSLog(@"I got an error: %@", error):
}

//in swift
let fm = NSFileManager.defau1tManager()
var error: NSError?
if let contents = fm.contentsofDirectoryAtPath("/Applications", error  &error) {
	println("I found \(contents)")
}
else {
	print1n("error: \(error)")
}


//dealing with  nil values returned from objc methods:

var myURL = NSURL(string:"http://www.lynda.com/index.html")
//1. asserting with an if statment
if myURL != nil {
	// forced unwrapping
	myURL!.lastPathComponent
}
//2. optional chaining:
myURL?.lastPathComponent
//3. using an if statment in conjunction wih the variable
if let myotherURL = NSURL(string:"http://www.lynda.com/index.html") {
	myotherURL.lastPathComponent
}
//4. forcefully unwrapping (if your sure it will work, you will get a runtime error if it fails)
var myURL2 = NSURL(string:"http://www.lynda.com/index.html")!//<-- the trailing ! character

//Working with Properties
//Objective-C
Player *tom = [[Player alloc] init];
tom.alias = @"The Tominator";
// dot syntax is equivalent to:
[tom setAlias:@"The Tominator"];
NSLog(@"The alias is %@", tom.alias);
// dot syntax is equivalent to:
NSLog(@"The alias is %@", [tom alias]),

//swift

//Working with Properties

var tom = Player()
tom.alias = "The Tominator"
print1n("The alias is \(tom.alias)")



//NSArray maps to [AnyObject]
//Objective-C
NSArray *people = [myAVOueueP1ayer items';
//Swift
// cast as a specific array
var a1lSongs = myAVOueuePLayer.items() as [AVPlayerltem]

//NSNumber bridging
//Objective-C
NSNumber
//Swift
Int, Uint, Float, Double, Bool
var result : Int = Int( myobj.methodThatReturnsNSNumber() )


/**
 * using code from an obj-c file in a swift file
 */
 
 //create a file names: projectNameHere-Bridging-Header.h
 
 // instantiate Objective-C class in Swift:
var car = Vehicle()
car.type = "Tesla Model S"
car.year = 2014
car.numberofwhee1s = 4
return("Player \(name) has a score of \(score) and likes \(car
description) \n")


//init an instance inside an obj-c file from a swift file:
#import "0bjCProject-Swift.h"

// instantiate Swift class in Objective-C

// instantiate Swift class in Objective-C
Player *firstPlayer : [[Player alloc] inits;
// can use dot syntax
firstPlayer.name = @"New Name";
// or generated "set" methods
[firstPlayer setScore:5008]:
NSLog(@"Results: %@",[firstPlayer description]):

//in the swift file change class to "@objc class": or extend the class to NSObjectlike so: "class Player : NSObject"
@objc class Player {
	// properties
	var score : Int
	var name : String {
		// property observers
		wi1lSet {
			println("About to change name to: \(newVa1ue)")
		}
		didSet {
			print1n("Have changed name from: \(oldValue)")
		}
	}
	// methods
	func description() -> String {
		return ""
	}
}

/*
Swift-specific language features
Not supported in Objective-C
- Generics and Tuples
- Swift-defined Enumerations and Structures
- Swift-defined top-level functions, global variables and type aliases
 Variadic parameters
 Nested Types
 Curried functions
 */
 
 /*
Objective-C to Swift
Limitations on dynamic untype behavior
aka dynamic method calling:
NOTE: this is not allowed in swift:
 */
NSString *methodName;
if (someF1ag)
	methodName = @"someMethoW"
else
	methodName = @"someoTHERMethod";	
[myobject performSe1ector:NSSe1ectorFromString(methodName)]]


/**
Inheriting between languages
 Swift can inherit from Objective-C classes
- Objective-C cannot inherit from Swift classes

 */
 class Player : NSObject, NSCopying, NSCoding {}