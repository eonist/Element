```swift
StyleManager.getInstance().addStylesByURL(File.applicationDirectory.url + "assets/css/general.css");
			
var button:Button = Button(width:96,height:24,self);
addChild(Button)
button.addTarget(self,, action:"onbuttonDown:",event:.TouchUpInside);
		
func pressedAction(sender: Button!){
	print("sender.target: " + sender.target);
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
