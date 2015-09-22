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


