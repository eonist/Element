![MIT Status](https://img.shields.io/badge/License-MIT-lightgrey.svg?maxAge=2592000) ![platform](https://img.shields.io/badge/os-macOS-blue.svg) ![Lang](https://img.shields.io/badge/Swift-3.0.1-orange.svg) [![SPM  compatible](https://img.shields.io/badge/SPM-compatible-orange.svg)](https://github.com/apple/swift-package-manager) [![codebeat](https://codebeat.co/badges/2de7a2a5-91d5-401e-8913-8f1993affd55)](https://codebeat.co/projects/github-com-eonist-element) [![Build Status](https://travis-ci.org/stylekit/Element-tests.svg?branch=master)](https://travis-ci.org/stylekit/Element-tests)

# Element
<img width="200" alt="img" src="https://rawgit.com/stylekit/img/master/Element3_1-01.svg">

### What?
Programmatic UI Framework for macOS

<img width="608" alt="img" src="https://raw.githubusercontent.com/stylekit/img/master/progressindicator2_trim.mp4.gif">

### How does it work?
Swift handles app logic and CSS/SVG handles design. 

### Installation:
**Step 1:** Add this to your Package.swift [Tutorial](http://stylekit.org/blog/2017/02/05/Xcode-and-spm/)

```swift
import PackageDescription
let package = Package(
    name: "AwesomeApp",
    dependencies: [
	   .Package(url: "https://github.com/eonist/Element.git", Version(0, 0, 0, prereleaseIdentifiers: ["alpha", "5"]))
    ]
)
```

**Step 2:** In AppDelegate.swift add this to the top ``@testable import Element`` and this inside the ``applicationDidFinishLaunching`` method:

```swift
StyleManager.addStyle("Button{fill:blue;}")
let btn = Button(100,20)
window.contentView = FlippedView()/*TopLeft orientation*/
window.contentView?.addSubview(btn)
btn.event = { event in
   if(event.type == ButtonEvent.upInside){Swift.print("hello world")} 
}
```

You can also compile Element as a regular .framework instructions [here](https://github.com/eonist/Element/wiki/framework-instructions) 

### Resources: 
- Simple example app made with Element: [Stash](https://github.com/stylekit/stash) 
- Library of example code for each component in Element: [Explorer](https://github.com/stylekit/explorer)  
- Default macOS styles to get you started: [ElCapitan](https://github.com/stylekit/ElCapitan)  

### iOS:
Element for 📱 is in the works [here](https://github.com/eonist/Element-iOS)   
<img width="186" alt="img" src="https://raw.githubusercontent.com/stylekit/img/master/switch8crop20fps.gif">  

## More...
More about Element 👉 [wiki](https://github.com/eonist/Element/wiki) 

## Sponsors:
[<img width="150" alt="img" src="https://rawgit.com/stylekit/img/master/appcode-logo.svg">
](https://www.jetbrains.com/objc/) 
