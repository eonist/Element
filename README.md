**Example swift:**

```swift
StyleManager.sharedInstance().addStyles(File.resources.url + "assets/css/general.css");//call this one time to install all styles
			
var button = Button(96,24,self);//Create the button
addChild(button)//add the button to the view
button.addTarget(self, action:"pressedAction:",event:.TouchUpInside)//add an event handler
		
func pressedAction(sender: Button!){
	print(sender.target)
}
```

**Example css: (OSX style button)**

```css
Button{
	float:left;
	clear:left;
	fill:linear-gradient(top,#FFFEFE,#E8E8E8);
	corner-radius:4px;
	drop-shadow:drop-shadow:drop-shadow(0px 0 #000000 0.8 1.6 1.6 2 2 false);/*great for stroke like shadows*/;
}
Button:down{
	fill:linear-gradient(top,#BCD5EE 1 0.0087,#BAD4EE 1 0.0371,#B4CEEB 1 0.0473,#A8C4E7 1 0.0546,#98B6E0 1 0.0605,#98B5E0 1 0.0607,#96B4DF 1 0.2707,#8EB0DD 1 0.3632,#81A9DA 1 0.4324,#6EA0D6 1 0.4855,#538ECB 1 0.5087,#8ABBE3 1 0.8283,#A8D6EF 1 1);	
	drop-shadow:drop-shadow:drop-shadow(0px 0 #002D4E 0.8 1.6 1.6 2 2 false);/*same as SubtleShadow but with a blue tint*/
}
```

###Goals
- Element supports basic needs, extention and decoration is encouraged for advance use
- Centralised styling via css (server side or embedded)
- Prototype custom GUI components with basic css knowledge
- Supports multiple style layers on any component part

###Scope
- Element basic components
- Advance components
- Test files
- Demo apps

###Notes:
- Element is curently implimenting support for the OSX swift language
- Element includes a custom built SVG engine, css engine, and vector draw engine.
- All code included is custom written for the Element project to avoid copyright conflicts
- Element is improved on a regular basis 

**Basic components:**
- Button
- SelectButton
- CheckButton
- CheckBoxButton
- RadioButton
- TextButton
- SelectTextButton
- List
- SliderList
- ComboBox
- VSlider,HSlider
- VNodeSlider,HNodeSlider
- Text
- TextArea
- TextInput
- Stepper
- LeverStepper
- Spinner
- LeverSpinner
- Window
- NodeSlider

**Advance components: (add as external folder)**
- Table (column,row) 
- TimePicker
- DatePicker
- NodeGraph (important)
- Calender
- AudioPlayer
- ScrubBar
- VideoPlayer
- ProgressBar

**Extra components: Extra path (add as external folder)**
- ColorPicker
- GradientPicker
- ToggleButton
- ToolTip
- ScrollBar
- NavigationBar (PathControl)
- Panel
- ResizePanel
- MovePanel
- HorizontalRuler
- VerticalRuler

**Todo:**
- [ ] Add support for targting 1th, 2nd child etc in css
- [ ] Support for dotted and dashed lines (you have code on how to do this)
- [ ] create date picker/calender (requires date classes)
- [ ] Element UML pdf
- [ ] R*-Trees are another way to spatially index objects to improve efficiency when dealing with very large data sets
- [ ] bsp-tree for storing large data sets?
- [ ] R*-Trees are able to efficiently store millions of objects.
- [ ] Optimize the css retrival system with inspiration from this book: quicksort, heapsort, hasing etc, better algos to find styles Cormen T.H., Leiserson C.E., Rivest R.L., Stein C. Introduction to Algorithms (3ed., MIT, 2009)(ISBN 262033845)
