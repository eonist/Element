[Progress](https://github.com/eonist/Element/wiki/Progress)  

**Element** (OSX UI Framework)

Element enables you to separate code and design while maintaining the ability to code natively. If you ever tried to style an NSButton programmatically, you usually end up with more code than its worth. Style an entire UI and you end up with thousands of custom lines of code sprinkled everywhere, which discourages rapid evolving and simple updates to the UI. Element uses a dialect of the CSS3 and SASS. Alignment of UI elements is achived through a custom **positioning alogorithm** that adheres to syntax such as "float:left" "clear:left" etc. Its also possible to programmatically override the CSS alignement scheme for elements you need more control over, like a slider element. Add your own iconography through .svg vector files from Adobe Illustrator etc. Element uses a custom built SVG drawing engine to achieve **infinitely scaleable graphic**s, so your apps will look great at any resolution. Further more Element is a self contained framework that doesn't rely on other third party libraries to work, other than swift it self. **Element 1.0** is already up and running, but it is currently being implemented in swift here on GitHub. 

One more thing...Element supports **multiple layers** of CSS3 styles. Meaning you can create any design you want. Stay tuned.

**Inline CSS**

```swift 
StyleManager.addStyle("Button{fill:blue;} Button:down{fill:red;}")//add a style to the StyleManager
addSubview(Button(self));//add button to view
```

**Add custom functionality**:

```swift 
addSubview(CustomButton(self));//add button to view

class CustomButton:Button{//create a new class with your custom functionality
	overide func down{
		print("Down from CustomButton")
	}
}
```
**Lets style CustomButton**:

```swift 
StyleManager.addStyle("CustomButton{fill:yellow;} CustomButton:down{fill:green;}")
```

**Example swift**

```swift
StyleManager.addStyle(File.resources.url + "assets/css/general.css");//call this one time to install all styles
			
var button = Button(self,96,24);//Create the button
addSubview(button)//add the button to the view
button.addTarget(self, action:"pressedAction:",event:.TouchUpInside)//add an event listener
		
func pressedAction(sender: Button!){//event handler
	print(sender.target)
}
```

**Example CSS** (OSX style button)

```css
Button{
	float:left;
	clear:left;
	fill:linear-gradient(top,#FFFEFE,#E8E8E8);
	corner-radius:4px;
	drop-shadow(0px 0 #000000 0.8 1.6 1.6 2 2 false);/*great for stroke like shadows*/;
}
Button:down{
	fill:linear-gradient(top,#BCD5EE 1 0.0087,#BAD4EE 1 0.0371,#B4CEEB 1 0.0473,#A8C4E7 1 0.0546,#98B6E0 1 0.0605,#98B5E0 1 0.0607,#96B4DF 1 0.2707,#8EB0DD 1 0.3632,#81A9DA 1 0.4324,#6EA0D6 1 0.4855,#538ECB 1 0.5087,#8ABBE3 1 0.8283,#A8D6EF 1 1);	
	drop-shadow(0px 0 #002D4E 0.8 1.6 1.6 2 2 false);/*same as SubtleShadow but with a blue tint*/
}
```

**Example App** (with default styles)  

![regular](https://cloud.githubusercontent.com/assets/11816788/10409978/73830764-6f33-11e5-9123-fc01cb294feb.png) 

**Different CSS file**

(same code, different .css files)  
![different](https://cloud.githubusercontent.com/assets/11816788/10409979/738342f6-6f33-11e5-9910-536762c9669c.png) 

**Basic Elements**

![Basic](https://cloud.githubusercontent.com/assets/11816788/10409976/737fe1b0-6f33-11e5-9f27-e787669d9cc1.png) 

**Advance Elements**

![Advance](https://cloud.githubusercontent.com/assets/11816788/10409977/7380294a-6f33-11e5-9aca-ffa48a5e46b6.png) 

**Other Elements**  

![Other](https://cloud.githubusercontent.com/assets/11816788/10409980/73849778-6f33-11e5-8c35-6d4ac668667f.png) 

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
- **Element is curently implimenting support for the OSX swift language**
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
