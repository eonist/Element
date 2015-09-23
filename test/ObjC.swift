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


//using nil values:

var myURL = NSURL(string:"http://www.lynda.com/index.html")
if myURL != nil {
	// forced unwrapping
	myURL!.lastPathComponent
}
//optional chaining:
myURL?.lastPathComponent

if let myotherURL = NSURL(string:"http://www.lynda.com/index.html") {
	myotherURL.lastPathComponent
}
