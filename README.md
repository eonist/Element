<img width="200" alt="img" src="https://dl.dropboxusercontent.com/u/2559476/stylekit_logo_400x400_1.png">  

## Introduction:
Element is a [programatic UI framework](https://github.com/eonist/Element/wiki/What-is-a-programatic-UI) for OSX. You can use **native swift** code to add functionality to the provided UI components or create your own custom UI components. The OSX 10.10 styles are provided by default, add your own styles through [SVG](http://stylekit.org/blog/2016/01/07/Basic-SVG-support/)  and [CSS](http://stylekit.org/blog/2016/02/18/Cascading-Style-Sheets-System/) syntax. Or use the Style class. Element is written in pure native swift code and uses [Quartz and Core Graphics](http://stylekit.org/blog/2015/12/30/Graphic-framework-for-OSX/) to render the UI components. Element is not a JS + web-wrapper. Element does not use Xcode Interface builder. Although support is possible. Element is not a UI prototype framework or tool, Element is intended for production code in professional apps where **design & interaction freedom** is important.

<img width="1055" alt="img" src="https://dl.dropboxusercontent.com/u/2559476/Screen Shot 2016-03-17 at 21.10.40.png">  

<img width="456" alt="img" src="https://dl.dropboxusercontent.com/u/2559476/demo_app_30_fps_1x.gif">  
High-res 60FPS version of the above Gif-anim here: [vimeo](https://vimeo.com/158515887)  or [dropbox](https://dl.dropboxusercontent.com/u/2559476/demo_app_60fps_full.mov)

### Live Edit feature:

<img width="448" alt="img" src="https://dl.dropboxusercontent.com/u/2559476/live_edit_3.jpg">

[vimeo](https://vimeo.com/162281545) 

### GradientPanel:

<img width="475" alt="img" src="https://dl.dropboxusercontent.com/u/2559476/Screen Shot 2016-04-07 at 10.05.43.png">

[vimeo](https://vimeo.com/161915498) 

### ColorPanel:

<img width="453" alt="img" src="https://dl.dropboxusercontent.com/u/2559476/Screen Shot 2016-04-05 at 11.43.25.png">

[vimeo](https://vimeo.com/162236240) 

### RBSliderList:  
  
<img width="516" alt="img" src="https://dl.dropboxusercontent.com/u/2559476/list_full_quality.mov.gif">  

[Case study](http://stylekit.org/blog/2016/03/08/Rubber-band-slider-list/)   

### CheckBoxButton:

<img width="554" alt="img" src="https://dl.dropboxusercontent.com/u/2559476/checkBoxButton.mov.gif">

[Case study](http://stylekit.org/blog/2016/02/13/Check-box-button/) 

### LeverSpinner:  

<img width="550" alt="img" src="https://dl.dropboxusercontent.com/u/2559476/leverSpinner_1_x14hs.gif">

[Case study](http://stylekit.org/blog/2016/02/09/The-lever-spinner/)  

### RadioBullet:

<img width="500" alt="img" src="https://dl.dropboxusercontent.com/u/2559476/radiobullets_crop_low.gif">

[Case study](http://stylekit.org/blog/2016/01/27/The-Radiobullet/) 

### Window:  

<img width="432" alt="img" src="https://dl.dropboxusercontent.com/u/2559476/custom_win.gif">

 [Case study](http://stylekit.org/blog/2016/01/23/Chromeless-window/)
 
### Icon bar:  

<img width="474" alt="task-bar-animation" src="https://dl.dropboxusercontent.com/u/2559476/the_icon_bar_anim_x2p.gif">

 [Case study](http://stylekit.org/blog/2016/01/22/The-Icon-Bar/)   
 
### TitleBar:  

<img width="240" alt="img" src="https://dl.dropboxusercontent.com/u/2559476/titlebar_buttons_anim.gif">  

 [Case study](http://stylekit.org/blog/2016/01/20/Layered-Graphics/)   

### TabBar:  
  
<img width="240" alt="img" src="https://dl.dropboxusercontent.com/u/2559476/2f289u9384f34.gif">  
  
 [Case study](https://github.com/eonist/Element/wiki/Progress#tabbar)      

### Graphics Drawing: 
<img width="650" alt="img" src="https://dl.dropboxusercontent.com/u/2559476/Screen Shot 2015-12-26 at 10.30.58.png">  
Read more about the above Graphics framework case [here](http://stylekit.org/blog/2015/12/30/Graphic-framework-for-OSX/)  


## Description (programatic UI Framework for OSX)

Element enables you to separate code and design while maintaining the ability to code natively. If you ever tried to style an NSButton programmatically, you usually end up with more code than its worth. Style an entire UI and you end up with thousands of custom lines of code sprinkled everywhere, which discourages rapid evolving and simple updates to the UI. Element uses a dialect of the CSS3 and SASS. Alignment of UI elements is achieved through a custom **positioning algorithm** that adheres to syntax such as "float:left" "clear:left" etc. Its also possible to programmatically override the CSS alignment scheme for elements you need more control over, like a slider element. Add your own iconography through .svg vector files from Adobe Illustrator etc. Element uses a custom built SVG drawing engine to achieve **infinitely scaleable graphic**s, so your apps will look great at any resolution. Further more Element is a self contained framework that doesn't rely on other third party libraries to work, other than swift it self. **Element 1.0** is already up and running, but it is currently being implemented in swift here on GitHub. 

One more thing...Element supports **multiple layers** of CSS3 styles. Meaning anything you can design in Adobe Illustrator can be used on a single UI Element. Stay tuned.

One more thing...Element now has support for [rich interactive animation in 60FPS](http://stylekit.org/blog/2016/02/24/CVDisplayLink/) (The first ever swift UI framework that offers this, not even apple has this) [Here is the first app example that uses this Animation-engine](https://vimeo.com/158515887)

One more thing...Element now has "Live Edit" [vimeo](https://vimeo.com/162281545) 

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
StyleManager.addStyle(File.resources.url + "assets/css/general.css");//call this one time to install all default styles
			
var button = addSubview(Button(96,24,self))/*Create and add the button to the view*/
button.event = onEvent/*add an event listener*/
		
func onEvent(event:Event){/*event handler*/
	print(event.origin)//Output: button
}
```
[Read about the event system](http://stylekit.org/blog/2016/02/10/The-event-system/)   


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

[MIT License](http://opensource.org/licenses/MIT) 

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
- Element includes a custom built SVG engine, css engine, and vector draw engine  
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
- [x] Create the RBScrollBar,RBSlider,RBScrollTextArea,RBScrollList,RBScrollTreeList (RB = Rubber band)
- [ ] List has a mask, this mask could possibly be an Element (the current soloution works but is not elegant)
- [ ] R*-Trees are able to efficiently store millions of objects.
- [ ] Optimize the css retrival system with inspiration from this book: quicksort, heapsort, hasing etc, better algos to find styles Cormen T.H., Leiserson C.E., Rivest R.L., Stein C. Introduction to Algorithms (3ed., MIT, 2009)(ISBN 262033845)


[Twitter](https://twitter.com/stylekit_org)  
