![MIT Status](https://img.shields.io/badge/License-MIT-lightgrey.svg?maxAge=2592000) ![platform](https://img.shields.io/badge/os-macOS-blue.svg) ![Lang](https://img.shields.io/badge/Swift-3.0.1-orange.svg) [![SPM  compatible](https://img.shields.io/badge/SPM-compatible-orange.svg)](https://github.com/apple/swift-package-manager) [![codebeat](https://codebeat.co/badges/2de7a2a5-91d5-401e-8913-8f1993affd55)](https://codebeat.co/projects/github-com-eonist-element) [![Build Status](https://travis-ci.org/stylekit/Element-tests.svg?branch=master)](https://travis-ci.org/stylekit/Element-tests)

## What is it?
Independent UI framework with zero AppKit dependencies. Element lets you add rich UI interaction to your app.

<img width="608" alt="img" src="https://raw.githubusercontent.com/stylekit/img/master/progressindicator2_trim.mp4.gif">

## How does it work?
A typical Element app consists of 90% Swift code and 10% CSS and SVG. CSS Handles design and alignment and swift handles functionality and animation.   

<img width="700" alt="img" src="https://rawgit.com/stylekit/img/master/Style_diagram.svg">

## Installation:
- Read  [This](http://stylekit.org/blog/2017/02/05/Xcode-and-spm/)  tutorial on how to start a new App project from Swift Package Manager.
- Add this to your Package.swift file

```swift
import PackageDescription
let package = Package(
    name: "AwesomeApp",
    dependencies: [
		.Package(url: "https://github.com/eonist/Element.git", Version(0, 0, 0, prereleaseIdentifiers: ["alpha", "5"]))
    ]
)
```

- In AppDelegate.swift add this to the top ``@testable import Element`` and this inside the ``applicationDidFinishLaunching`` method:

```swift
StyleManager.addStyle("Button{fill:blue;}")
let btn = Button(100,20)
window.contentView!.addSubview(btn)
func onClick(event:Event){
	if(event.type == ButtonEvent.upInside){Swift.print("hello world")} 
}
btn.event = onClick
```
  
You can also compile Element as a regular .framework instructions [here](https://github.com/eonist/Element/wiki/framework-instructions) 

## Resources: 
- Simple example app made with Element: [Stash](https://github.com/stylekit/stash) 
- Library of example code for each component in Element: [Explorer](https://github.com/stylekit/explorer)  
- Default macOS styles to get you started: [ElCapitan](https://github.com/stylekit/ElCapitan)  

## iOS:
Element for 📱 is in the works [here](https://github.com/eonist/Element-iOS)   
<img width="186" alt="img" src="https://raw.githubusercontent.com/stylekit/img/master/switch8crop20fps.gif">  

## Progress:

**2017-mar** 
- List UI's are now POP (aka Protocol Oriented Programming)
- Elastic, Slidable and Scrollable protocols are introduced
- Converting from OOP to POP (aka shared inheritance) Aka no duplicate code!  

**2017-feb**  
- Improvements to SliderTreeList 
- Fixed slider positioning in sliderTreeList  
- Fixed margin error in TreeList  
- Significant improvements to RBSliderFastList, SliderFastList and FastList

## MileStones:
- FlexBox support
- FastTreeList component
- Smarter CSS caching algorithm

## More...
More about Element 👉 [wiki](https://github.com/eonist/Element/wiki) 

## Support
Please, don't hesitate to file an issue if you have questions.

## Sponsors:
[<img width="150" alt="img" src="https://rawgit.com/stylekit/img/master/appcode-logo.svg">
](https://www.jetbrains.com/objc/) 
